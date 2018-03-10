using System;
using System.Collections.Generic;
using System.Linq;
using NATS.Client;
using Thrift.Protocol;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsTransport
    {
        private Connection _conn;
        private Subscription _sub;
        private string _subject;
        private string _inbox;
        public const string FrugalPrefix = "frugal.";

        public FNatsTransport(Connection conn, string subject) : this(conn, subject, conn.NewInbox()) {}

        public FNatsTransport(Connection conn, string subject, string inbox)
        {
            _conn = conn;
            _subject = subject;
            _inbox = inbox;
        }

        public bool IsOpen()
        {
            return _sub != null && _conn.State == ConnState.CONNECTED;
        }

        ///
        /// <exception cref="TTransportException">Why it's thrown.</exception>
        public void Open()
        {
            if (_sub != null)
            {
                throw new TTransportException(TTransportException.ExceptionType.AlreadyOpen,
                    "NATS transport already open.");
            }

            EventHandler<MsgHandlerEventArgs> eventHandler = (sender, args) =>
            {
                byte[] initialFrame = args.Message.Data;
                var payload = new byte[initialFrame.Length];
                Array.Copy(initialFrame, 4, payload, 0, payload.Length);
                if (payload.Length < 5)
                {
                    throw new TProtocolException(TProtocolException.INVALID_DATA,
                        "inavlid frame size " + payload.Length);
                }

                if (payload[0] != 0x00)
                {
                    throw new TProtocolException(TProtocolException.BAD_VERSION, "unsupported header version " + payload[0]);
                }
                var headers = new Dictionary<string, string>();
                var lengthBytes = new byte[4];
                Array.Copy(payload, 4, lengthBytes, 0, 4);
                var length = BitConverter.ToInt32(lengthBytes, 0);
            };
            _sub = (Subscription) _conn.SubscribeAsync(_inbox, eventHandler);
        }

    }
}