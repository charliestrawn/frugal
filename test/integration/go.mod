module github.com/Workiva/frugal/test/integration

go 1.18

require (
	github.com/Workiva/frugal/lib/go v0.0.0
	github.com/apache/thrift v0.17.0
	github.com/go-stomp/stomp v2.1.4+incompatible
	github.com/nats-io/nats.go v1.20.0
	github.com/sirupsen/logrus v1.9.0
)

require (
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/nats-io/nkeys v0.3.0 // indirect
	github.com/nats-io/nuid v1.0.1 // indirect
	golang.org/x/crypto v0.0.0-20220926161630-eccd6366d1be // indirect
	golang.org/x/sys v0.0.0-20220928140112-f11e5e49a4ec // indirect
	google.golang.org/protobuf v1.28.1 // indirect
)

replace github.com/Workiva/frugal/lib/go v0.0.0 => ../../lib/go
