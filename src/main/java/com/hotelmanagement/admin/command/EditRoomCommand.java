package com.hotelmanagement.admin.command;

import com.hotelmanagement.admin.dtos.RoomFormDTO;
import com.hotelmanagement.room.services.RoomService;

public class EditRoomCommand implements AdminCommand{
    private final RoomService roomService;
    private final RoomFormDTO dto;

    public EditRoomCommand(RoomService roomService, RoomFormDTO dto) {
        this.roomService = roomService;
        this.dto = dto;
    }

    @Override
    public void execute() {
        roomService.updateRoom(dto);
    }

    @Override
    public String getDescription() {
        return "Edited room ID: " + dto.getRoomID() + ", new number: " + dto.getRoomNumber();
    }
}
