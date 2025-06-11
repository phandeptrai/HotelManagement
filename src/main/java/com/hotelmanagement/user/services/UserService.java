package com.hotelmanagement.user.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hotelmanagement.user.entities.User;

@Service
public interface UserService {
	List<User> findPaged(int pageIndex, int pageSize, int userId);

	User findByUsername(String username);

	List<User> getAllUser();
	
	void save(User user);

	void update(User user);

	void deleteUserById(String username);
}
