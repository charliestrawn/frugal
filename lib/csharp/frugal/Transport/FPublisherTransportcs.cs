namespace frugal.Transport
{
    public interface IFPublisherTransport
    {
        bool IsOpen { get; }
        void Open();
        void Close();
        int PublishSizeLimit { get; }
        void Publish(string subject, byte[] payload);
    }

    public interface IFPublisherTransportFactory
    {
        IFPublisherTransport GetTransport();
    }
}