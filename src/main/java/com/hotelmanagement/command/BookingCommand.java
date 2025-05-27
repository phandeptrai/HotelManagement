package com.hotelmanagement.command;

import com.hotelmanagement.dtos.BookingRequest;

public interface BookingCommand {
	void execute(BookingRequest bookingRequest);
}
