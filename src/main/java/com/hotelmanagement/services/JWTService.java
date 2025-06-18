package com.hotelmanagement.services;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

public interface JWTService {
	String generateToken(UserDetails userDetails);
	String generateToken(String username, List<String> authorities, Integer userId);
	boolean validateToken(String token);
	String extractUsernameFromToken(String token);
	List<String> extractAuthoritiesFromToken(String token);
	Integer getUserIdFromToken(String token);
	boolean isTokenExpired(String token);
}
