package com.workiva.frugal.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.time.Clock;
import java.util.Map;

/**
 * A default event handler for an FServer.
 */
public class FDefaultServerEventHandler implements FServerEventHandler {
    private static final Logger LOGGER = LoggerFactory.getLogger(FDefaultServerEventHandler.class);
    public static final String REQUEST_RECEIVED_MILLIS_KEY = "request_received_millis";

    private long highWatermark;
    // protected for testing
    protected Clock clock;

    public FDefaultServerEventHandler(long highWatermark) {
        this.highWatermark = highWatermark;
        this.clock = Clock.systemUTC();
    }

    @Override
    public void onRequestReceived(Map<Object, Object> ephemeralProperties) {
        long now = clock.millis();
        ephemeralProperties.put(REQUEST_RECEIVED_MILLIS_KEY, now);
    }

    @Override
    public void onRequestStarted(Map<Object, Object> ephemeralProperties) {
        if (ephemeralProperties.get(REQUEST_RECEIVED_MILLIS_KEY) != null) {
            long started = (long) ephemeralProperties.get(REQUEST_RECEIVED_MILLIS_KEY);
            long duration = clock.millis() - started;
            if (duration > highWatermark) {
                LOGGER.warn(String.format(
                        "request spent %d ms in the transport buffer, your consumer might be backed up", duration));
            }
        }
    }

    @Override
    public void onRequestEnded(Map<Object, Object> ephemeralProperties) {}
}
