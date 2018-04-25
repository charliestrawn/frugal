using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using NATS.Client;
using Thrift.Protocol;
using Thrift.Transport;

namespace frugal.Transport
{
    public class FNatsTransport
    {
        private readonly IConnection _conn;
        private IAsyncSubscription _sub;
        private readonly string _subject;
        private readonly string _inbox;
        public const string FrugalPrefix = "frugal.";
        public bool IsOpen => _sub != null && _conn.State == ConnState.CONNECTED;

        public FNatsTransport(IConnection conn, string subject) : this(conn, subject, conn.NewInbox()) {}

        public FNatsTransport(IConnection conn, string subject, string inbox)
        {
            _conn = conn;
            _subject = subject;
            _inbox = inbox;
        }

        ///
        /// <exception cref="TTransportException">Why it's thrown.</exception>
        public void Open()
        {
            if (_conn.State != ConnState.CONNECTED)
            {
                throw new TTransportException(TTransportException.ExceptionType.NotOpen,
                    "NATS client is not connected.");
            }
            if (_sub != null)
            {
                throw new TTransportException(TTransportException.ExceptionType.AlreadyOpen,
                    "NATS transport already open.");
            }

            void EventHandler(object sender, MsgHandlerEventArgs args)
            {
                var initialFrame = args.Message.Data;
                var payload = new byte[initialFrame.Length];
                Array.Copy(initialFrame, 4, payload, 0, payload.Length);
                if (payload.Length < 5)
                {
                    throw new TProtocolException(TProtocolException.INVALID_DATA, "inavlid frame size " + payload.Length);
                }

                if (payload[0] != 0x00)
                {
                    throw new TProtocolException(TProtocolException.BAD_VERSION, "unsupported header version " + payload[0]);
                }

                var headers = new Dictionary<string, string>();
                var lengthBytes = new byte[4];
                Array.Copy(payload, 4, lengthBytes, 0, 4);
                var length = BitConverter.ToInt32(lengthBytes, 0);
            }

            _sub = _conn.SubscribeAsync(_inbox, (EventHandler<MsgHandlerEventArgs>) EventHandler);
        }

        public void Close()
        {
            if (_sub == null)
                return;

            try
            {
                _sub.Unsubscribe();
            }
            catch (IOException e)
            {
                // TODO: Log this "NATS transport could not unsubscribe from subscription.";
            }

            _sub = null;
        }

        public void Flush(byte[] payload)
        {
            if (!IsOpen)
            {
                throw new TTransportException(TTransportException.ExceptionType.NotOpen,
                    "NATS client is not connected.");
            }

            try
            {
                _conn.Publish(_subject, _inbox, payload);
            }
            catch (IOException e)
            {
                throw new TTransportException("request: unable to publish data: " + e.Message);
            }
        }

    }
}