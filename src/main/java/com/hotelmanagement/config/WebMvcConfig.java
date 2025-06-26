
package com.hotelmanagement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.hotelmanagement.authorization.AdminInterceptor;

@Configuration

@EnableWebMvc

@ComponentScan(basePackages = { "com.hotelmanagement.controllers", "com.hotelmanagement.admin.controllers",
		"com.hotelmanagement.services" })
public class WebMvcConfig implements WebMvcConfigurer {

	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		return resolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new AdminInterceptor()).addPathPatterns("/admin/**").excludePathPatterns("/admin/403");
	}

	@Override
	public void configureAsyncSupport(AsyncSupportConfigurer configurer) { // Cấu hình async request timeout
		configurer.setDefaultTimeout(30000); // 30 giây
		configurer.setTaskExecutor((AsyncTaskExecutor) taskExecutor());
	}

	// Sử dụng taskExecutor từ ApplicationConfig private
	org.springframework.core.task.TaskExecutor taskExecutor() {
		org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor executor = new org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor();
		executor.setCorePoolSize(50);
		executor.setMaxPoolSize(100);
		executor.setQueueCapacity(500);
		executor.setThreadNamePrefix("WebAsync-");
		executor.initialize();
		return executor;
	}
}
