package com.hotelmanagement.admin.command;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.services.RoomService;

public class AddRoomCommand implements AdminCommand {
	private RoomService roomService;
	private RoomFormDTO dto;

	public AddRoomCommand(RoomService roomService, RoomFormDTO dto) {
		this.roomService = roomService;
		this.dto = dto;
	}

	@Override
	public void execute() {
		roomService.insertRoom(dto);
	}

	@Override
	public String getDescription() {
		return "Added room: " + dto.getRoomNumber();
	}
}
