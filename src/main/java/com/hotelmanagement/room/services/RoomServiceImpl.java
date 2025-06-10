package com.hotelmanagement.room.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.repositories.RoomRepository;

@Service
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomRepository roomRepository;

	@Override
	public List<Room> getAvailableRooms() {
		return roomRepository.getAvailableRooms();
	}

	@Override
	public void insertRoom(RoomFormDTO dto) {
		roomRepository.insertRoom(dto);
	}

	@Override
	public List<RoomType> getAllRoomTypes() {
		return roomRepository.getAllRoomTypes();
	}
	
	@Override
	public List<Room> getAllRoom() {
	    return roomRepository.getAllRoom();
	}
	
	@Override
	public Room getRoomByID(int id) {
	    return roomRepository.getRoomByID(id);
	}
	
	@Override
	public void updateRoom(RoomFormDTO room) {
		roomRepository.updateRoom(room);
	}
	
	
	@Override
	public void updateRoomStatus(int roomID, RoomStatus status) {
		roomRepository.updateRoomStatus(roomID, status);
	}
}
