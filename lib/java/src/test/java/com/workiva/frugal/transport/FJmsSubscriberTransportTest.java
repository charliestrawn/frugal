package com.workiva.frugal.transport;

import com.workiva.frugal.protocol.FAsyncCallback;
import org.apache.thrift.transport.TTransportException;
import org.junit.Before;
import org.junit.Test;
import javax.jms.Connection;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.Topic;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Tests for {@link FJmsSubscriberTransport}.
 */
public class FJmsSubscriberTransportTest {

    private FJmsSubscriberTransport transport;
    private Connection connection;
    private Session session;

    @Before
    public void setUp() throws Exception {
        connection = mock(Connection.class);
        session = mock(Session.class);
        when(connection.createSession(false, Session.CLIENT_ACKNOWLEDGE)).thenReturn(session);
        transport = new FJmsSubscriberTransport(connection, "", false);
    }

    @Test(expected = TTransportException.class)
    public void testAlreadySubscribedThrowsException() throws Exception {
        MessageConsumer consumer = mock(MessageConsumer.class);
        transport.session = session;
        transport.consumer = consumer;
        FAsyncCallback callback = mock(FAsyncCallback.class);
        transport.subscribe("some-topic", callback);
    }

    @Test(expected = TTransportException.class)
    public void testEmptyTopicThrowsException() throws Exception {
        FAsyncCallback callback = mock(FAsyncCallback.class);
        transport.subscribe("", callback);
    }

    @Test
    public void testSubscribe() throws Exception {
        FAsyncCallback callback = mock(FAsyncCallback.class);
        Topic destination = mock(Topic.class);
        when(session.createTopic("frugal.some-topic")).thenReturn(destination);
        MessageConsumer consumer = mock(MessageConsumer.class);
        when(session.createConsumer(destination)).thenReturn(consumer);

        transport.subscribe("some-topic", callback);
        verify(session, times(1)).createTopic("frugal.some-topic");
        verify(session, times(1)).createConsumer(destination);
        verify(consumer, times(1)).setMessageListener(any());
    }
}
