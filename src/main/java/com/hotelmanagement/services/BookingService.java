package com.hotelmanagement.services;

import java.util.List;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.BookingResponse;
import com.hotelmanagement.dtos.CancelBookingRequest;
import com.hotelmanagement.dtos.BookingFilterRequest;

public interface BookingService {
	
	void bookRoom(BookingRequest bookingRequest);
	void bookRoom(BookingRequest bookingRequest, String bookingStatus);
	void cancelBookRoom(CancelBookingRequest bookingRequest);
	List<BookingResponse> getBookingHistoryByUserId(int userId);
	BookingResponse getBookingDetailById(int bookingId, int userId);
	List<BookingResponse> getFilteredBookingHistory(BookingFilterRequest filter);
	void confirmBooking(int bookingId);
	List<BookingResponse> getAllBookings();
}
