using frugal.Protocol;
using frugal.Transport;

namespace frugal.Provider
{
    public class Publisher
    {

        public Publisher(IFPublisherTransport transport, IFProtocolFactory protocolFactory)
        {
            Transport = transport;
            ProtocolFactory = protocolFactory;
        }

        public IFProtocolFactory ProtocolFactory { get; }
        public IFPublisherTransport Transport { get; }
    }

    public class Subscriber
    {
        public Subscriber(IFSubscriberTransport transport, IFProtocolFactory protocolFactory)
        {
            Transport = transport;
            ProtocolFactory = protocolFactory;
        }

        public IFProtocolFactory ProtocolFactory { get; }
        public IFSubscriberTransport Transport { get; }
    }

    public class FScopeProvider
    {
        private readonly IFPublisherTransportFactory _publisherTransportFactory;
        private readonly IFSubscriberTransportFactory _subscriberTransportFactory;
        private readonly IFProtocolFactory _protocolFactory;

        public FScopeProvider(
            IFPublisherTransportFactory publisherTransportFactory,
            IFSubscriberTransportFactory subscriberTransportFactory,
            IFProtocolFactory protocolFactory
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