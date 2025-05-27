package com.hotelmanagement.command;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.services.BookingService;

@Component("book")
public class BookRoomCommand implements BookingCommand {

	@Autowired
	private BookingService bookingService;
	@Override
	public void execute(BookingRequest bookingRequest) {

	}

}
