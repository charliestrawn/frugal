module github.com/Workiva/frugal/examples/go

go 1.14

require (
	github.com/Workiva/frugal/lib/go v0.0.0
	github.com/apache/thrift v0.15.0
	github.com/go-stomp/stomp v2.1.4+incompatible
	github.com/nats-io/nats.go v1.11.0
	github.com/rs/cors v1.7.0
	github.com/sirupsen/logrus v1.8.1
)

replace github.com/Workiva/frugal/lib/go v0.0.0 => ../../lib/go
