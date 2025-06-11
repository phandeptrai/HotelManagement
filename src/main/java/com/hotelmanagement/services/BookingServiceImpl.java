package com.hotelmanagement.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.daos.BookingDAO;
import com.hotelmanagement.dtos.BookingRequest;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDAO bookingRepository;

	@Override
	public void bookRoom(BookingRequest bookingRequest) {
		// Validate booking request
		validateBookingRequest(bookingRequest);
		
		// Save booking to database
		bookingRepository.bookRoom(bookingRequest);
	}

	private void validateBookingRequest(BookingRequest bookingRequest) {
		// Add any necessary validation logic here
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
