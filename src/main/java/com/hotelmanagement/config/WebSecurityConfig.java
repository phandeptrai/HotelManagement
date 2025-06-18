package com.hotelmanagement.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import jakarta.servlet.http.Cookie;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig {
	@Autowired
	private JwtTokenFilter jwtTokenFilter;

	private final UserDetailsService userDetailsService;

	public WebSecurityConfig(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests(auth -> auth
				// Yêu cầu xác thực và ROLE_ADMIN cho tất cả các trang admin
				.requestMatchers("/HotelManagement/admin/**").hasRole("ADMIN")
				// Cho phép truy cập các trang công khai
				.requestMatchers("/HotelManagement/", "/HotelManagement/home", "/HotelManagement/login", "/HotelManagement/register", 
					"/HotelManagement/403", "/HotelManagement/css/**", "/HotelManagement/js/**", 
					"/HotelManagement/images/**", "/HotelManagement/resources/**").permitAll()
				// Yêu cầu xác thực cho các trang booking và booking-history
				.requestMatchers("/HotelManagement/booking/**", "/HotelManagement/booking-history/**").authenticated()
				// Tất cả các request khác yêu cầu xác thực
				.anyRequest().authenticated()
			)
			.formLogin(form -> form
				.loginPage("/HotelManagement/login")
				.loginProcessingUrl("/HotelManagement/login")
				.successHandler((request, response, authentication) -> {
					// Kiểm tra role sau khi đăng nhập thành công
					boolean isAdmin = authentication.getAuthorities().stream()
							.anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));
					
					System.out.println("Login successful for user: " + authentication.getName());
					System.out.println("User authorities: " + authentication.getAuthorities());
					System.out.println("Is admin: " + isAdmin);
					
					if (isAdmin) {
						response.sendRedirect("/HotelManagement/admin/roommanagement");
					} else {
						response.sendRedirect("/HotelManagement/home");
					}
				})
				.failureHandler((request, response, exception) -> {
					System.err.println("Login failed: " + exception.getMessage());
					response.sendRedirect("/HotelManagement/login?error=true");
				})
				.permitAll()
			)
			.logout(logout -> logout
				.logoutUrl("/HotelManagement/logout")
				.logoutSuccessUrl("/HotelManagement/home")
				.deleteCookies("jwt_token")
				.permitAll()
			)
			.exceptionHandling(exception -> exception
				.accessDeniedPage("/HotelManagement/403")
			)
			.sessionManagement(session -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
			)
			.addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter.class)
			.addFilterBefore(jwtTokenFilter, BasicAuthenticationFilter.class);

		return http.build();
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
		return config.getAuthenticationManager();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(userDetailsService);
		provider.setPasswordEncoder(passwordEncoder());
		return provider;
	}
}
