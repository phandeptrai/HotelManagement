package com.hotelmanagement.services;

import com.hotelmanagement.dtos.BookingRequest;

public interface BookingService {
	public void bookRoom(BookingRequest bookingRequest);
}
