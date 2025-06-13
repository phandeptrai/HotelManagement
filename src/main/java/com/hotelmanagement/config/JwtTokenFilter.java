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

import com.hotelmanagement.services.JWTService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {
	@Autowired
	private JWTService jwtService;

	@Autowired
	private UserDetailsService userDetailsService;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws ServletException, IOException {

		String requestURI = request.getRequestURI();
		System.out.println("JwtTokenFilter processing request: " + requestURI);

		// Lấy token từ cookie
		String token = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("jwt_token".equals(cookie.getName())) {
					token = cookie.getValue();
					break;
				}
			}
		}

		// Xử lý xác thực cho tất cả các request
		if (token != null && jwtService.validateToken(token)) {
			try {
				String username = jwtService.extractUsernameFromToken(token);
				UserDetails userDetails = userDetailsService.loadUserByUsername(username);
				List<String> roles = jwtService.extractAuthoritiesFromToken(token);
				
				System.out.println("JwtTokenFilter - User: " + username);
				System.out.println("JwtTokenFilter - Roles from token: " + roles);

				// Tạo authentication token
				List<GrantedAuthority> authorities = roles.stream()
						.map(SimpleGrantedAuthority::new)
						.collect(Collectors.toList());

				UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
					userDetails, null, authorities);
				
				// Đặt authentication vào SecurityContext
				SecurityContextHolder.getContext().setAuthentication(authToken);

				// Kiểm tra quyền truy cập admin
				if (requestURI.startsWith("/admin/")) {
					boolean hasAdminRole = roles.stream()
							.anyMatch(role -> role.equals("ROLE_ADMIN"));
					
					System.out.println("JwtTokenFilter - Checking admin access: " + hasAdminRole);

					if (!hasAdminRole) {
						System.out.println("JwtTokenFilter - Access denied: User does not have ROLE_ADMIN");
						response.sendRedirect("/403");
						return;
					}
				}

				// Chuyển hướng admin đến trang quản lý phòng
				if (requestURI.equals("/admin")) {
					boolean hasAdminRole = roles.stream()
							.anyMatch(role -> role.equals("ROLE_ADMIN"));
					if (hasAdminRole) {
						response.sendRedirect("/admin/roommanagement");
						return;
					}
				}
				
			} catch (Exception e) {
				System.err.println("JwtTokenFilter - Error processing JWT token: " + e.getMessage());
				SecurityContextHolder.clearContext();
				if (requestURI.startsWith("/admin/") || requestURI.startsWith("/booking/")) {
					response.sendRedirect("/login");
					return;
				}
			}
		} else if (requestURI.startsWith("/admin/") || requestURI.startsWith("/booking/")) {
			System.out.println("JwtTokenFilter - No valid token found for protected resource");
			response.sendRedirect("/login");
			return;
		}

		chain.doFilter(request, response);
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
}
