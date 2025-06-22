package com.hotelmanagement.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomSearchCriteria;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.models.enums.RoomTypeName;
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
	
	@GetMapping("/home/search")
	public String searchRooms(
			@RequestParam(value = "roomNumber", required = false) String roomNumber,
			@RequestParam(value = "roomTypeName", required = false) String roomTypeName,
			@RequestParam(value = "minPrice", required = false) Integer minPrice,
			@RequestParam(value = "maxPrice", required = false) Integer maxPrice,
			@RequestParam(value = "roomStatus", required = false) String roomStatus,
			@RequestParam(value = "available", required = false) Boolean available,
			Model model) {
		
		RoomSearchCriteria criteria = new RoomSearchCriteria();
		criteria.setRoomNumber(roomNumber);
		
		if (roomTypeName != null && !roomTypeName.isEmpty()) {
			try {
				criteria.setRoomTypeName(RoomTypeName.valueOf(roomTypeName.toUpperCase()));
			} catch (IllegalArgumentException e) {
				// Ignore invalid room type
			}
		}
		
		criteria.setMinPrice(minPrice);
		criteria.setMaxPrice(maxPrice);
		
		if (roomStatus != null && !roomStatus.isEmpty()) {
			try {
				criteria.setRoomStatus(RoomStatus.valueOf(roomStatus.toUpperCase()));
			} catch (IllegalArgumentException e) {
				// Ignore invalid room status
			}
		}
		
		criteria.setAvailable(available);
		
		List<Room> rooms = roomService.searchRooms(criteria);
		model.addAttribute("rooms", rooms);
		
		return "home";
	}

	@GetMapping("/login")
	public String loginForm() {
		return "/login";
	}

	@GetMapping("/403")
	public String accessDenied() {
		return "error/403";
	}
}
