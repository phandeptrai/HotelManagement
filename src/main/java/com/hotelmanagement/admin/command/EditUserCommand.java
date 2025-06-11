package com.hotelmanagement.admin.command;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.hotelmanagement.dtos.UserFormDTO;
import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.services.UserService;

public class EditUserCommand implements AdminCommand{
	 private final UserService userService;
	    private final UserFormDTO dto;
	    private final PasswordEncoder passwordEncoder;

	    public EditUserCommand(UserService userService, UserFormDTO dto, PasswordEncoder passwordEncoder) {
	        this.userService = userService;
	        this.dto = dto;
	        this.passwordEncoder = passwordEncoder;
	    }

	    @Override
	    public void execute() {
	        User existingUser = userService.findByUsername(dto.getUsername());
	        if (existingUser == null) {
	            System.err.println("User not found: " + dto.getUsername());
	            return;
	        }

	        existingUser.setFullName(dto.getFullName());
	        existingUser.setEmail(dto.getEmail());
	        existingUser.setPhoneNumber(dto.getPhoneNumber());
	        existingUser.setRole(dto.getUserRole());

	        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
	            existingUser.setPassword(passwordEncoder.encode(dto.getPassword()));
	        }

	        userService.update(existingUser);
	    }


	    @Override
	    public String getDescription() {
	        return "Edited user: " + dto.getUsername();
	    }
}
