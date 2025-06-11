package com.hotelmanagement.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.daos.ServiceBookingDAO;
import com.hotelmanagement.dtos.ServiceBookingResponse;

@Service
public class ServiceBookingImpl implements IServiceBooking{

	@Autowired
	private ServiceBookingDAO serviceBookings;
	@Override
	public List<ServiceBookingResponse> getAllServices() {
		
		return serviceBookings.getAllServices();
	}
	@Override
	public int getPriceById(int id) {
	    return serviceBookings.getAllServices().stream()
	            .filter(s -> s.getId() == id)
	            .findFirst()
	            .map(ServiceBookingResponse::getPrice) // trả về int
	            .orElse(0); // OK nếu getPrice() trả về int
	}



}
