package com.hotelmanagement.user.repositories;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.user.dao.UserDAO;
import com.hotelmanagement.user.entities.User;

@Repository
public class UserRepositoryImpl implements UserRepository {

	private final UserDAO userDAO;

	@Autowired
	public UserRepositoryImpl(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public List<User> findPaged(int pageIndex, int pageSize, int userId) {
		return userDAO.findPaged(pageIndex, pageSize, userId);
	}

	@Override
	public User findByUsername(String username) {
		return userDAO.findByUsername(username);
	}

	@Override
	public List<User> getAllUser() {
		return userDAO.getAllUser();
	}

	@Override
	public void save(User user) {
		userDAO.save(user);
	}

	@Override
	public void update(User user) {
		userDAO.update(user);
	}

	@Override
	public void deleteUserById(String username) {
		userDAO.deleteUserById(username);
	}

	@Override
	public User findById(int userId) {
		return userDAO.findById(userId);
	}

}
