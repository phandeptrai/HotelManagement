package com.hotelmanagement.admin.command;

import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.services.RoomService;

public class LockRoomCommand implements AdminCommand {
	private RoomService roomService;
	private int roomID;

	public LockRoomCommand(RoomService roomService, int roomID) {
		this.roomService = roomService;
		this.roomID = roomID;
	}

	@Override
	public void execute() {
		roomService.updateRoomStatus(roomID, RoomStatus.MAINTENANCE);
	}

	@Override
	public String getDescription() {
		return "Locked room ID: " + roomID;
	}
}
