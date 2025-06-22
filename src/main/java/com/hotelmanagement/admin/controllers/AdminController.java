package com.hotelmanagement.admin.controllers;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
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
import com.hotelmanagement.admin.command.EditUserCommand;
import com.hotelmanagement.admin.command.LockRoomCommand;
import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.dtos.StatisticsDTO;
import com.hotelmanagement.dtos.UserFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.services.RoomService;
import com.hotelmanagement.services.ReportService;
import com.hotelmanagement.services.StatisticsService;
import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.entities.UserRole;
import com.hotelmanagement.user.services.UserService;

@Controller
@RequestMapping("/admin")

public class AdminController {

	private CommandExecutor commandExecutor = new CommandExecutor();

	@Autowired
	private RoomService roomService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private StatisticsService statisticsService;
	
	@Autowired
	private ReportService reportService;

	// ==============================
	// DASHBOARD & STATISTICS
	// ==============================
	
	@GetMapping("/dashboard")
	public String showDashboard(Model model) {
		StatisticsDTO stats = statisticsService.getDashboardStatistics();
		model.addAttribute("stats", stats);
		return "admin/dashboard";
	}
	
	@GetMapping("/statistics")
	public String showDetailedStatistics(Model model, 
			@RequestParam(name = "startDate", required = false) String startDate,
			@RequestParam(name = "endDate", required = false) String endDate) {
		StatisticsDTO stats;
		if (startDate != null && endDate != null) {
			stats = statisticsService.getStatisticsByDateRange(startDate, endDate);
		} else {
			stats = statisticsService.getDashboardStatistics();
		}
		model.addAttribute("stats", stats);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		return "admin/statistics";
	}
	
	@GetMapping("/export/excel")
	public ResponseEntity<byte[]> exportExcelReport() {
		try {
			ByteArrayOutputStream outputStream = reportService.generateExcelReport();
			byte[] bytes = outputStream.toByteArray();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.parseMediaType("text/csv; charset=UTF-8"));
			headers.setContentDispositionFormData("attachment", "hotel_statistics_report.csv");
			
			return ResponseEntity.ok()
					.headers(headers)
					.body(bytes);
					
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.internalServerError().build();
		}
	}
	
	@GetMapping("/realtime-stats")
	public String showRealtimeStatistics(Model model) {
		StatisticsDTO stats = statisticsService.getDashboardStatistics();
		model.addAttribute("stats", stats);
		return "admin/realtime-stats";
	}

	@GetMapping("/dashboard-data")
	public ResponseEntity<StatisticsDTO> getDashboardData() {
		StatisticsDTO stats = statisticsService.getDashboardStatistics();
		return ResponseEntity.ok(stats);
	}

	// ==============================
	// ROOM MANAGEMENT
	// ==============================

	@GetMapping("/roommanagement")

	public String showAllRoom(Model model) {
		List<Room> rooms = roomService.getAllRoom();
		model.addAttribute("rooms", rooms);
		return "admin/roommanagement";
	}

	@GetMapping("/room/add")

	public String showAddForm(Model model) {

		model.addAttribute("roomTypes", roomService.getAllRoomTypes());
		model.addAttribute("statuses", RoomStatus.values());
		return "admin/room/add";
	}

	@PostMapping("/room/add")

	public String createRoom(@ModelAttribute RoomFormDTO dto) {

		AdminCommand command = new AddRoomCommand(roomService, dto);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	@GetMapping("/room/edit")
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
	public String updateRoom(@ModelAttribute RoomFormDTO room) {

		AdminCommand command = new EditRoomCommand(roomService, room);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	@GetMapping("/room/lock")
	public String lockRoom(@RequestParam("id") int roomID) {

		AdminCommand command = new LockRoomCommand(roomService, roomID);
		commandExecutor.execute(command);
		return "redirect:/admin/roommanagement";
	}

	// ==============================
	// USER MANAGEMENT
	// ==============================

	@GetMapping("/user/usermanagement")
	public String showAllUsers(Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "admin/user/usermanagement";
	}

	@GetMapping("/deleteUserById")
	public String deleteUserById(@RequestParam("username") String username) {
		userService.deleteUserById(username);
		return "redirect:/admin/user/usermanagement";
	}


	@GetMapping("/user/edit")
	public String showEditUserForm(@RequestParam("username") String username, Model model) {
		User user = userService.findByUsername(username);
		if (user == null) {
			return "redirect:/admin/user/usermanagement";
		}

		UserFormDTO dto = new UserFormDTO();
		dto.setUserID(user.getId());
		dto.setUsername(user.getUsername());
		dto.setFullName(user.getFullName());
		dto.setEmail(user.getEmail());
		dto.setPhoneNumber(user.getPhoneNumber());
		dto.setUserRole(user.getRole());

		model.addAttribute("user", dto);
		model.addAttribute("roles", UserRole.values());
		return "admin/user/edit";
	}

	@PostMapping("/user/edit")
	public String updateUser(@ModelAttribute("user") UserFormDTO dto) {
	    AdminCommand command = new EditUserCommand(userService, dto, passwordEncoder);
	    commandExecutor.execute(command);
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
