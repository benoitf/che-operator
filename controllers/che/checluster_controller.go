//
// Copyright (c) 2019-2021 Red Hat, Inc.
// This program and the accompanying materials are made
// available under the terms of the Eclipse Public License 2.0
// which is available at https://www.eclipse.org/legal/epl-2.0/
//
// SPDX-License-Identifier: EPL-2.0
//
// Contributors:
//   Red Hat, Inc. - initial API and implementation
//

package che

import (
	"context"
	"time"

	"github.com/eclipse-che/che-operator/pkg/deploy"
	"github.com/eclipse-che/che-operator/pkg/deploy/dashboard"
	devworkspace "github.com/eclipse-che/che-operator/pkg/deploy/dev-workspace"
	"github.com/eclipse-che/che-operator/pkg/deploy/devfileregistry"
	"github.com/eclipse-che/che-operator/pkg/deploy/gateway"
	imagepuller "github.com/eclipse-che/che-operator/pkg/deploy/image-puller"
	"github.com/eclipse-che/che-operator/pkg/deploy/migration"
	openshiftoauth "github.com/eclipse-che/che-operator/pkg/deploy/openshift-oauth"
	"github.com/eclipse-che/che-operator/pkg/deploy/pluginregistry"
	"github.com/eclipse-che/che-operator/pkg/deploy/postgres"
	"github.com/eclipse-che/che-operator/pkg/deploy/rbac"
	"github.com/eclipse-che/che-operator/pkg/deploy/server"
	"github.com/eclipse-che/che-operator/pkg/deploy/tls"

	identity_provider "github.com/eclipse-che/che-operator/pkg/deploy/identity-provider"
	"github.com/eclipse-che/che-operator/pkg/util"
	"github.com/go-logr/logr"
	routev1 "github.com/openshift/api/route/v1"
	"github.com/sirupsen/logrus"
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	k8sruntime "k8s.io/apimachinery/pkg/runtime"
	"k8s.io/client-go/discovery"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/builder"
	"sigs.k8s.io/controller-runtime/pkg/client"
	"sigs.k8s.io/controller-runtime/pkg/event"
	"sigs.k8s.io/controller-runtime/pkg/handler"
	"sigs.k8s.io/controller-runtime/pkg/predicate"
	"sigs.k8s.io/controller-runtime/pkg/reconcile"
	"sigs.k8s.io/controller-runtime/pkg/source"

	orgv1 "github.com/eclipse-che/che-operator/api/v1"
	networking "k8s.io/api/networking/v1"
	"k8s.io/apimachinery/pkg/api/errors"
)

// CheClusterReconciler reconciles a CheCluster object
type CheClusterReconciler struct {
	Log    logr.Logger
	Scheme *k8sruntime.Scheme

	// This client, initialized using mgr.Client() above, is a split client
	// that reads objects from the cache and writes to the apiserver
	client client.Client

	// This client, is a simple client
	// that reads objects without using the cache,
	// to simply read objects thta we don't intend
	// to further watch
	nonCachedClient client.Client
	// A discovery client to check for the existence of certain APIs registered
	// in the API Server
	discoveryClient  discovery.DiscoveryInterface
	tests            bool
	reconcileManager *deploy.ReconcileManager
	// the namespace to which to limit the reconciliation. If empty, all namespaces are considered
	namespace string
}

// NewReconciler returns a new CheClusterReconciler
func NewReconciler(
	k8sclient client.Client,
	noncachedClient client.Client,
	discoveryClient discovery.DiscoveryInterface,
	scheme *k8sruntime.Scheme,
	namespace string) *CheClusterReconciler {

	reconcileManager := deploy.NewReconcileManager()

	// order does matter
	if !util.IsTestMode() {
		reconcileManager.RegisterReconciler(migration.NewMigrator())
		reconcileManager.RegisterReconciler(NewCheClusterValidator())
	}
	reconcileManager.RegisterReconciler(imagepuller.NewImagePuller())

	openShiftOAuthUser := openshiftoauth.NewOpenShiftOAuthUser()
	reconcileManager.RegisterReconciler(openShiftOAuthUser)
	reconcileManager.RegisterReconciler(openshiftoauth.NewOpenShiftOAuth(openShiftOAuthUser))
	reconcileManager.RegisterReconciler(tls.NewCertificatesReconciler())
	reconcileManager.RegisterReconciler(tls.NewTlsSecretReconciler())
	reconcileManager.RegisterReconciler(devworkspace.NewDevWorkspaceReconciler())
	reconcileManager.RegisterReconciler(rbac.NewCheServerPermissionsReconciler())
	reconcileManager.RegisterReconciler(rbac.NewGatewayPermissionsReconciler())
	reconcileManager.RegisterReconciler(rbac.NewWorkspacePermissionsReconciler())

	return &CheClusterReconciler{
		Scheme: scheme,
		Log:    ctrl.Log.WithName("controllers").WithName("CheCluster"),

		client:           k8sclient,
		nonCachedClient:  noncachedClient,
		discoveryClient:  discoveryClient,
		namespace:        namespace,
		reconcileManager: reconcileManager,
	}
}

