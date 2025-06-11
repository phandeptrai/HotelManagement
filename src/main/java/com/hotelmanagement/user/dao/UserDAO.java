package com.hotelmanagement.user.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.user.entities.User;

@Repository	
public interface UserDAO {
	List<User> findPaged(int pageIndex, int pageSize, int userId);

	User findByUsername(String username);

	List<User> getAllUser();
	
	void save(User user);

	void update(User user);

	void deleteUserById(String username);
}
