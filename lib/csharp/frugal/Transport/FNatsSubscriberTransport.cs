using System.Runtime.ConstrainedExecution;
using NATS.Client;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsSubscriberTransport : IFSubscriberTransport
    {
        private IConnection _conn;

        public FNatsSubscriberTransport(IConnection conn)
        {
            _conn = conn;
        }

        public bool IsOpen()
        {
            return _conn.State == ConnState.CONNECTED;
        }

        public void Open()
        {
            // Just need to verify that the passed in NATS connection was open already.
            if (!IsOpen())
            {
                throw new TTransportException(TTransportException.ExceptionType.NotOpen,
                    "NATS not connected, has status " + _conn.State);
            }
        }

        public static IFSubscriberTransportFactory Factory(IConnection conn)
        {
            return new FNatsSubscriberTransportFactory(conn);
        }

        public bool IsSubscribed()
        {
            throw new System.NotImplementedException();
        }

        public void Subscribe(string topic)
        {
            throw new System.NotImplementedException();
        }

        public void Unsubscribe()
        {
            throw new System.NotImplementedException();
        }
    }

    public class FNatsSubscriberTransportFactory : IFSubscriberTransportFactory
    {
        private IConnection _conn;

        public FNatsSubscriberTransportFactory(IConnection conn)
        {
            _conn = conn;
        }

        public IFSubscriberTransport GetTransport()
        {
            return new FNatsSubscriberTransport(_conn);
        }
    }
}