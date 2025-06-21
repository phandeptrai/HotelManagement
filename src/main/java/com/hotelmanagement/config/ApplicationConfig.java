package com.hotelmanagement.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Application configuration class.
 * This class is referenced in WebInitializer.getRootConfigClasses()
 * to provide root application context configuration.
 */
@Configuration
@ComponentScan(basePackages = "com.hotelmanagement")
public class ApplicationConfig {}
