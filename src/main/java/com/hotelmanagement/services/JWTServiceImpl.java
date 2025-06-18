package com.hotelmanagement.services;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hotelmanagement.config.JwtConfig;
import com.hotelmanagement.user.entities.User;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;

@Service
public class JWTServiceImpl implements JWTService {
	private final JwtConfig jwtConfig;
	private final SecretKey secretKey;
	private static final String USER_ID_CLAIM = "userId";
	private static final String AUTHORITIES_CLAIM = "authorities";
	private static final Logger logger = LoggerFactory.getLogger(JWTServiceImpl.class);

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

		Integer userId = ((User) userDetails).getId();
		return generateToken(userDetails.getUsername(), authorities, userId);
	}

	@Override
	public String generateToken(String username, List<String> authorities, Integer userId) {
		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + jwtConfig.getExpirationTime());

		return Jwts.builder()
				.setSubject(username)
				.claim(USER_ID_CLAIM, userId)
				.claim(AUTHORITIES_CLAIM, authorities)
				.setIssuedAt(now)
				.setExpiration(expiryDate)
				.signWith(secretKey)
				.compact();
	}

	@Override
	public boolean validateToken(String token) {
		try {
			Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token);
			return true;
		} catch (SignatureException ex) {
			logger.error("Invalid JWT signature");
		} catch (MalformedJwtException ex) {
			logger.error("Invalid JWT token");
		} catch (ExpiredJwtException ex) {
			logger.error("Expired JWT token");
		} catch (UnsupportedJwtException ex) {
			logger.error("Unsupported JWT token");
		} catch (IllegalArgumentException ex) {
			logger.error("JWT claims string is empty");
		}
		return false;
	}

	@Override
	public String extractUsernameFromToken(String token) {
		return extractClaims(token).getSubject();
	}

	@Override
	public List<String> extractAuthoritiesFromToken(String token) {
		Claims claims = extractClaims(token);
		@SuppressWarnings("unchecked")
		List<String> authorities = (List<String>) claims.get(AUTHORITIES_CLAIM);
		return authorities != null ? authorities : List.of();
	}

	@Override
	public Integer getUserIdFromToken(String token) {
		try {
			return extractClaims(token).get(USER_ID_CLAIM, Integer.class);
		} catch (Exception e) {
			logger.error("Error getting userId from token", e);
			return null;
		}
	}

	@Override
	public boolean isTokenExpired(String token) {
		try {
			Date expiration = extractClaims(token).getExpiration();
			return expiration.before(new Date());
		} catch (Exception e) {
			logger.error("Error checking token expiration", e);
			return true;
		}
	}

	private Claims extractClaims(String token) {
		return Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token)
				.getPayload();
	}
}
