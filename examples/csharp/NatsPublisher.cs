using frugal.Protocol;
using frugal.Provider;
using frugal.Transport;
using NATS.Client;
using Thrift.Protocol;

namespace frugal_example
{
    class NatsPublisher
    {
        static void Main(string[] args)
        {
            var fProtocolFactory = new FProtocolFactory(new TBinaryProtocol.Factory());
            var cf = new ConnectionFactory();
            IConnection conn = cf.CreateConnection();

            var publisherFactory = FNatsPublisherTransport.Factory(conn);
            var subscriberFactory = FNatsSubscriberTransport.Factory(conn);

            var provider = new FScopeProvider(publisherFactory, subscriberFactory, fProtocolFactory);


        }
    }
}
