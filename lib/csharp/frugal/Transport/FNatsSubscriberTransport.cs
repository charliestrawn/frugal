using System.Runtime.ConstrainedExecution;
using NATS.Client;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsSubscriberTransport
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

        public static FNatsSubscriberTransportFactory Factory(IConnection conn)
        {
            return new FNatsSubscriberTransportFactory(conn);
        }
    }

    public class FNatsSubscriberTransportFactory
    {
        private IConnection _conn;

        public FNatsSubscriberTransportFactory(IConnection conn)
        {
            _conn = conn;
        }

        public FNatsSubscriberTransport GetTransport()
        {
            return new FNatsSubscriberTransport(_conn);
        }
    }
}