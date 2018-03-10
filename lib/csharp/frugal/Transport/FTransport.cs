using System;
using Thrift.Transport;

namespace frugal.Transport
{
    public interface IFTransport
    {
        bool IsOpen();
        void Open();
        void Close();

        int GetRequestSizeLimit();
        void SetClosedCallback();
    }

    public interface IFTransportFactory
    {
        IFTransport GetTransport(TTransport transport);
    }

    public abstract class FTransport
    {
        private bool _isOpen;

        protected int RequestSizeLimit { get; set; }

        public bool IsOpen()
        {
            return _isOpen;
        }

        public void Open()
        {
            _isOpen = true;
        }

        public void Close()
        {
            Close(null);
        }

        public void Close(Exception cause)
        {
            _isOpen = false;
            // TODO: Add SignalClose method
        }

        public abstract void Oneway(FContext context, byte[] payload);

        public abstract TTransport Request(FContext context, byte[] payload);

        protected void PreflightRequestCheck(int length)
        {
            if (!IsOpen())
            {
                throw new TTransportException(TTransportException.ExceptionType.NotOpen);
            }

            if (RequestSizeLimit > 0 && length > RequestSizeLimit)
            {
                // TODO: Make this RequestTooLarge
                throw new TTransportException(TTransportException.ExceptionType.Unknown);
            }

        }
    }
}
