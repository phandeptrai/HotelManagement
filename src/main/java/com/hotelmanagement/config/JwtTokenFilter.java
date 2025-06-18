package com.hotelmanagement.config;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hotelmanagement.services.JWTService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {

	private static final Logger logger = LoggerFactory.getLogger(JwtTokenFilter.class);

	@Autowired
	private JWTService jwtService;

	@Autowired
	private UserDetailsService userDetailsService;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		try {
			String token = getJwtFromRequest(request);
			String requestURI = request.getRequestURI();
			
			logger.debug("Processing request: {}", requestURI);
			
			if (token != null && jwtService.validateToken(token)) {
				String username = jwtService.extractUsernameFromToken(token);
				List<String> roles = jwtService.extractAuthoritiesFromToken(token);
				Integer userId = jwtService.getUserIdFromToken(token);
				
				logger.debug("Token validated for user: {}, roles: {}, userId: {}", username, roles, userId);
				
				if (userId != null) {
					UserDetails userDetails = userDetailsService.loadUserByUsername(username);
					List<GrantedAuthority> authorities = roles.stream()
							.map(SimpleGrantedAuthority::new)
							.collect(Collectors.toList());

					UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
							userDetails, null, authorities);
					
					SecurityContextHolder.getContext().setAuthentication(authentication);
					logger.debug("Authentication set in SecurityContext");
				} else {
					logger.warn("Could not get userId from token");
					handleUnauthenticatedRequest(request, response);
					return;
				}
			} else if (isProtectedResource(requestURI)) {
				logger.warn("No valid token found for protected resource: {}", requestURI);
				handleUnauthenticatedRequest(request, response);
				return;
			}
		} catch (Exception ex) {
			logger.error("Could not set user authentication in security context", ex);
			if (isProtectedResource(request.getRequestURI())) {
				handleUnauthenticatedRequest(request, response);
				return;
			}
		}
		
		filterChain.doFilter(request, response);
	}

	@Override
	protected boolean shouldNotFilter(HttpServletRequest request) {
		String path = request.getRequestURI();
		// Chỉ bỏ qua các tài nguyên tĩnh
		return path.startsWith("/resources/") || 
			   path.startsWith("/css/") || 
			   path.startsWith("/js/") || 
			   path.startsWith("/images/") ||
			   path.equals("/login") ||
			   path.equals("/register") ||
			   path.equals("/403");
	}

	private String getJwtFromRequest(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("jwt_token".equals(cookie.getName())) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}

	private boolean isProtectedResource(String requestURI) {
		return requestURI.startsWith("/HotelManagement/admin/") || 
			   requestURI.startsWith("/HotelManagement/booking/") || 
			   requestURI.startsWith("/HotelManagement/booking-history/");
	}

	private void handleUnauthenticatedRequest(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		SecurityContextHolder.clearContext();
		response.sendRedirect("/HotelManagement/login");
	}
}
