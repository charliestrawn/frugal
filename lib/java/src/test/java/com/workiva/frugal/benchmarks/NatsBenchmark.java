package com.workiva.frugal.benchmarks;

import io.nats.client.Connection;
import io.nats.client.Nats;
import io.nats.client.Options;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.OptionsBuilder;
import java.io.IOException;

/**
 * Benchmarks for JNATS.
 */
@State(Scope.Thread)
public class NatsBenchmark {

    Connection nc;

    @Setup
    public void setup() throws IOException {
        Options.Builder optionsBuilder = new Options.Builder().server(Options.DEFAULT_URL);
        try {
            nc = Nats.connect(optionsBuilder.build());
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    @TearDown
    public void teardown() throws InterruptedException {
        nc.close();
    }

    @Benchmark
    public void testPublisher() {
        nc.publish("topic", "Hello World".getBytes());
    }

    public static void main(String[] args) throws RunnerException {
        org.openjdk.jmh.runner.options.Options opt = new OptionsBuilder()
                .include(NatsBenchmark.class.getSimpleName())
                .warmupIterations(5)
                .measurementIterations(5)
                .forks(1)
                .build();

        new Runner(opt).run();
    }
}
