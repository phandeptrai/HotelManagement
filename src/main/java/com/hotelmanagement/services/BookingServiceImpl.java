package com.hotelmanagement.services;

import java.util.List;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotelmanagement.daos.BookingDAO;
import com.hotelmanagement.dtos.BookingFilterRequest;
import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.BookingResponse;
import com.hotelmanagement.dtos.CancelBookingRequest;
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
	
	@Override
	@Transactional
	public void cancelBookRoom(CancelBookingRequest bookingRequest) {
		// Validate if booking exists and belongs to user
		BookingResponse booking = bookingDAO.getBookingDetailById(bookingRequest.getBookingId(), bookingRequest.getUserId());
		if (booking == null) {
			throw new IllegalArgumentException("Không tìm thấy đặt phòng hoặc bạn không có quyền hủy");
		}
		
		// Check if booking can be cancelled
		if (booking.getBookingStatus().equals("CANCELLED")) {
			throw new IllegalArgumentException("Đặt phòng này đã được hủy trước đó");
		}
		
		if (booking.getCheckInDate().isBefore(LocalDate.now())) {
			throw new IllegalArgumentException("Không thể hủy đặt phòng sau ngày check-in");
		}
		
		// Cancel booking
		bookingDAO.cancelBooking(bookingRequest);
		
		// Update room status back to available
		roomService.updateRoomStatus(booking.getRoomId(), RoomStatus.AVAILABLE);
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

	@Override
	public List<BookingResponse> getBookingHistoryByUserId(int userId) {
		return bookingDAO.getBookingHistoryByUserId(userId);
	}

	@Override
	public BookingResponse getBookingDetailById(int bookingId, int userId) {
		return bookingDAO.getBookingDetailById(bookingId, userId);
	}

	@Override
	public List<BookingResponse> getFilteredBookingHistory(BookingFilterRequest filter) {
		return bookingDAO.getFilteredBookingHistory(filter);
	}

}
