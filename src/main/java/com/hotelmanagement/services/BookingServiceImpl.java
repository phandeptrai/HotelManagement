package com.hotelmanagement.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.daos.BookingDAO;
import com.hotelmanagement.dtos.BookingRequest;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	BookingDAO bookingRepository;
	@Override
	public void bookRoom(BookingRequest bookingRequest) {
		bookingRepository.bookRoom(bookingRequest);

	}

}
