module github.com/Workiva/frugal/lib/go

require (
	git.apache.org/thrift.git v0.0.0-20161221203622-b2a4d4ae21c7
	github.com/Sirupsen/logrus v0.11.5
	github.com/go-stomp/stomp v2.0.4+incompatible
	github.com/mattrobenolt/gocql v0.0.0-20130828033103-56c5a46b65ee
	github.com/nats-io/gnatsd v0.9.4
	github.com/nats-io/go-nats v0.0.0-20161120202126-6b6bf392d34d
	github.com/nats-io/nuid v1.0.0 // indirect
	github.com/stretchr/testify v1.4.0
	golang.org/x/crypto v0.0.0-20190829043050-9756ffdc2472 // indirect
)

replace git.apache.org/thrift.git => github.com/apache/thrift v0.0.0-20161221203622-b2a4d4ae21c7
