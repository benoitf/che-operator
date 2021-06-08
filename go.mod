module github.com/eclipse-che/che-operator

go 1.15

require (
	github.com/che-incubator/kubernetes-image-puller-operator v0.0.0-20210428110012-14ef54b7dbf4
	github.com/go-logr/logr v0.4.0
	github.com/golang/mock v1.5.0
	github.com/google/go-cmp v0.5.2
	github.com/openshift/api v3.9.1-0.20190924102528-32369d4db2ad+incompatible
	github.com/operator-framework/api v0.8.0
	github.com/operator-framework/operator-lifecycle-manager v0.18.1
	github.com/sirupsen/logrus v1.7.0
	go.uber.org/zap v1.13.0
	golang.org/x/net v0.0.0-20210226172049-e18ecbb05110
	gopkg.in/tomb.v2 v2.0.0-20161208151619-d5d1b5820637 // indirect
	k8s.io/api v0.21.0
	k8s.io/apiextensions-apiserver v0.20.6
	k8s.io/apimachinery v0.21.0
	k8s.io/client-go v12.0.0+incompatible
	sigs.k8s.io/controller-runtime v0.8.3
	sigs.k8s.io/yaml v1.2.0
)

replace (
	cloud.google.com/go => cloud.google.com/go v0.54.0
	cloud.google.com/go/bigquery => cloud.google.com/go/bigquery v1.4.0
	cloud.google.com/go/datastore => cloud.google.com/go/datastore v1.2.0
	cloud.google.com/go/pubsub => cloud.google.com/go/pubsub v1.2.0
	cloud.google.com/go/storage => cloud.google.com/go/storage v1.5.0
	github.com/Azure/go-ansiterm => github.com/Azure/go-ansiterm v0.0.0-20170929234023-d6e3b3328b78
	github.com/Azure/go-autorest => github.com/Azure/go-autorest v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/autorest => github.com/Azure/go-autorest/autorest v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/autorest/adal => github.com/Azure/go-autorest/autorest/adal v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/autorest/date => github.com/Azure/go-autorest/autorest/date v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/autorest/mocks => github.com/Azure/go-autorest/autorest/mocks v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/logger => github.com/Azure/go-autorest/logger v0.0.0-20200908233159-fafe600ec8bd
	github.com/Azure/go-autorest/tracing => github.com/Azure/go-autorest/tracing v0.0.0-20200908233159-fafe600ec8bd
	github.com/BurntSushi/toml => github.com/BurntSushi/toml v0.3.1
	github.com/BurntSushi/xgb => github.com/BurntSushi/xgb v0.0.0-20160522181843-27f122750802
	github.com/MakeNowJust/heredoc => github.com/MakeNowJust/heredoc v0.0.0-20171113091838-e9091a26100e
	github.com/Masterminds/semver => github.com/Masterminds/semver v1.5.0
	github.com/Masterminds/semver/v3 => github.com/Masterminds/semver/v3 v3.0.3
	github.com/Masterminds/sprig/v3 => github.com/Masterminds/sprig/v3 v3.0.2
	github.com/NYTimes/gziphandler => github.com/NYTimes/gziphandler v1.0.1
	github.com/OneOfOne/xxhash => github.com/OneOfOne/xxhash v1.2.2
	github.com/PuerkitoBio/purell => github.com/PuerkitoBio/purell v1.1.1
	github.com/PuerkitoBio/urlesc => github.com/PuerkitoBio/urlesc v0.0.0-20160726150825-5bd2802263f2
	github.com/alecthomas/template => github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751
	github.com/alecthomas/units => github.com/alecthomas/units v0.0.0-20190717042225-c3de453c63f4
	github.com/antihax/optional => github.com/antihax/optional v0.0.0-20180407024304-ca021399b1a6
	github.com/armon/circbuf => github.com/armon/circbuf v0.0.0-20150827004946-bbbad097214e
	github.com/armon/go-metrics => github.com/armon/go-metrics v0.0.0-20180917152333-f0300d1749da
	github.com/armon/go-radix => github.com/armon/go-radix v0.0.0-20180808171621-7fddfc383310
	github.com/asaskevich/govalidator => github.com/asaskevich/govalidator v0.0.0-20190424111038-f61b66f89f4a
	github.com/auth0/go-jwt-middleware => github.com/auth0/go-jwt-middleware v0.0.0-20170425171159-5493cabe49f7
	github.com/aws/aws-sdk-go => github.com/aws/aws-sdk-go v0.0.0-20210122191723-2c7b39c8f2e2
	github.com/bazelbuild/buildtools => github.com/bazelbuild/buildtools v0.0.0-20181120164953-0b76442a60b6
	github.com/beorn7/perks => github.com/beorn7/perks v1.0.1
	github.com/bgentry/speakeasy => github.com/bgentry/speakeasy v0.1.0
	github.com/bitly/go-hostpool => github.com/bitly/go-hostpool v0.0.0-20191224193725-5d3b4dc6ed47
	github.com/bitly/go-simplejson => github.com/bitly/go-simplejson v0.0.0-20171023175154-0c965951289c
	github.com/blang/semver/v4 => github.com/blang/semver/v4 v4.0.0
	github.com/cenkalti/backoff => github.com/cenkalti/backoff v2.1.1+incompatible
	github.com/census-instrumentation/opencensus-proto => github.com/census-instrumentation/opencensus-proto v0.2.1
	github.com/cespare/xxhash => github.com/cespare/xxhash v1.1.0
	github.com/cespare/xxhash/v2 => github.com/cespare/xxhash/v2 v2.1.0
	github.com/checkpoint-restore/go-criu => github.com/checkpoint-restore/go-criu v0.0.0-20190109184317-bdb7599cd87b
	github.com/cheekybits/genny => github.com/cheekybits/genny v0.0.0-20180830150346-d2cf3cdd35ce
	github.com/cncf/udpa/go => github.com/cncf/udpa/go v0.0.0-20200327203949-e8cd3a4bb307
	github.com/cockroachdb/datadriven => github.com/cockroachdb/datadriven v0.0.0-20190809214429-80d97fb3cbaa
	github.com/codegangsta/negroni => github.com/codegangsta/negroni v1.0.0
	github.com/container-storage-interface/spec => github.com/container-storage-interface/spec v1.1.0
	github.com/containerd/cgroups => github.com/containerd/cgroups v0.0.0-20191002205938-3de5a6bb4823
	github.com/containerd/console => github.com/containerd/console v0.0.0-20180822173158-c12b1e7919c1
	github.com/containerd/fifo => github.com/containerd/fifo v0.0.0-20190226154929-a9fb20d87448
	github.com/containerd/go-runc => github.com/containerd/go-runc v0.0.0-20180907222934-5a6d9f37cfa3
	github.com/coreos/bbolt => github.com/coreos/bbolt v1.3.3
	github.com/creack/pty => github.com/creack/pty v1.1.9
	github.com/davecgh/go-spew => github.com/davecgh/go-spew v1.1.1
	github.com/deislabs/oras => github.com/deislabs/oras v0.8.1
	github.com/denisenkom/go-mssqldb => github.com/denisenkom/go-mssqldb v0.0.0-20190204142019-df6d76eb9289
	github.com/dgrijalva/jwt-go => github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/docker/docker-credential-helpers => github.com/docker/docker-credential-helpers v0.6.3
	github.com/docopt/docopt-go => github.com/docopt/docopt-go v0.0.0-20180111231733-ee0de3bc6815
	github.com/dustin/go-humanize => github.com/dustin/go-humanize v1.0.0
	github.com/edsrzf/mmap-go => github.com/edsrzf/mmap-go v0.0.0-20181215214921-188cc3b666ba
	github.com/elazarl/goproxy => github.com/elazarl/goproxy v0.0.0-20180725130230-947c36da3153
	github.com/emicklei/go-restful => github.com/emicklei/go-restful v0.0.0-20200129102538-a2fa14558f9a
	github.com/envoyproxy/go-control-plane => github.com/envoyproxy/go-control-plane v0.0.0-20200213201256-ba8e577f987f
	github.com/envoyproxy/protoc-gen-validate => github.com/envoyproxy/protoc-gen-validate v0.1.0

	github.com/exponent-io/jsonpath => github.com/exponent-io/jsonpath v0.0.0-20151013193312-d6023ce2651d
	github.com/fortytw2/leaktest => github.com/fortytw2/leaktest v1.3.0
	github.com/fsnotify/fsnotify => github.com/fsnotify/fsnotify v1.4.7
	github.com/ghodss/yaml => github.com/ghodss/yaml v0.0.0-20150909031657-73d445a93680
	github.com/go-ini/ini => github.com/go-ini/ini v1.25.4
	github.com/go-kit/kit => github.com/go-kit/kit v0.8.0
	github.com/go-logr/logr => github.com/go-logr/logr v0.3.0
	github.com/go-logr/zapr => github.com/go-logr/zapr v0.3.0
	github.com/go-openapi/errors => github.com/go-openapi/errors v0.19.2
	github.com/go-openapi/jsonpointer => github.com/go-openapi/jsonpointer v0.19.3
	github.com/go-openapi/jsonreference => github.com/go-openapi/jsonreference v0.19.3
	github.com/go-openapi/spec => github.com/go-openapi/spec v0.19.3
	github.com/go-openapi/strfmt => github.com/go-openapi/strfmt v0.19.5
	github.com/go-openapi/swag => github.com/go-openapi/swag v0.19.5
	github.com/go-playground/universal-translator => github.com/go-playground/universal-translator v0.17.0
	github.com/go-sql-driver/mysql => github.com/go-sql-driver/mysql v1.4.1
	github.com/go-stack/stack => github.com/go-stack/stack v1.8.0
	github.com/gobuffalo/envy => github.com/gobuffalo/envy v1.7.0
	github.com/gobwas/glob => github.com/gobwas/glob v0.2.3
	github.com/gofrs/uuid => github.com/gofrs/uuid v3.2.0+incompatible
	github.com/gogo/protobuf => github.com/gogo/protobuf v1.3.2
	github.com/golang-migrate/migrate/v4 => github.com/golang-migrate/migrate/v4 v4.10.0
	github.com/golang-sql/civil => github.com/golang-sql/civil v0.0.0-20190719163853-cb61b32ac6fe
	github.com/golang/glog => github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b
	github.com/golang/groupcache => github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e
	github.com/golang/mock => github.com/golang/mock v1.5.0
	github.com/golang/protobuf => github.com/golang/protobuf v1.4.3
	github.com/golang/snappy => github.com/golang/snappy v0.0.1
	github.com/google/btree => github.com/google/btree v1.0.0
	github.com/google/go-cmp => github.com/google/go-cmp v0.5.2
	github.com/google/go-github => github.com/google/go-github/v18 v18.0.0-20180920013327-07716bad7a0c
	github.com/google/go-querystring => github.com/google/go-querystring v1.0.0
	github.com/google/gofuzz => github.com/google/gofuzz v0.0.0-20161122191042-44d81051d367
	github.com/google/martian => github.com/google/martian v0.0.0-20180813215018-c223d6f7955e
	github.com/google/pprof => github.com/google/pprof v0.0.0-20180921154107-7dadf64105bb
	github.com/google/renameio => github.com/google/renameio v0.1.0
	github.com/google/uuid => github.com/google/uuid v1.1.2
	github.com/googleapis/gax-go/v2 => github.com/googleapis/gax-go/v2 v2.0.5
	github.com/googleapis/gnostic => github.com/googleapis/gnostic v0.4.2
	github.com/gophercloud/gophercloud => github.com/gophercloud/gophercloud v0.1.0
	github.com/gopherjs/gopherjs => github.com/gopherjs/gopherjs v0.0.0-20200217142428-fce0ec30dd00
	github.com/gorilla/context => github.com/gorilla/context v1.1.1
	github.com/gorilla/mux => github.com/gorilla/mux v1.7.2
	github.com/gorilla/websocket => github.com/gorilla/websocket v1.4.2
	github.com/gosuri/uitable => github.com/gosuri/uitable v0.0.4
	github.com/gregjones/httpcache => github.com/gregjones/httpcache v0.0.0-20180305231024-9cad4c3443a7
	github.com/grpc-ecosystem/go-grpc-middleware => github.com/grpc-ecosystem/go-grpc-middleware v1.1.0
	github.com/grpc-ecosystem/go-grpc-prometheus => github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0
	github.com/hailocab/go-hostpool => github.com/hailocab/go-hostpool v0.0.0-20160125115350-e80d13ce29ed
	github.com/hashicorp/errwrap => github.com/hashicorp/errwrap v1.0.0
	github.com/hashicorp/go-cleanhttp => github.com/hashicorp/go-cleanhttp v0.5.1
	github.com/hashicorp/go-immutable-radix => github.com/hashicorp/go-immutable-radix v1.0.0
	github.com/hashicorp/go-msgpack => github.com/hashicorp/go-msgpack v0.5.5
	github.com/hashicorp/go-rootcerts => github.com/hashicorp/go-rootcerts v1.0.1
	github.com/hashicorp/go-syslog => github.com/hashicorp/go-syslog v1.0.0
	github.com/hashicorp/go-uuid => github.com/hashicorp/go-uuid v1.0.1
	github.com/hashicorp/go-version => github.com/hashicorp/go-version v1.1.0
	github.com/hashicorp/golang-lru => github.com/hashicorp/golang-lru v0.5.1
	github.com/hashicorp/hcl => github.com/hashicorp/hcl v1.0.0
	github.com/hashicorp/mdns => github.com/hashicorp/mdns v1.0.0
	github.com/hashicorp/memberlist => github.com/hashicorp/memberlist v0.1.3
	github.com/hpcloud/tail => github.com/hpcloud/tail v1.0.0
	github.com/huandu/xstrings => github.com/huandu/xstrings v1.2.0
	github.com/imdario/mergo => github.com/imdario/mergo v0.3.5
	github.com/inconshreveable/mousetrap => github.com/inconshreveable/mousetrap v1.0.0
	github.com/influxdata/influxdb1-client => github.com/influxdata/influxdb1-client v0.0.0-20191209144304-8bf82d3c094d
	github.com/jessevdk/go-flags => github.com/jessevdk/go-flags v1.4.0
	github.com/jmespath/go-jmespath => github.com/jmespath/go-jmespath v0.3.0
	github.com/jonboulle/clockwork => github.com/jonboulle/clockwork v0.1.0
	github.com/json-iterator/go => github.com/json-iterator/go v0.0.0-20200608025830-a1ca0830781e
	github.com/jstemmer/go-junit-report => github.com/jstemmer/go-junit-report v0.9.1
	github.com/jtolds/gls => github.com/jtolds/gls v0.0.0-20150401064343-9a4a02dbe491
	github.com/julienschmidt/httprouter => github.com/julienschmidt/httprouter v1.2.0
	github.com/karrick/godirwalk => github.com/karrick/godirwalk v1.10.12
	github.com/kisielk/errcheck => github.com/kisielk/errcheck v1.2.0
	github.com/kisielk/gotool => github.com/kisielk/gotool v1.0.0
	github.com/klauspost/cpuid => github.com/klauspost/cpuid v0.0.0-20170728055534-ae7887de9fa5
	github.com/konsorten/go-windows-terminal-sequences => github.com/konsorten/go-windows-terminal-sequences v1.0.1
	github.com/kr/pretty => github.com/kr/pretty v0.0.0-20200729040243-ead452280cd0
	github.com/kr/pty => github.com/kr/pty v0.0.0-20180113180813-282ce0e5322c
	github.com/kylelemons/godebug => github.com/kylelemons/godebug v1.1.0
	github.com/leodido/go-urn => github.com/leodido/go-urn v0.0.0-20201213191625-6c96508144d0
	github.com/lib/pq => github.com/lib/pq v0.0.0-20190415174712-51e2106eed1c
	// github.com/kr/text v0.2.0 => github.com/kr/text v0.2.0 todo
	github.com/mailru/easyjson => github.com/mailru/easyjson v0.0.0-20200218084223-8edcc4e51f39
	github.com/marstr/guid => github.com/marstr/guid v1.1.0
	github.com/mattn/go-colorable => github.com/mattn/go-colorable v0.1.7
	github.com/mattn/go-isatty => github.com/mattn/go-isatty v0.0.3
	github.com/mattn/go-runewidth => github.com/mattn/go-runewidth v0.0.9
	github.com/mattn/go-shellwords => github.com/mattn/go-shellwords v0.0.0-20180201004752-39dbbfa24bbc
	github.com/mattn/go-sqlite3 => github.com/mattn/go-sqlite3 v0.0.0-20190716055609-b612a2feea6a
	github.com/matttproud/golang_protobuf_extensions => github.com/matttproud/golang_protobuf_extensions v1.0.2-0.20181231171920-c182affec369
	github.com/mindprince/gonvml => github.com/mindprince/gonvml v0.0.0-20190828220739-9ebdce4bb989
	github.com/mistifyio/go-zfs => github.com/mistifyio/go-zfs v2.1.1+incompatible
	github.com/mitchellh/cli => github.com/mitchellh/cli v1.0.0
	github.com/mitchellh/copystructure => github.com/mitchellh/copystructure v1.0.0
	github.com/mitchellh/go-homedir => github.com/mitchellh/go-homedir v1.1.0
	github.com/mitchellh/go-testing-interface => github.com/mitchellh/go-testing-interface v1.0.0
	github.com/mitchellh/go-wordwrap => github.com/mitchellh/go-wordwrap v1.0.0
	github.com/mitchellh/gox => github.com/mitchellh/gox v0.4.0
	github.com/mitchellh/hashstructure => github.com/mitchellh/hashstructure v1.0.0
	github.com/mitchellh/mapstructure => github.com/mitchellh/mapstructure v1.1.2
	github.com/mitchellh/reflectwalk => github.com/mitchellh/reflectwalk v1.0.1
	github.com/modern-go/concurrent => github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd
	github.com/modern-go/reflect2 => github.com/modern-go/reflect2 v1.0.1
	github.com/munnerz/goautoneg => github.com/munnerz/goautoneg v0.0.0-20120707110453-a547fc61f48d
	github.com/mvdan/xurls => github.com/mvdan/xurls v0.0.0-20151024194657-cd316b55634f
	github.com/mwitkow/go-conntrack => github.com/mwitkow/go-conntrack v0.0.0-20161129095857-cc309e4a2223
	github.com/naoina/go-stringutil => github.com/naoina/go-stringutil v0.1.0
	github.com/nats-io/jwt => github.com/nats-io/jwt v0.3.2
	github.com/nats-io/nats.go => github.com/nats-io/nats.go v1.9.1
	github.com/nats-io/nkeys => github.com/nats-io/nkeys v0.1.3
	github.com/nats-io/nuid => github.com/nats-io/nuid v1.0.1
	github.com/ncw/swift => github.com/ncw/swift v1.0.47
	github.com/oklog/run => github.com/oklog/run v1.0.0
	github.com/oklog/ulid => github.com/oklog/ulid v1.3.1
	github.com/onsi/ginkgo => github.com/onsi/ginkgo v1.11.0
	github.com/onsi/gomega => github.com/onsi/gomega v1.7.0
	github.com/openshift/api => github.com/openshift/api v0.0.0-20190924102528-32369d4db2ad
	github.com/opentracing/basictracer-go => github.com/opentracing/basictracer-go v1.0.0
	github.com/opentracing/opentracing-go => github.com/opentracing/opentracing-go v1.1.0
	github.com/openzipkin/zipkin-go => github.com/openzipkin/zipkin-go v0.2.2
	github.com/pborman/uuid => github.com/pborman/uuid v1.2.0
	github.com/pelletier/go-toml => github.com/pelletier/go-toml v1.4.0
	github.com/peterbourgon/diskv => github.com/peterbourgon/diskv v0.0.0-20180312054125-0646ccaebea1
	github.com/pierrec/lz4 => github.com/pierrec/lz4 v0.0.0-20180610162716-6b9367c9ff40
	github.com/pkg/errors => github.com/pkg/errors v0.0.0-20200114194744-614d223910a1
	github.com/pkg/profile => github.com/pkg/profile v0.0.0-20180809112205-057bc52a47ec
	github.com/pmezard/go-difflib => github.com/pmezard/go-difflib v1.0.0
	github.com/posener/complete => github.com/posener/complete v1.1.1
	github.com/pquerna/cachecontrol => github.com/pquerna/cachecontrol v0.0.0-20171018203845-0dec1b30a021
	github.com/pquerna/ffjson => github.com/pquerna/ffjson v0.0.0-20171002144729-d49c2bc1aa13
	github.com/prometheus/procfs => github.com/prometheus/procfs v0.2.0
	github.com/prometheus/prometheus => github.com/prometheus/prometheus v0.0.0-20180315085919-58e2a31db8de
	github.com/robfig/cron => github.com/robfig/cron v1.1.0
	github.com/rogpeppe/fastuuid => github.com/rogpeppe/fastuuid v0.0.0-20150106093220-6724a57986af

	github.com/rogpeppe/go-internal => github.com/rogpeppe/go-internal v1.3.0
	github.com/rubenv/sql-migrate => github.com/rubenv/sql-migrate v0.0.0-20200616145509-8d140a17f351
	github.com/russross/blackfriday => github.com/russross/blackfriday v1.5.2
	github.com/russross/blackfriday/v2 => github.com/russross/blackfriday/v2 v2.0.0-20160712163229-e96880f42b93
	github.com/ryanuber/columnize => github.com/ryanuber/columnize v0.0.0-20160712163229-9b3edd62028f
	github.com/satori/go.uuid => github.com/satori/go.uuid v1.2.0
	github.com/sean-/seed => github.com/sean-/seed v0.0.0-20170313163322-e2103e2c3529
	github.com/seccomp/libseccomp-golang => github.com/seccomp/libseccomp-golang v0.0.0-20150813023252-1b506fc7c24e
	github.com/sergi/go-diff => github.com/sergi/go-diff v1.0.0
	github.com/shurcooL/sanitized_anchor_name => github.com/shurcooL/sanitized_anchor_name v1.0.0
	github.com/sirupsen/logrus => github.com/sirupsen/logrus v1.4.2
	github.com/soheilhy/cmux => github.com/soheilhy/cmux v0.1.4
	github.com/spaolacci/murmur3 => github.com/spaolacci/murmur3 v0.0.0-20180118202830-f09979ecbc72
	github.com/spf13/afero => github.com/spf13/afero v1.2.2
	github.com/spf13/cast => github.com/spf13/cast v1.3.0
	github.com/spf13/cobra => github.com/spf13/cobra v0.0.0-20190321000552-67fc4837d267
	github.com/spf13/jwalterweatherman => github.com/spf13/jwalterweatherman v1.1.0
	github.com/spf13/pflag => github.com/spf13/pflag v1.0.5
	github.com/spf13/viper => github.com/spf13/viper v1.7.0
	github.com/stretchr/objx => github.com/stretchr/objx v0.3.0
	github.com/stretchr/testify => github.com/stretchr/testify v1.4.0
	github.com/subosito/gotenv => github.com/subosito/gotenv v1.2.0
	github.com/syndtr/gocapability => github.com/syndtr/gocapability v0.0.0-20200815063812-42c35b437635
	github.com/tidwall/pretty => github.com/tidwall/pretty v0.0.0-20200828150932-ef453c788d6a
	github.com/tmc/grpc-websocket-proxy => github.com/tmc/grpc-websocket-proxy v0.0.0-20190109142713-0ad062ec5ee5
	github.com/ugorji/go => github.com/ugorji/go v0.0.0-20180407103000-f3cacc17c85e
	github.com/urfave/cli => github.com/urfave/cli v1.2.0
	github.com/urfave/negroni => github.com/urfave/negroni v0.0.0-20171112011920-5dbbc83f748f
	github.com/vishvananda/netlink => github.com/vishvananda/netlink v0.0.0-20180316212924-41009d533ba0
	github.com/vishvananda/netns => github.com/vishvananda/netns v0.0.0-20190625233234-7109fa855b0f
	github.com/vmware/govmomi => github.com/vmware/govmomi v0.0.0-20201221180647-1ec59a7c0002
	github.com/xanzy/go-gitlab => github.com/xanzy/go-gitlab v0.15.0
	github.com/xdg/scram => github.com/xdg/scram v0.0.0-20180814205039-7eeb5667e42c
	github.com/xdg/stringprep => github.com/xdg/stringprep v1.0.0
	github.com/xeipuuv/gojsonpointer => github.com/xeipuuv/gojsonpointer v0.0.0-20180127040702-4e3ac2762d5f
	github.com/xeipuuv/gojsonreference => github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415
	github.com/xeipuuv/gojsonschema => github.com/xeipuuv/gojsonschema v1.2.0
	github.com/xordataexchange/crypt => github.com/xordataexchange/crypt v0.0.3-0.20170626215501-b2862e3d0a77
	github.com/yuin/goldmark => github.com/yuin/goldmark v0.0.0-20200826112251-7b90f04af431
	go.etcd.io/bbolt => go.etcd.io/bbolt v0.0.0-20190608165704-a0458a2b3570
	go.opencensus.io => go.opencensus.io v0.22.3
	go.uber.org/multierr => go.uber.org/multierr v1.3.0
	go.uber.org/tools => go.uber.org/tools v0.0.0-20190618225709-2cfd321de3ee
	go.uber.org/zap => go.uber.org/zap v1.13.0
	golang.org/x/crypto => golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83
	golang.org/x/exp => golang.org/x/exp v0.0.0-20190426190305-956cc1757749
	gomodules.xyz/jsonpatch/v2 => gomodules.xyz/jsonpatch/v2 v2.0.1
	google.golang.org/api => google.golang.org/api v0.20.0
	google.golang.org/appengine => google.golang.org/appengine v1.6.5
	google.golang.org/genproto => google.golang.org/genproto v0.0.0-20201022181438-0ff5f38871d5
	google.golang.org/grpc => google.golang.org/grpc v1.27.0
	google.golang.org/protobuf => google.golang.org/protobuf v1.25.0
	gopkg.in/errgo.v2 => gopkg.in/errgo.v2 v2.1.0
	gopkg.in/fsnotify.v1 => gopkg.in/fsnotify.v1 v1.4.7
	gopkg.in/go-playground/assert.v1 => gopkg.in/go-playground/assert.v1 v1.2.1
	gopkg.in/inf.v0 => gopkg.in/inf.v0 v0.9.1
	gopkg.in/tomb.v1 => gopkg.in/tomb.v1 v1.0.0-20161208151619-d5d1b5820637
	gopkg.in/yaml.v2 => gopkg.in/yaml.v2 v2.4.0
	helm.sh/helm/v3 => helm.sh/helm/v3 v3.0.0-20200422233323-0a9a9a88e8af
	honnef.co/go/tools => honnef.co/go/tools v0.0.0-20200822191040-81508471876c
	k8s.io/api => k8s.io/api v0.20.6
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.20.6
	k8s.io/apimachinery => k8s.io/apimachinery v0.20.6
	k8s.io/apiserver => k8s.io/apiserver v0.20.6
	k8s.io/autoscaler => k8s.io/autoscaler v0.0.0-20201110183641-97acd14b9686
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.20.6
	k8s.io/client-go => k8s.io/client-go v0.20.6
	k8s.io/cloud-provider => k8s.io/cloud-provider v0.0.0-20190620090043-8301c0bda1f0
	k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.20.6
	k8s.io/code-generator => k8s.io/code-generator v0.0.0-20200708172309-f186a36abf5c
	k8s.io/component-base => k8s.io/component-base v0.20.2
	k8s.io/cri-api => k8s.io/cri-api v0.20.6
	k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.20.6
	k8s.io/gengo => k8s.io/gengo v0.0.0-20190128074634-0689ccc1d7d6
	k8s.io/heapster => k8s.io/heapster v0.0.0-20180912150135-c78cc312ab39
	k8s.io/klog/v2 => k8s.io/klog/v2 v2.8.0
	k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.0.0-20180912235703-14b8d2d93fcb
	k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.21.0
	k8s.io/kube-openapi => k8s.io/kube-openapi v0.0.0-20200923105717-7eba4cbaebdf

	k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.20.6
	k8s.io/repo-infra => k8s.io/repo-infra v0.0.0-20180920215123-069c38ebb042
	k8s.io/utils => k8s.io/utils v0.0.0-20201110183641-67b214c5f920
	kubernetes/klog => kubernetes/klog v1.0.0
	sigs.k8s.io/controller-runtime => sigs.k8s.io/controller-runtime v0.6.3
	sigs.k8s.io/controller-tgithub.com/containerd/console v0.0.0-20180822173158-c12b1e7919c1ools => sigs.k8s.io/controller-tools v0.0.0-20200129215414-2bc3f5eb99cc
	sigs.k8s.io/kustomize/v2 => sigs.k8s.io/kustomize/v3 v3.0.0-20190726175121-95f3303493fd
	sigs.k8s.io/structured-merge-diff/v4 => sigs.k8s.io/structured-merge-diff/v4 v4.1.0
	sigs.k8s.io/yaml => sigs.k8s.io/yaml v1.2.0
)

replace (
	github.com/prometheus/client_golang => github.com/prometheus/client_golang v1.2.1
	github.com/prometheus/client_model => github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4
	github.com/prometheus/common => github.com/prometheus/common v0.7.0
	k8s.io/kube-proxy => k8s.io/kube-proxy v0.20.6
	k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.20.6
	k8s.io/kube-state-metrics => k8s.io/kube-state-metrics v0.0.0-20180918070825-cb9f20b57574
	k8s.io/kubectl => k8s.io/kubectl v0.0.0-20201218185502-10b66c3fd14b
	k8s.io/kubelet => k8s.io/kubelet v0.0.0-20180908160459-cf37f0b20133
	k8s.io/kubernetes => k8s.io/kubernetes v1.16.2
	k8s.io/metrics => k8s.io/metrics v0.20.2
	k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.0.0-20180913000251-1110eaa81bb3
)

replace github.com/docker/docker => github.com/moby/moby v0.7.3-0.20190826074503-38ab9da00309 // Required by Helm
