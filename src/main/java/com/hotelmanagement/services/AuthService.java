package com.hotelmanagement.services;

import com.hotelmanagement.dtos.SignUpRequest;

public interface AuthService {
	void signUp(SignUpRequest signUpDTO);
}
