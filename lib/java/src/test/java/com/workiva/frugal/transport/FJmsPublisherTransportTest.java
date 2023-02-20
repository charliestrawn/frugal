package com.workiva.frugal.transport;


import org.apache.thrift.transport.TTransportException;
import org.junit.Before;
import org.junit.Test;
import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.Topic;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Tests for {@link FJmsPublisherTransport}.
 */
public class FJmsPublisherTransportTest {

    private FJmsPublisherTransport transport;
    private Connection connection;
    private Session session;
    private byte[] payload = new byte[]{1, 2, 3, 4};

    @Before
    public void setUp() throws Exception {
        connection = mock(Connection.class);
        session = mock(Session.class);
        when(connection.createSession(false, Session.CLIENT_ACKNOWLEDGE)).thenReturn(session);
        transport = new FJmsPublisherTransport(connection, "", true, 32 * 1024 * 1024);
    }

    @Test
    public void testOpen() throws Exception {
        assertFalse(transport.isOpen());
        MessageProducer producer = mock(MessageProducer.class);
        when(session.createProducer(null)).thenReturn(producer);
        transport.open();
        assertTrue(transport.isOpen());
        transport.open();
        assertTrue(transport.isOpen());
        verify(session, times(1)).createProducer(null);
    }

    @Test
    public void testClose() throws Exception {
        MessageProducer producer = mock(MessageProducer.class);
        transport.session = session;
        transport.producer = producer;
        assertTrue(transport.isOpen());
        transport.close();
        assertFalse(transport.isOpen());
        transport.close();
        assertFalse(transport.isOpen());
        verify(producer, times(1)).close();
    }

    @Test(expected = TTransportException.class)
    public void testPublishNotOpen() throws Exception {
        transport.publish("some-topic", payload);
    }

    @Test(expected = TTransportException.class)
    public void testPublishNoTopic() throws Exception {
        MessageProducer producer = mock(MessageProducer.class);
        transport.producer = producer;
        transport.publish("", payload);
    }

    @Test(expected = TTransportException.class)
    public void testPublishTooBig() throws Exception {
        MessageProducer producer = mock(MessageProducer.class);
        transport.producer = producer;
        byte[] bigPayload = new byte[32 * 1024 * 1024 + 1];
        transport.publish("some-topic", bigPayload);
    }

    @Test
    public void testPublish() throws Exception {
        MessageProducer producer = mock(MessageProducer.class);
        transport.session = session;
        transport.producer = producer;
        Topic destination = mock(Topic.class);
        when(session.createTopic("frugal.some-topic")).thenReturn(destination);
        BytesMessage message = mock(BytesMessage.class);
        when(session.createBytesMessage()).thenReturn(message);

        transport.publish("some-topic", payload);
        verify(session, times(1)).createTopic("frugal.some-topic");
        verify(message, times(1)).writeBytes(payload);
        verify(producer, times(1)).send(destination, message);
    }
}
