package com.hotelmanagement.dtos;

public class SignUpRequest {
	private String username;
	private String password;
	private String confirmPassword;
	private String role;
	
	public SignUpRequest() {}
	
	public SignUpRequest(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}
		
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
}
