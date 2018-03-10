using frugal.Protocol;
using frugal.Transport;

namespace frugal.Provider
{
    public class Publisher
    {

        public Publisher(FNatsPublisherTransport transport, FProtocolFactory protocolFactory)
        {
            Transport = transport;
            ProtocolFactory = protocolFactory;
        }

        public FProtocolFactory ProtocolFactory { get; }
        public FNatsPublisherTransport Transport { get; }
    }

    public class Subscriber
    {
        public Subscriber(FNatsSubscriberTransport transport, FProtocolFactory protocolFactory)
        {
            Transport = transport;
            ProtocolFactory = protocolFactory;
        }

        public FProtocolFactory ProtocolFactory { get; }
        public FNatsSubscriberTransport Transport { get; }
    }

    public class FScopeProvider
    {
        private readonly FNatsPublisherTransportFactory _publisherTransportFactory;
        private readonly FNatsSubscriberTransportFactory _subscriberTransportFactory;
        private readonly FProtocolFactory _protocolFactory;

        public FScopeProvider(
            FNatsPublisherTransportFactory publisherTransportFactory,
            FNatsSubscriberTransportFactory subscriberTransportFactory,
            FProtocolFactory protocolFactory
            )
        {
            _publisherTransportFactory = publisherTransportFactory;
            _subscriberTransportFactory = subscriberTransportFactory;
            _protocolFactory = protocolFactory;
        }

        public Publisher BuildPublisher()
        {
            var transport = _publisherTransportFactory.GetTransport();
            return new Publisher(transport, _protocolFactory);
        }

        public Subscriber BuildSubscriber()
        {
            var transport = _subscriberTransportFactory.GetTransport();
            return new Subscriber(transport, _protocolFactory);
        }

    }
}