package com.hotelmanagement.user.entities;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class User implements UserDetails {
	private static final long serialVersionUID = 1L;
	private int userID;
	private String username;
	private String password;
	private UserRole role;
	private LocalDateTime createdAt;
	private String fullName;
	private String email;
	private String phoneNumber;

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public User(int id, String username, String password, UserRole role) {
		super();
		this.userID = id;
		this.username = username;
		this.password = password;
		this.role = role;
		this.createdAt = LocalDateTime.now();
	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
		createdAt = LocalDateTime.now();
	}

	public User() {
		super();
	}

	public int getId() {
		return userID;
	}

	public void setId(int id) {
		this.userID = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserRole getRole() {
		return role;
	}

	public void setRole(UserRole role) {
		this.role = role;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (role == null) {
			System.out.println("Warning: User " + username + " has no role assigned");
			return Collections.emptyList();
		}
		String roleName = role.name();
		System.out.println("User " + username + " has role: " + roleName);
		return Collections.singletonList(new SimpleGrantedAuthority(roleName));
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
	@Override
	public String toString() {
	    return "User{" +
	            "userID=" + userID +
	            ", username='" + username + '\'' +
	            ", password='" + password + '\'' +
	            ", role=" + role +
	            ", createdAt=" + createdAt +
	            ", fullName='" + fullName + '\'' +
	            ", email='" + email + '\'' +
	            ", phoneNumber='" + phoneNumber + '\'' +
	            '}';
	}

}
