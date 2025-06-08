package com.hotelmanagement.room.dao;

import java.util.List;

import com.hotelmanagement.admin.dtos.RoomFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;

public interface RoomDAO {
	Room getRoomByID(int id);
	List<Room> getAllRoom();
	List<Room> getAvailableRooms(); 
	void insertRoom(RoomFormDTO dto);
	void updateRoom(RoomFormDTO room);
	void updateRoomStatus(int roomID, RoomStatus status);
	List<RoomType> getAllRoomTypes();
}
