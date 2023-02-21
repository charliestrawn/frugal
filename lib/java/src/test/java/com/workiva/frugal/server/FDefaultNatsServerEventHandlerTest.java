package com.workiva.frugal.server;

import org.junit.Test;
import java.time.Clock;
import java.time.Instant;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.Map;
import static org.junit.Assert.assertEquals;

/**
 * Tests for {@link FDefaultNatsServerEventHandler}.
 */
public class FDefaultNatsServerEventHandlerTest {

    @Test
    public void testOnRequestReceivedAddsTimestamp() {
        FDefaultNatsServerEventHandler handler = new FDefaultNatsServerEventHandler(5000);
        Instant instant = Instant.ofEpochSecond(1556627378);
        Clock clock = Clock.fixed(instant, ZoneId.systemDefault());
        handler.clock = clock;

        Map<Object, Object> properties = new HashMap<>();
        handler.onRequestReceived(properties);
        assertEquals(clock.millis(), properties.get(FDefaultNatsServerEventHandler.REQUEST_RECEIVED_MILLIS_KEY));
    }
}
