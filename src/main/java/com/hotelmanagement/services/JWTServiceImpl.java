package com.hotelmanagement.services;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.hotelmanagement.config.JwtConfig;
import com.hotelmanagement.user.entities.User;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;

@Service
public class JWTServiceImpl implements JWTService {
	private JwtConfig jwtConfig;
	private SecretKey secretKey;

	@Autowired
	public JWTServiceImpl(JwtConfig jwtConfig) {
		this.jwtConfig = jwtConfig;
		this.secretKey = Keys.hmacShaKeyFor(jwtConfig.getSecretKey().getBytes());
	}

	@Override
	public String generateToken(UserDetails userDetails) {
		List<String> authorities = userDetails.getAuthorities().stream()
				.map(GrantedAuthority::getAuthority)
				.collect(Collectors.toList());

		Map<String, Object> claims = new HashMap<>();
		claims.put("Authorities", authorities);
		claims.put("userId", ((User) userDetails).getId());

		return Jwts.builder()
				.signWith(secretKey)
				.claims(claims)
				.subject(userDetails.getUsername())
				.issuedAt(new Date(System.currentTimeMillis()))
				.expiration(new Date(System.currentTimeMillis() + jwtConfig.getExpirationTime()))
				.compact();
	}

	@Override
	public String extractUsernameFromToken(String token) {
		Claims claims = Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token)
				.getPayload();

		return claims.getSubject();
	}

	@Override
	public boolean validateToken(String token) {
		try {
			Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token);
			return true;
		} catch (MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
			return false;
		}
	}
	
	@Override
	public List<String> extractAuthoritiesFromToken(String token) {
		Claims claims = Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token)
				.getPayload();

		@SuppressWarnings("unchecked")
		List<String> authorities = (List<String>) claims.get("Authorities");
		return authorities != null ? authorities : List.of();
	}
}
