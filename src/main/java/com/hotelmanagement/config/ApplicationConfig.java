package com.hotelmanagement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

/**
 * Application configuration class.
 * This class is referenced in WebInitializer.getRootConfigClasses()
 * to provide root application context configuration.
 */
@Configuration
@ComponentScan(basePackages = "com.hotelmanagement")
@EnableAsync
public class ApplicationConfig {
    
    @Bean(name = "taskExecutor")
    public Executor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(20);           // Core threads
        executor.setMaxPoolSize(100);           // Max threads
        executor.setQueueCapacity(500);         // Queue capacity
        executor.setThreadNamePrefix("HotelAsync-");
        executor.setKeepAliveSeconds(60);       // Keep alive time
        executor.initialize();
        return executor;
    }
}
