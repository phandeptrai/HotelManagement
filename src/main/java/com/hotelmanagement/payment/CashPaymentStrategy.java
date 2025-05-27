	package com.hotelmanagement.payment;
	
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpSession;
	
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Component;
	
	import com.hotelmanagement.dtos.BookingRequest;
	import com.hotelmanagement.services.BookingService;
	
	@Component("cash")
	public class CashPaymentStrategy implements PaymentStrategy {
	
		@Autowired
		private BookingService bookingService;
	    @Override
	    public String pay(HttpServletRequest request, HttpSession session, int amount) {
	    	 BookingRequest bookingRequest = (BookingRequest) session.getAttribute("bookingRequest");
	         if (bookingRequest != null) {
	             bookingService.bookRoom(bookingRequest); 
	         }
	        return "redirect:/booking/success";
	    }
	}
