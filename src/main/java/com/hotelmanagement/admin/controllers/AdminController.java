package com.hotelmanagement.admin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotelmanagement.admin.command.AddRoomCommand;
import com.hotelmanagement.admin.command.AdminCommand;
import com.hotelmanagement.admin.command.CommandExecutor;
import com.hotelmanagement.admin.command.EditRoomCommand;
import com.hotelmanagement.admin.command.LockRoomCommand;
import com.hotelmanagement.admin.dtos.RoomFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.services.RoomService;
import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.services.UserService;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {

	private CommandExecutor commandExecutor = new CommandExecutor();

	@Autowired
	private RoomService roomService;

	@Autowired
	private UserService userService;

	// ==============================
	// ROOM MANAGEMENT
	// ==============================

	@GetMapping("/roommanagement")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String showAllRoom(Model model) {
		List<Room> rooms = roomService.getAllRoom();
		model.addAttribute("rooms", rooms);
		return "admin/roommanagement";
	}

	@GetMapping("/room/add")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String showAddForm(Model model) {

		model.addAttribute("roomTypes", roomService.getAllRoomTypes());
		model.addAttribute("statuses", RoomStatus.values());
		return "admin/room/add";
	}

	@PostMapping("/room/add")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String createRoom(@ModelAttribute RoomFormDTO dto) {

		AdminCommand command = new AddRoomCommand(roomService, dto);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	@GetMapping("/room/edit")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String showEditForm(@RequestParam("id") int roomID, Model model) {

		Room room = roomService.getRoomByID(roomID);
		if (room == null) {
			return "redirect:/admin/roommanagement";
		}

		RoomFormDTO dto = new RoomFormDTO();
		dto.setRoomID(room.getRoomID());
		dto.setRoomNumber(room.getRoomNumber());
		dto.setRoomTypeID(room.getRoomTypeID());
		dto.setPrice(room.getPrice());
		dto.setRoomStatus(room.getRoomStatus());

		model.addAttribute("roomFormDTO", dto);
		model.addAttribute("roomTypes", roomService.getAllRoomTypes());
		model.addAttribute("statuses", RoomStatus.values());

		return "admin/room/edit";
	}

	@PostMapping("/room/edit")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String updateRoom(@ModelAttribute RoomFormDTO room) {

		AdminCommand command = new EditRoomCommand(roomService, room);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	@GetMapping("/room/lock")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String lockRoom(@RequestParam("id") int roomID) {

		AdminCommand command = new LockRoomCommand(roomService, roomID);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	// ==============================
	// USER MANAGEMENT
	// ==============================

	@GetMapping("/user/usermanagement")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String showAllUsers(Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "admin/user/usermanagement";
	}

	@GetMapping("/deleteUserById")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String deleteUserById(@RequestParam("username") String username) {
		userService.deleteUserById(username);
		return "redirect:/admin/user/usermanagement";
	}
	// ==============================
	// ERROR PAGE
	// ==============================

	@GetMapping("/403")
	public String accessDeniedPage() {
		return "403";
	}

}
