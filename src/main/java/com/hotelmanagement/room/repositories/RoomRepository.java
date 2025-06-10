package com.hotelmanagement.room.repositories;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;

@Repository
public interface RoomRepository {
	Room getRoomByID(int id);
	List<Room>getAllRoom();
	List<Room> getAvailableRooms();
	void insertRoom(RoomFormDTO dto);
	void updateRoom(RoomFormDTO room);
	void updateRoomStatus(int roomID, RoomStatus status);
	List<RoomType> getAllRoomTypes();
}
