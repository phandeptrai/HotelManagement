package com.hotelmanagement.stub.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.stub.User;

@Repository
public class UserDAO {
	private final DataSource dataSource;

	@Autowired
	public UserDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}


	public User getStubUser() {
		String sql = "SELECT * FROM users WHERE userID = 4";
		try (Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			while (rs.next()) {
				return mapUser(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public User findByUsername(String username) {
		String sql = "SELECT * FROM users WHERE username = ?";
		try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, username);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return mapUser(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}










	private User mapUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUserID(rs.getInt("userID"));
		user.setUsername(rs.getString("username"));
		user.setPassword(rs.getString("password"));
		user.setFullName(rs.getString("fullName"));
		user.setEmail(rs.getString("email"));
		user.setPhoneNumber(rs.getString("phoneNumber"));

		return user;
	}

}

