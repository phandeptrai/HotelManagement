package com.hotelmanagement.stub;



public class User  {
	private int userID;
	private String username;
	private String password;
	private String fullName;
	private String email;
	private String phoneNumber;
	
	public User(int userID, String username, String password, String fullName, String email, String phoneNumber) {
		super();
		this.userID = userID;
		this.username = username;
		this.password = password;
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber = phoneNumber;
	}
	public User() {
		// TODO Auto-generated constructor stub
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
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
	
	
}
