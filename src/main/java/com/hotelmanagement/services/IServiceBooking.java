package com.hotelmanagement.services;

import java.util.List;

import com.hotelmanagement.dtos.ServiceBookingResponse;

public interface IServiceBooking {
	List<ServiceBookingResponse> getAllServices();
	int getPriceById(int id);
	List<ServiceBookingResponse> getServiceByBookingId(int bookingId);
}
 