/*
 * Copyright 2017 Workiva
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.workiva.frugal.transport;

import com.workiva.frugal.exception.TTransportExceptionType;
import org.apache.thrift.transport.TTransportException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.Topic;
import static com.workiva.frugal.transport.FNatsTransport.FRUGAL_PREFIX;

/**
 * FJmsPublisherTransport implements FPublisherTransport by utilizing a JMS
 * connection.
 */
public class FJmsPublisherTransport implements FPublisherTransport {
    private static final Logger LOGGER = LoggerFactory.getLogger(FJmsPublisherTransport.class);

    // TODO should we try to batch with sessions at some point?
    private final Connection connection;
    private final String topicPrefix;
    private final boolean durablePublishes;
    private final int publisSizeLimit;
    Session session;
    MessageProducer producer;

    FJmsPublisherTransport(Connection connection, String topicPrefix, boolean durablePublishes, int publishSizeLimit) {
        this.connection = connection;
        if (topicPrefix == null) {
            topicPrefix = "";
        }
        this.topicPrefix = topicPrefix;
        this.durablePublishes = durablePublishes;
        this.publisSizeLimit = publishSizeLimit;
    }

    /**
     * An FPublisherTransportFactory implementation which creates
     * FPublisherTransports backed by a JMS connection.
     */
    public static class Factory implements FPublisherTransportFactory {

        private final Connection connection;
        private final String topicPrefix;
        private final boolean durablePublishes;
        private final int publishSizeLimit;

        /**
         * A builder for a FJmsPublisherTransportFactory.
         */
        public static class Builder {
            private Connection connection;
            private String topicPrefix;
            private boolean durablePublishes;
            private int publishSizeLimit;

            public Builder(Connection connection) {
                this.connection = connection;
                this.durablePublishes = true;
                this.publishSizeLimit = 0;
            }

            public Builder withTopicPrefix(String topicPrefix) {
                this.topicPrefix = topicPrefix;
                return this;
            }

            public Builder withDurablePublishes(boolean durablePublishes) {
                this.durablePublishes = durablePublishes;
                return this;
            }

            public Builder withPublishSizeLimit(int publishSizeLimit) {
                this.publishSizeLimit = publishSizeLimit;
                return this;
            }

            public Factory build() {
                if (topicPrefix == null) {
                    topicPrefix = "";
                }
                return new Factory(connection, topicPrefix, durablePublishes, publishSizeLimit);
            }
        }

        Factory(Connection connection, String topicPrefix, boolean durablePublishes, int publishSizeLimit) {
            this.connection = connection;
            this.topicPrefix = topicPrefix;
            this.durablePublishes = durablePublishes;
            this.publishSizeLimit = publishSizeLimit;
        }

        public FPublisherTransport getTransport() {
            return new FJmsPublisherTransport(connection, topicPrefix, durablePublishes, publishSizeLimit);
        }
    }

    @Override
    public synchronized boolean isOpen() {
        return session != null && producer != null;
    }

    @Override
    public synchronized void open() throws TTransportException {
        if (isOpen()) {
            LOGGER.info("jms transport already open, returning");
            return;
        }

        try {
            session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);
            producer = session.createProducer(null);
            if (!durablePublishes) {
                producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
            }
        } catch (JMSException e) {
            throw new TTransportException(e);
        }
    }

    @Override
    public synchronized void close() {
        if (!isOpen()) {
            LOGGER.info("jms transport already closed, returning");
            return;
        }

        try (Session closeSession = session) {
            producer.close();
        } catch (JMSException e) {
            LOGGER.error("failed to close jms producer", e);
        } finally {
            producer = null;
            session = null;
        }
    }

    @Override
    public int getPublishSizeLimit() {
        return publisSizeLimit;
    }

    @Override
    public synchronized void publish(String topic, byte[] payload) throws TTransportException {
        if (!isOpen()) {
            throw new TTransportException(TTransportException.NOT_OPEN, "failed to publish, jms client not open");
        }

        if (topic == null || "".equals(topic)) {
            throw new TTransportException("publish topic cannot be empty");
        }

        if (getPublishSizeLimit() > 0 && payload.length > getPublishSizeLimit()) {
            throw new TTransportException(TTransportExceptionType.REQUEST_TOO_LARGE,
                    String.format("message exceeds %d bytes, was %d bytes",
                            getPublishSizeLimit(), payload.length));
        }

        String formattedTopic = getFormattedTopic(topic);
        LOGGER.debug("publishing message to '{}'", formattedTopic);
        try {
            Topic destination = session.createTopic(formattedTopic);
            BytesMessage message = session.createBytesMessage();
            message.writeBytes(payload);
            // TODO should set this?
            // message.setJMSCorrelationID();
            producer.send(destination, message);
        } catch (JMSException e) {
            throw new TTransportException(e);
        }
        LOGGER.debug("published message to '{}'", formattedTopic);
    }

    private String getFormattedTopic(String subject) {
        return topicPrefix + FRUGAL_PREFIX + subject;
    }
}
