package com.hotelmanagement.payment;

import jakarta.servlet.http.HttpServletRequest;
import com.hotelmanagement.dtos.PaymentRequest;

public interface PaymentStrategy {
    String pay(HttpServletRequest request, PaymentRequest paymentRequest);
}
