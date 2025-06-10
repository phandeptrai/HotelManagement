package com.hotelmanagement.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.repositories.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	private UserRepository userRepository;

	@Autowired
	public CustomUserDetailsService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User foundUserOpt = userRepository.findByUsername(username);
		if (foundUserOpt == null) {
			throw new UsernameNotFoundException("No user found with this username: " + username);
		}

		return foundUserOpt;
	}

}