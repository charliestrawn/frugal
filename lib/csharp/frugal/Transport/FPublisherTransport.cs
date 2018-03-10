namespace frugal.Transport
{
    public interface IFPublisherTransport
    {
        bool IsOpen();
        void Open();
        void Close();
        int GetPublishSizeLimit();
        void Publish(string subject, byte[] payload);
    }

    public interface IFPublisherTransportFactory
    {
        IFPublisherTransport GetTransport();
    }
}