package com.hotelmanagement.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.services.RoomService;

@Controller
public class HomeController {
	private final RoomService roomService;
	
	@Autowired
	public HomeController(RoomService roomService) {
		this.roomService = roomService;
	}
	
	@GetMapping("/")
	public String home() {
		return "redirect:/login";
	}
	
	
	
	@GetMapping("/home")
	public String showHomePage(Model model) {
        List<Room> rooms = roomService.getAllRoom();
        model.addAttribute("rooms", rooms);
        return "home";
}
	//@GetMapping("/home")
	//public String showHomePage() {
		//return "home"; 
	//}

	@GetMapping("/login")
	public String loginForm() {
		return "/login";
	}
}
