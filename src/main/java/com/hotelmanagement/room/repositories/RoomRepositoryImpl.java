package com.hotelmanagement.room.repositories;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.dao.RoomDAO;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomSearchCriteria;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;

@Repository
public class RoomRepositoryImpl implements RoomRepository {

	private final RoomDAO roomDAO;

	@Autowired
	public RoomRepositoryImpl(RoomDAO roomDAO) {
		this.roomDAO = roomDAO;
	}

	@Override
	public List<Room> getAvailableRooms() {
		return roomDAO.getAvailableRooms();
	}

	@Override
	public void insertRoom(RoomFormDTO dto) {
		roomDAO.insertRoom(dto);
	}

	@Override
	public List<RoomType> getAllRoomTypes() {
		return roomDAO.getAllRoomTypes();
	}

	@Override
	public List<Room> getAllRoom() {
		return roomDAO.getAllRoom();
	}

	@Override
	public Room getRoomByID(int id) {
		return roomDAO.getRoomByID(id);
	}

	@Override
	public void updateRoom(RoomFormDTO room) {
		roomDAO.updateRoom(room);
	}

	@Override
	public void updateRoomStatus(int roomID, RoomStatus status) {
		roomDAO.updateRoomStatus(roomID, status);
	}
	
	@Override
	public List<Room> searchRooms(RoomSearchCriteria criteria) {
	    return roomDAO.searchRooms(criteria);
	}

	
}
