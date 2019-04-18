namespace frugal.Transport
{
    public interface IFSubscriberTransport
    {
        bool IsSubscribed();
        void Subscribe(string topic);
        void Unsubscribe();
    }

    public interface IFSubscriberTransportFactory
    {
        IFSubscriberTransport GetTransport();
    }
}