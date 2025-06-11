package com.hotelmanagement.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotelmanagement.daos.BookingDAO;
import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.services.RoomService;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDAO bookingDAO;
	
	@Autowired
	private RoomService roomService;

	@Override
	@Transactional
	public void bookRoom(BookingRequest bookingRequest) {
		// Validate booking request
		validateBookingRequest(bookingRequest);
		

		Room room = roomService.getRoomByID(bookingRequest.getRoomId());
		if (room == null) {
			throw new IllegalArgumentException("Room not found");
		}
		
		if (room.getRoomStatus() != RoomStatus.AVAILABLE) {
			throw new IllegalArgumentException("Room is not available for booking");
		}
		

		bookingDAO.bookRoom(bookingRequest);
		

		roomService.updateRoomStatus(bookingRequest.getRoomId(), RoomStatus.BOOKED);
	}

	private void validateBookingRequest(BookingRequest bookingRequest) {

		if (bookingRequest.getCheckInDate() == null || bookingRequest.getCheckOutDate() == null) {
			throw new IllegalArgumentException("Check-in and check-out dates are required");
		}
		
		if (bookingRequest.getCheckInDate().isAfter(bookingRequest.getCheckOutDate())) {
			throw new IllegalArgumentException("Check-in date must be before check-out date");
		}
		
		if (bookingRequest.getUserId() <= 0 || bookingRequest.getRoomId() <= 0) {
			throw new IllegalArgumentException("Invalid user ID or room ID");
		}
	}
}
