namespace frugal.Transport
{
    public interface IFSubscription
    {
        void Unsubscribe();
        void Remove();
    }

    public class FSubscription : IFSubscription
    {
        private IFSubscriberTransport Transport { get; }
        public string Topic { get; }

        public FSubscription(string topic, IFSubscriberTransport transport)
        {
            Topic = topic;
            Transport = transport;
        }

        public void Unsubscribe()
        {
            Transport?.Unsubscribe();
        }

        public void Remove()
        {
            throw new System.NotImplementedException();
        }
    }
}