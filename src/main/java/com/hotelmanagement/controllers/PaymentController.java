package com.hotelmanagement.controllers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.services.BookingService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private BookingService bookingService;

	@GetMapping("/vnpay-return")
	public String vnpayReturn(HttpServletRequest request, HttpSession session, Model model) {
		String vnp_TxnRef = request.getParameter("vnp_TxnRef");
		String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");

		if ("00".equals(vnp_ResponseCode)) {
			 BookingRequest bookingRequest = (BookingRequest) session.getAttribute("bookingRequest");
            if (bookingRequest != null) {
                bookingService.bookRoom(bookingRequest); 
            }
			model.addAttribute("message", "Thanh toán thành công. Mã giao dịch: " + vnp_TxnRef);
		} else {
			model.addAttribute("message", "Thanh toán thất bại. Mã lỗi: " + vnp_ResponseCode);
		}

		return "paymentResult";
	}
}
