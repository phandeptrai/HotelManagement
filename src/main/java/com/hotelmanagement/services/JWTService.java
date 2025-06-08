package com.hotelmanagement.services;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

public interface JWTService {
	String generateToken(UserDetails userDetails);
	String extractUsernameFromToken(String token);
	boolean validateToken(String token);
	List<String> extractAuthoritiesFromToken(String token);
}
