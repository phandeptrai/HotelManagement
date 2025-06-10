package com.hotelmanagement.user.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	
	@Override
	public List<User> getAllUser(){
		return userRepository.getAllUser();
	}
	
	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public List<User> findPaged(int pageIndex, int pageSize, int userId) {
		return userRepository.findPaged(pageIndex, pageSize, userId);
	}

	@Override
	public void save(User user) {
		userRepository.save(user);
	}

	@Override
	public void update(User user) {
		userRepository.update(user);
	}

	@Override
	public void deleteUserById(String username) {
		userRepository.deleteUserById(username);
	}
}
