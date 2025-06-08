
package com.hotelmanagement.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:dbConfig.properties")
public class JwtConfig {

	@Value("${jwt.secret}")
	private String secretKey;

	private Long expirationTime = 24 * 60 * 60 * 1000l;

	public String getSecretKey() {
		return secretKey;
	}

	public Long getExpirationTime() {
		return expirationTime;
	}
}
