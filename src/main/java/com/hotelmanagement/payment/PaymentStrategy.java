package com.hotelmanagement.payment;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface PaymentStrategy {
    String pay(HttpServletRequest request, HttpSession session, int amount);
}
