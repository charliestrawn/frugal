using frugal.Protocol;
using frugal.Provider;
using frugal.Transport;
using Moq;
using NUnit.Framework;

namespace frugal.Test.Provider
{
    [TestFixture]
    public class FScopeProviderTest
    {
        [Test]
        public void TestProvide()
        {
            var mockPublisherFactory = new Mock<IFPublisherTransportFactory>();
            var mockPublisherTransport = new Mock<IFPublisherTransport>();
            mockPublisherFactory.Setup(x => x.GetTransport()).Returns(mockPublisherTransport.Object);
            
            var mockSubscriberFactory = new Mock<IFSubscriberTransportFactory>();
            var mockProtocolFactory = new Mock<IFProtocolFactory>();
            var fScopeProvider = new FScopeProvider(mockPublisherFactory.Object, 
                mockSubscriberFactory.Object, mockProtocolFactory.Object);

            var publisher = fScopeProvider.BuildPublisher();

            Assert.AreEqual(mockPublisherTransport.Object, publisher.Transport);
        }
    }
}