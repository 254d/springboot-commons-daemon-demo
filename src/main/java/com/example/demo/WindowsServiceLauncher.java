package com.example.demo;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WindowsServiceLauncher {

  private static volatile ConfigurableApplicationContext context;
  private static final CountDownLatch stopLatch = new CountDownLatch(1);

  /**
   * Called by the Windows service wrapper when the service is started.
   */
  public static void start(String[] args) {
    context = SpringApplication.run(DemoApplication.class, args);

    log.info("Start Service");

    // In order to keep the service running, we wait for the stop signal from the
    // Windows service wrapper.
    try {
      while (stopLatch.getCount() > 0) {
        stopLatch.await(5, TimeUnit.SECONDS);
      }
    } catch (InterruptedException ignored) {
      Thread.currentThread().interrupt();
    }
  }

  /**
   * Called by the Windows service wrapper when the service is stopped.
   */
  public static void stop(String[] args) {
    log.info("Stop Service");

    try {
      if (context != null) {
        context.close();
      }
    } finally {
      stopLatch.countDown();
    }
  }
}
