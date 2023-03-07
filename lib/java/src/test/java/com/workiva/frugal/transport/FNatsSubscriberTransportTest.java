package com.workiva.frugal.transport;

import com.workiva.frugal.protocol.FAsyncCallback;
import io.nats.client.Connection;
import io.nats.client.Connection.Status;
import io.nats.client.Dispatcher;
import io.nats.client.Message;
import io.nats.client.MessageHandler;
import org.apache.thrift.TException;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import static com.workiva.frugal.transport.FNatsTransport.FRUGAL_PREFIX;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Tests for {@link FSubscriberTransport}.
 */
public class FNatsSubscriberTransportTest {

    private FNatsSubscriberTransport transport;
    private Connection conn;
    private String topic = "topic";
    private String formattedSubject = FRUGAL_PREFIX + topic;
    private Dispatcher mockDispatcher;
    private Message mockMessage;

    private class Handler implements FAsyncCallback {
        TTransport transport;
        TException exception;
        RuntimeException runtimeException;
        Error error;

        @Override
        public void onMessage(TTransport transport) throws TException {
            this.transport = transport;
            if (exception != null) {
                throw exception;
            }
            if (runtimeException != null) {
                throw runtimeException;
            }
            if (error != null) {
                throw error;
            }
        }
    }

    @Before
    public void setUp() {
        conn = mock(Connection.class);
        transport = new FNatsSubscriberTransport.Factory(conn).getTransport();
        mockDispatcher = mock(Dispatcher.class);
        mockMessage = mock(Message.class);
    }

    @Test
    public void testSubscribe() throws Exception {
        when(conn.getStatus()).thenReturn(Status.CONNECTED);
        ArgumentCaptor<String> topicCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<MessageHandler> handlerCaptor = ArgumentCaptor.forClass(MessageHandler.class);

        when(conn.createDispatcher(handlerCaptor.capture())).thenReturn(mockDispatcher);

        Handler handler = new Handler();
        transport.subscribe(topic, handler);

        // Nats subscription not yet valid
        when(mockDispatcher.isActive()).thenReturn(false);
        assertFalse(transport.isSubscribed());

        // All good now
        when(mockDispatcher.isActive()).thenReturn(true);
        assertTrue(transport.isSubscribed());
        assertEquals(mockDispatcher, transport.dispatcher);
        verify(mockDispatcher, times(1)).subscribe(topicCaptor.capture());
        assertEquals(formattedSubject, topicCaptor.getValue());

        // Handle a good frame
        byte[] frame = new byte[]{0, 0, 0, 4, 1, 2, 3, 4};
        when(mockMessage.getData()).thenReturn(frame);
        MessageHandler messageHandler = handlerCaptor.getValue();
        messageHandler.onMessage(mockMessage);

        byte[] expectedPayload = new byte[]{1, 2, 3, 4};
        byte[] actualPayload = new byte[4];

        handler.transport.read(actualPayload, 0, 4);
        assertArrayEquals(expectedPayload, actualPayload);

        // Handle a bad frame
        handler.transport = null;
        when(mockMessage.getData()).thenReturn(new byte[3]);
        messageHandler.onMessage(mockMessage);
        assertNull(handler.transport);

        // Handler an FAsyncCallback error
        handler.exception = new TException("Bad things!");
        when(mockMessage.getData()).thenReturn(frame);
        messageHandler.onMessage(mockMessage);
        handler.exception = null;

        handler.runtimeException = new RuntimeException("error");
        when(mockMessage.getData()).thenReturn(frame);
        messageHandler.onMessage(mockMessage);
        handler.runtimeException = null;

        handler.error = new Error("error");
        when(mockMessage.getData()).thenReturn(frame);
        messageHandler.onMessage(mockMessage);
        handler.error = null;

        actualPayload = new byte[4];
        handler.transport.read(actualPayload, 0, 4);
        assertArrayEquals(expectedPayload, actualPayload);
    }

    @Test
    public void testSubscribeQueue() throws Exception {
        transport = new FNatsSubscriberTransport.Factory(conn, "foo").getTransport();
        when(conn.getStatus()).thenReturn(Status.CONNECTED);
        ArgumentCaptor<String> topicCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<String> queueCaptor = ArgumentCaptor.forClass(String.class);

        when(conn.createDispatcher(any(MessageHandler.class))).thenReturn(mockDispatcher);

        Handler handler = new Handler();
        transport.subscribe(topic, handler);
        when(mockDispatcher.isActive()).thenReturn(true);

        assertTrue(transport.isSubscribed());
        assertEquals(mockDispatcher, transport.dispatcher);
        verify(mockDispatcher, times(1)).subscribe(topicCaptor.capture(), queueCaptor.capture());
        assertEquals("foo", queueCaptor.getValue());
        assertEquals(formattedSubject, topicCaptor.getValue());
    }

    @Test
    public void testSubscribeEmptySubjectThrowsException() throws Exception {
        when(conn.getStatus()).thenReturn(Status.CONNECTED);
        try {
            transport.subscribe("", new Handler());
            fail();
        } catch (TTransportException ex) {
            assertEquals("Subject cannot be empty.", ex.getMessage());
        }
    }

    @Test(expected = TTransportException.class)
    public void testSubscribeNotConnectedThrowsException() throws Exception {
        when(conn.getStatus()).thenReturn(Status.DISCONNECTED);
        transport.subscribe("", new Handler());
    }

    @Test
    public void testCloseSubscriber() {
        transport.dispatcher = mockDispatcher;
        transport.unsubscribe();
        assertFalse(transport.isSubscribed());
        // Make sure unsubscribe doesn't throw an error when called again
        transport.unsubscribe();
    }

    @Test
    public void testCloseSubscriberUnsubscribeException() {
        transport.dispatcher = mockDispatcher;
        Mockito.doThrow(new IllegalStateException("Problem")).when(mockDispatcher).unsubscribe(formattedSubject);
        transport.unsubscribe();
        assertFalse(transport.isSubscribed());
    }
}

