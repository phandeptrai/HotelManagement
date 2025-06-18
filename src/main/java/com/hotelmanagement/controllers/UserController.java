package com.hotelmanagement.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotelmanagement.services.BookingService;
import com.hotelmanagement.services.JWTService;

import ch.qos.logback.core.model.Model;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	private BookingService bookingService;
	private JWTService jwtService;
	@Autowired
	public UserController(BookingService bookingService,JWTService jwtService) {
		super();
		this.bookingService = bookingService;
		this.jwtService = jwtService;
	}


}
