using System.IO;
using NATS.Client;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsPublisherTransport : IFPublisherTransport
    {
        private readonly IConnection _conn;
        public int PublishSizeLimit => 1024 * 1024;
        public bool IsOpen => _conn.State == ConnState.CONNECTED;

        public FNatsPublisherTransport(IConnection conn)
        {
            _conn = conn;
        }

        public void Open()
        {
            // Just need to verify that the passed in NATS connection was open already.
            if (!IsOpen)
            {
                throw new TTransportException(TTransportException.ExceptionType.NotOpen,
                    "NATS not connected, has status " + _conn.State);
            }
        }

        public void Close()
        {
            // NoOp
        }


        public void Publish(string subject, byte[] payload)
        {
            if (!IsOpen)
            {
                throw new TTransportException();
            }

            if (string.IsNullOrEmpty(subject))
            {
                throw new TTransportException("Subject cannot be empty.");
            }

            if (payload.Length > PublishSizeLimit)
            {
                throw new TTransportException("Request too large");
            }

            try
            {
                _conn.Publish(subject, payload);
            }
            catch (IOException e)
            {
                throw new TTransportException("publish: unable to publish data: " + e.Message);
            }
        }

        private string GetFormattedSubject(string subject)
        {
            return "frugal." + subject;
        }

        public static IFPublisherTransportFactory Factory(IConnection conn)
        {
            return new FNatsPublisherTransportFactory(conn);
        }
    }

    public class FNatsPublisherTransportFactory : IFPublisherTransportFactory
    {
        private readonly IConnection _conn;

        public FNatsPublisherTransportFactory(IConnection conn)
        {
            _conn = conn;
        }

        public IFPublisherTransport GetTransport()
        {
            return new FNatsPublisherTransport(_conn);
        }
    }
}