package com.hotelmanagement.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home() {
		return "redirect:/login";
	}

	@GetMapping("/home")
	public String showHomePage() {
		return "home"; 
	}

	@GetMapping("/login")
	public String loginForm() {
		return "/login";
	}
}
