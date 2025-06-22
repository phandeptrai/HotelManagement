package com.hotelmanagement.room.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomSearchCriteria;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;

@Service
public interface RoomService {
	Room getRoomByID(int id);
	List<Room> getAllRoom();
	List<Room> getAvailableRooms();
	void insertRoom(RoomFormDTO dto);
	void updateRoom(RoomFormDTO room);
	void updateRoomStatus(int roomID, RoomStatus status);
	List<RoomType> getAllRoomTypes();
    List<Room> searchRooms(RoomSearchCriteria criteria);
}
