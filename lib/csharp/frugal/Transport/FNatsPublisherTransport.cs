using NATS.Client;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsPublisherTransport : IFPublisherTransport
    {
        private readonly IConnection _conn;

        public FNatsPublisherTransport(IConnection conn)
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

        public void Close()
        {
            // NoOp
        }

        public int GetPublishSizeLimit()
        {
            return 1024 * 1024;
        }

        public void Publish(string subject, byte[] payload)
        {
            if (!IsOpen())
            {
                throw new TTransportException();
            }

            if (subject == "")
            {

            }

            if (payload.Length > GetPublishSizeLimit())
            {

            }

            _conn.Publish(subject, payload);
        }

        private string GetFormattedSubject(string subject)
        {
            return "frugal." + subject;
        }

        public static FNatsPublisherTransportFactory Factory(IConnection conn)
        {
            return new FNatsPublisherTransportFactory(conn);
        }
    }

    public class FNatsPublisherTransportFactory
    {
        private readonly IConnection _conn;

        public FNatsPublisherTransportFactory(IConnection conn)
        {
            _conn = conn;
        }

        public FNatsPublisherTransport GetTransport()
        {
            return new FNatsPublisherTransport(_conn);
        }
    }
}