// SetupWithManager sets up the controller with the Manager.
func (r *CheClusterReconciler) SetupWithManager(mgr ctrl.Manager) error {
	isOpenShift := util.IsOpenShift

	onAllExceptGenericEventsPredicate := predicate.Funcs{
		UpdateFunc: func(evt event.UpdateEvent) bool {
			return true
		},
		CreateFunc: func(evt event.CreateEvent) bool {
			return true
		},
		DeleteFunc: func(evt event.DeleteEvent) bool {
			return true
		},
		GenericFunc: func(evt event.GenericEvent) bool {
			return false
		},
	}

	var toTrustedBundleConfigMapRequestMapper handler.MapFunc = func(obj client.Object) []ctrl.Request {
		isTrusted, reconcileRequest := IsTrustedBundleConfigMap(r.nonCachedClient, r.namespace, obj)
		if isTrusted {
			return []ctrl.Request{reconcileRequest}
		}
		return []ctrl.Request{}
	}

	var toEclipseCheRelatedObjRequestMapper handler.MapFunc = func(obj client.Object) []ctrl.Request {
		isEclipseCheRelatedObj, reconcileRequest := IsEclipseCheRelatedObj(r.nonCachedClient, r.namespace, obj)
		if isEclipseCheRelatedObj {
			return []ctrl.Request{reconcileRequest}
		}
		return []ctrl.Request{}
	}

	controllerBuilder := ctrl.NewControllerManagedBy(mgr).
		// Watch for changes to primary resource CheCluster
		Watches(&source.Kind{Type: &orgv1.CheCluster{}}, &handler.EnqueueRequestForObject{}).
		// Watch for changes to secondary resources and requeue the owner CheCluster
		Watches(&source.Kind{Type: &corev1.Service{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &corev1.Secret{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &corev1.ConfigMap{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &rbacv1.Role{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &rbacv1.RoleBinding{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &corev1.ServiceAccount{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &appsv1.Deployment{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &corev1.PersistentVolumeClaim{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		}).
		Watches(&source.Kind{Type: &corev1.ConfigMap{}},
			handler.EnqueueRequestsFromMapFunc(toTrustedBundleConfigMapRequestMapper),
			builder.WithPredicates(onAllExceptGenericEventsPredicate),
		).
		Watches(&source.Kind{Type: &corev1.Secret{}},
			handler.EnqueueRequestsFromMapFunc(toEclipseCheRelatedObjRequestMapper),
			builder.WithPredicates(onAllExceptGenericEventsPredicate),
		).
		Watches(&source.Kind{Type: &corev1.ConfigMap{}},
			handler.EnqueueRequestsFromMapFunc(toEclipseCheRelatedObjRequestMapper),
			builder.WithPredicates(onAllExceptGenericEventsPredicate),
		)

	if isOpenShift {
		controllerBuilder = controllerBuilder.Watches(&source.Kind{Type: &routev1.Route{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		})
	} else {
		controllerBuilder = controllerBuilder.Watches(&source.Kind{Type: &networking.Ingress{}}, &handler.EnqueueRequestForOwner{
			IsController: true,
			OwnerType:    &orgv1.CheCluster{},
		})
	}

	if r.namespace != "" {
		controllerBuilder = controllerBuilder.WithEventFilter(util.InNamespaceEventFilter(r.namespace))
	}

	return controllerBuilder.
		For(&orgv1.CheCluster{}).
		Complete(r)
}

// Reconcile is part of the main kubernetes reconciliation loop which aims to
// move the current state of the cluster closer to the desired state.
//
// For more details, check Reconcile and its Result here:
// - https://pkg.go.dev/sigs.k8s.io/controller-runtime@v0.9.5/pkg/reconcile
func (r *CheClusterReconciler) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
	_ = r.Log.WithValues("checluster", req.NamespacedName)

	clusterAPI := deploy.ClusterAPI{
		Client:           r.client,
		NonCachingClient: r.nonCachedClient,
		DiscoveryClient:  r.discoveryClient,
		Scheme:           r.Scheme,
	}

	// Fetch the CheCluster instance
	checluster, err := r.GetCR(req)

	if err != nil {
		if errors.IsNotFound(err) {
			// Request object not found, could have been deleted after reconcile request.
			// Owned objects are automatically garbage collected. For additional cleanup logic use finalizers.
			// Return and don't requeue
			return ctrl.Result{}, nil
		}
		// Error reading the object - requeue the request.
		return ctrl.Result{}, err
	}

	deployContext := &deploy.DeployContext{
		ClusterAPI: clusterAPI,
		CheCluster: checluster,
	}

	// Read proxy configuration
	proxy, err := GetProxyConfiguration(deployContext)
	if err != nil {
		r.Log.Error(err, "Error on reading proxy configuration")
		return ctrl.Result{}, err
	}
	deployContext.Proxy = proxy

	// Detect whether self-signed certificate is used
	isSelfSignedCertificate, err := tls.IsSelfSignedCertificateUsed(deployContext)
	if err != nil {
		r.Log.Error(err, "Failed to detect if self-signed certificate used.")
		return ctrl.Result{}, err
	}
	deployContext.IsSelfSignedCertificate = isSelfSignedCertificate

	if isCheGoingToBeUpdated(checluster) {
		// Current operator is newer than deployed Che
		backupCR, err := getBackupCRForUpdate(deployContext)
		if err != nil {
			if errors.IsNotFound(err) {
				// Create a backup before updating current installation
				if err := requestBackup(deployContext); err != nil {
					return ctrl.Result{}, err
				}
				// Backup request is successfully submitted
				// Give some time for the backup
				return ctrl.Result{RequeueAfter: time.Second * 15}, nil
			}
			return ctrl.Result{}, err
		}
		if backupCR.Status.State == orgv1.STATE_IN_PROGRESS || backupCR.Status.State == "" {
			// Backup is still in progress
			return ctrl.Result{RequeueAfter: time.Second * 5}, nil
		}
		// Backup is done or failed
		// Proceed anyway
	}

	if deployContext.CheCluster.ObjectMeta.DeletionTimestamp.IsZero() {
		result, done, err := r.reconcileManager.ReconcileAll(deployContext)
		if !done {
			return result, err
			// TODO: uncomment when all items added to ReconcilerManager
			// } else {
			// 	logrus.Info("Successfully reconciled.")
			// 	return ctrl.Result{}, nil
		}
	} else {
		r.reconcileManager.FinalizeAll(deployContext)
	}

	// Reconcile finalizers before CR is deleted
	// TODO remove in favor of r.reconcileManager.FinalizeAll(deployContext)
	r.reconcileFinalizers(deployContext)

	if err := r.GenerateAndSaveFields(deployContext); err != nil {
		_ = deploy.ReloadCheClusterCR(deployContext)
		return ctrl.Result{Requeue: true, RequeueAfter: time.Second * 1}, err
	}

	if !deployContext.CheCluster.Spec.Database.ExternalDb {
		postgres := postgres.NewPostgres(deployContext)
		done, err := postgres.SyncAll()
		if !done {
			if err != nil {
				logrus.Error(err)
			}
			return ctrl.Result{}, err
		}
	}

	// we have to expose che endpoint independently of syncing other server
	// resources since che host is used for dashboard deployment and che config map
	server := server.NewServer(deployContext)
	done, err := server.ExposeCheServiceAndEndpoint()
	if !done {
		if err != nil {
			logrus.Error(err)
		}
		return ctrl.Result{}, err
	}

	// create and provision Keycloak related objects
	if !checluster.Spec.Auth.ExternalIdentityProvider {
		provisioned, err := identity_provider.SyncIdentityProviderToCluster(deployContext)
		if !provisioned {
			if err != nil {
				logrus.Errorf("Error provisioning the identity provider to cluster: %v", err)
			}
			return ctrl.Result{}, err
		}
	} else {
		keycloakURL := checluster.Spec.Auth.IdentityProviderURL
		if checluster.Status.KeycloakURL != keycloakURL {
			checluster.Status.KeycloakURL = keycloakURL
			if err := deploy.UpdateCheCRStatus(deployContext, "status: Keycloak URL", keycloakURL); err != nil {
				return reconcile.Result{}, err
			}
		}
	}

	devfileRegistry := devfileregistry.NewDevfileRegistry(deployContext)
	if !checluster.Spec.Server.ExternalDevfileRegistry {
		done, err := devfileRegistry.SyncAll()
		if !done {
			if err != nil {
				logrus.Error(err)
			}
			return ctrl.Result{}, err
		}
	}

	if !checluster.Spec.Server.ExternalPluginRegistry {
		pluginRegistry := pluginregistry.NewPluginRegistry(deployContext)
		done, err := pluginRegistry.SyncAll()
		if !done {
			if err != nil {
				logrus.Error(err)
			}
			return ctrl.Result{}, err
		}
	} else {
		if checluster.Spec.Server.PluginRegistryUrl != checluster.Status.PluginRegistryURL {
			checluster.Status.PluginRegistryURL = checluster.Spec.Server.PluginRegistryUrl
			if err := deploy.UpdateCheCRStatus(deployContext, "status: Plugin Registry URL", checluster.Spec.Server.PluginRegistryUrl); err != nil {
				return reconcile.Result{}, err
			}
		}
	}

	d := dashboard.NewDashboard(deployContext)
	done, err = d.Reconcile()
	if !done {
		if err != nil {
			logrus.Errorf("Error provisioning '%s' to cluster: %v", d.GetComponentName(), err)
		}
		return ctrl.Result{}, err
	}

	err = gateway.SyncGatewayToCluster(deployContext)
	if err != nil {
		logrus.Errorf("Failed to create the Server Gateway: %s", err)
		return ctrl.Result{}, err
	}

	done, err = server.SyncAll()
	if !done {
		if err != nil {
			logrus.Error(err)
		}
		return reconcile.Result{}, err
	}

	// we can now try to create consolelink, after che instance is available
	done, err = deploy.ReconcileConsoleLink(deployContext)
	if !done {
		if err != nil {
			logrus.Error(err)
		}
		// We should `Requeue` since we created cluster object
		return ctrl.Result{RequeueAfter: time.Second}, err
	}

	// Delete OpenShift identity provider if OpenShift oAuth is false in spec
	// but OpenShiftoAuthProvisioned is true in CR status, e.g. when oAuth has been turned on and then turned off
	deleted, err := identity_provider.ReconcileIdentityProvider(deployContext)
	if deleted {
		// ignore error
		deploy.DeleteFinalizer(deployContext, deploy.OAuthFinalizerName)
		for {
			checluster.Status.OpenShiftoAuthProvisioned = false
			if err := deploy.UpdateCheCRStatus(deployContext, "status: provisioned with OpenShift identity provider", "false"); err != nil &&
				errors.IsConflict(err) {
				_ = deploy.ReloadCheClusterCR(deployContext)
				continue
			}
			break
		}
		for {
			checluster.Spec.Auth.OAuthSecret = ""
			checluster.Spec.Auth.OAuthClientName = ""
			if err := deploy.UpdateCheCRStatus(deployContext, "clean oAuth secret name and client name", ""); err != nil &&
				errors.IsConflict(err) {
				_ = deploy.ReloadCheClusterCR(deployContext)
				continue
			}
			break
		}
	}

	logrus.Info("Successfully reconciled.")
	return ctrl.Result{}, nil
}

func (r *CheClusterReconciler) reconcileFinalizers(deployContext *deploy.DeployContext) {
	if util.IsOpenShift && deployContext.CheCluster.IsOpenShiftOAuthEnabled() {
		if err := deploy.ReconcileOAuthClientFinalizer(deployContext); err != nil {
			logrus.Error(err)
		}
	}

	if err := deploy.ReconcileConsoleLinkFinalizer(deployContext); err != nil {
		logrus.Error(err)
	}

	if !deployContext.CheCluster.ObjectMeta.DeletionTimestamp.IsZero() {
		done, err := dashboard.NewDashboard(deployContext).Finalize()
		if !done {
			logrus.Error(err)
		}
	}
}

func (r *CheClusterReconciler) GetCR(request ctrl.Request) (instance *orgv1.CheCluster, err error) {
	instance = &orgv1.CheCluster{}
	err = r.client.Get(context.TODO(), request.NamespacedName, instance)
	if err != nil {
		r.Log.Error(err, "Failed to get %s CR: %s", "Cluster name", instance.Name)
		return nil, err
	}
	return instance, nil
}
