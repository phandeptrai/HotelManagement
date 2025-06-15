package com.hotelmanagement.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotelmanagement.room.models.Room;
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
}
