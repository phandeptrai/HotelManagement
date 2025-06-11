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
				try {
					// Đảm bảo tổng tiền đã được tính đúng trước khi lưu
					if (bookingRequest.getTotalPrice() <= 0) {
						model.addAttribute("message", "Lỗi: Tổng tiền không hợp lệ");
						return "paymentResult";
					}
					
					bookingService.bookRoom(bookingRequest);
					// Clear the booking request from session after successful booking
					session.removeAttribute("bookingRequest");
					model.addAttribute("message", "Thanh toán thành công. Mã giao dịch: " + vnp_TxnRef);
				} catch (IllegalArgumentException e) {
					model.addAttribute("message", "Lỗi khi đặt phòng: " + e.getMessage());
				} catch (Exception e) {
					model.addAttribute("message", "Lỗi không xác định khi đặt phòng. Vui lòng liên hệ hỗ trợ.");
				}
			} else {
				model.addAttribute("message", "Không tìm thấy thông tin đặt phòng. Vui lòng thử lại.");
			}
		} else {
			model.addAttribute("message", "Thanh toán thất bại. Mã lỗi: " + vnp_ResponseCode);
		}

		return "paymentResult";
	}
}
