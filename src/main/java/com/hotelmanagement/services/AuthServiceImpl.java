package com.hotelmanagement.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.hotelmanagement.dtos.SignUpRequest;
import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.entities.UserRole;
import com.hotelmanagement.user.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService{
	private PasswordEncoder passwordEncoder;
	private UserRepository userRepository;

	@Autowired
	public AuthServiceImpl(PasswordEncoder passwordEncoder, UserRepository userRepository) {
		this.passwordEncoder = passwordEncoder;
		this.userRepository = userRepository;
	}

	public void signUp(SignUpRequest signUpRequest) {
		// Validate input
		if (signUpRequest.getUsername() == null || signUpRequest.getUsername().trim().isEmpty()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Tên đăng nhập không được để trống.");
		}
		
		if (signUpRequest.getPassword() == null || signUpRequest.getPassword().trim().isEmpty()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Mật khẩu không được để trống.");
		}
		
		if (signUpRequest.getConfirmPassword() == null || signUpRequest.getConfirmPassword().trim().isEmpty()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Vui lòng xác nhận mật khẩu.");
		}
		
		if (!signUpRequest.getPassword().equals(signUpRequest.getConfirmPassword())) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Mật khẩu xác nhận không khớp.");
		}
		
		if (signUpRequest.getUsername().length() < 3) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Tên đăng nhập phải có ít nhất 3 ký tự.");
		}
		
		if (signUpRequest.getPassword().length() < 6) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Mật khẩu phải có ít nhất 6 ký tự.");
		}

		User existingUser = userRepository.findByUsername(signUpRequest.getUsername());
		if (existingUser != null) {
			throw new ResponseStatusException(HttpStatus.CONFLICT,
				"Tên đăng nhập '" + signUpRequest.getUsername() + "' đã tồn tại. Vui lòng chọn tên khác.");
		}

		String encodedPassword = passwordEncoder.encode(signUpRequest.getPassword());
		String username = signUpRequest.getUsername();

		User user = new User(username, encodedPassword);
	
		user.setRole(UserRole.ROLE_USER);
		userRepository.save(user);
	}
}
