package com.hotelmanagement.payment;
	
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.hotelmanagement.services.BookingService;
import com.hotelmanagement.dtos.PaymentRequest;

@Component("cash")
public class CashPaymentStrategy implements PaymentStrategy {

    @Autowired
    private BookingService bookingService;
    
    @Override
    public String pay(HttpServletRequest request, PaymentRequest paymentRequest) {
        bookingService.bookRoom(paymentRequest.getBookingRequest());
        return "redirect:/booking/success";
    }
}
