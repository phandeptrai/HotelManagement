package com.hotelmanagement.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomSearchCriteria;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.models.enums.RoomTypeName;
import com.hotelmanagement.room.services.RoomService;

@Controller
@RequestMapping("/rooms")
public class RoomController {

    private final RoomService roomService;

    @Autowired
    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    // Trang danh sách phòng (view: room/list.jsp)
    @GetMapping
    public String listRooms(Model model) {
        List<Room> rooms = roomService.getAllRoom();
        model.addAttribute("rooms", rooms);
        return "room/list";
    }

    // Chi tiết phòng (view: room/details.jsp)
    @GetMapping("/{id}")
    public String roomDetails(@PathVariable("id") int id, Model model) {
        Room room = roomService.getRoomByID(id);
        if (room == null) {
            return "redirect:/rooms";
        }
        model.addAttribute("room", room);
        return "details";
    }

    // Home.jsp (hiển thị danh sách phòng giống room/list.jsp)
    @GetMapping("/home")
    public String home(Model model) {
        List<Room> rooms = roomService.getAllRoom();
        model.addAttribute("rooms", rooms);
        return "home";
    }
    
    // Hiển thị form tìm kiếm
    @GetMapping("/search")
    public String showSearchForm(Model model) {
        // Thêm các dữ liệu cần thiết cho form search
        model.addAttribute("criteria", new RoomSearchCriteria());
        model.addAttribute("roomTypes", RoomTypeName.values());
        model.addAttribute("roomStatuses", RoomStatus.values());
        return "room/search";
    }
    
    // Xử lý tìm kiếm phòng
    @PostMapping("/search")
    public String searchRooms(@ModelAttribute("criteria") RoomSearchCriteria criteria, Model model) {
        List<Room> rooms = roomService.searchRooms(criteria);
        model.addAttribute("rooms", rooms);
        model.addAttribute("roomTypes", RoomTypeName.values());
        model.addAttribute("roomStatuses", RoomStatus.values());
        return "room/search-results";
    }
    
    // Tìm kiếm phòng theo GET request (cho AJAX hoặc link)
    @GetMapping("/search-results")
    public String searchRoomsGet(
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
        model.addAttribute("criteria", criteria);
        model.addAttribute("roomTypes", RoomTypeName.values());
        model.addAttribute("roomStatuses", RoomStatus.values());
        
        return "room/search-results";
    }

}
