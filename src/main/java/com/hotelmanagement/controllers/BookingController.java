package com.hotelmanagement.controllers;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.PaymentRequest;
import com.hotelmanagement.dtos.SelectedService;
import com.hotelmanagement.dtos.ServiceBookingResponse;
import com.hotelmanagement.payment.PaymentStrategy;
import com.hotelmanagement.services.BookingService;
import com.hotelmanagement.services.IServiceBooking;
import com.hotelmanagement.services.PaymentMethodService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Controller
@RequestMapping("/booking")
public class BookingController {

	private final ApplicationContext context;
	private final IServiceBooking services;
	private final BookingService bookingService;
	private final PaymentMethodService paymentMethodService;

	@Autowired
	public BookingController(ApplicationContext context, IServiceBooking services, 
			BookingService bookingService, PaymentMethodService paymentMethodService) {
		this.context = context;
		this.services = services;
		this.bookingService = bookingService;
		this.paymentMethodService = paymentMethodService;
	}

	@GetMapping("/getform")
	public String getFormBooking(Model model) {
		BookingRequest bookingRequest = new BookingRequest();
		bookingRequest.setRoomPrice(20000);
		model.addAttribute("request", bookingRequest);
		model.addAttribute("availableServices", services.getAllServices());
		model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethods());
		return "createBooking";
	}

	@PostMapping("/bookroom")
	public String handleAction(@Valid @ModelAttribute("request") BookingRequest request, 
			BindingResult bindingResult, Model model, HttpServletRequest servletRequest, HttpSession session) {

		// Validate ngày check-in và check-out
		if (request.getCheckInDate() != null && request.getCheckOutDate() != null) {
			if (request.getCheckInDate().isAfter(request.getCheckOutDate())) {
				bindingResult.addError(new FieldError("request", "checkOutDate", 
					"Ngày trả phòng phải sau ngày nhận phòng"));
			}
		}

		if (bindingResult.hasErrors()) {
			model.addAttribute("availableServices", services.getAllServices());
			model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethods());
			return "createBooking";
		}

		// Tính tổng tiền
		int totalPrice = calculateTotalPrice(request);
		request.setTotalPrice(totalPrice);

		// Lấy chiến lược thanh toán
		String strategyName = paymentMethodService.getMethodNameById(request.getPaymentMethodID());
		if (strategyName == null) {
			model.addAttribute("message", "Phương thức thanh toán không hợp lệ.");
			model.addAttribute("availableServices", services.getAllServices());
			model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethods());
			return "createBooking";
		}

		try {
			// Store booking request in session
			session.setAttribute("bookingRequest", request);
			
			// Sử dụng tổng tiền đã tính để tạo payment request
			PaymentRequest paymentRequest = new PaymentRequest(request, totalPrice, strategyName);
			PaymentStrategy strategy = context.getBean(strategyName, PaymentStrategy.class);
			return strategy.pay(servletRequest, paymentRequest);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "Lỗi khi xử lý thanh toán.");
			model.addAttribute("availableServices", services.getAllServices());
			model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethods());
			return "createBooking";
		}
	}

	@GetMapping("/success")
	public String bookingSuccess() {
		return "paymentResult";
	}

	//  Tách logic tính tổng giá
	private int calculateTotalPrice(BookingRequest request) {
		// Tính số ngày đặt phòng
		long numberOfDays = ChronoUnit.DAYS.between(request.getCheckInDate(), request.getCheckOutDate());
		
		// Tính tổng tiền phòng cho toàn bộ số ngày
		int totalRoomPrice = request.getRoomPrice() * (int)numberOfDays;
		
		// Tính tổng tiền dịch vụ
		int totalServicePrice = 0;
		if (request.getSelectedServices() != null) {
			for (SelectedService s : request.getSelectedServices()) {
				if (s.isSelected()) {
					int servicePrice = services.getPriceById(s.getServiceId());
					totalServicePrice += servicePrice * s.getQuantity();
				}
			}
		}
		
		// Tổng tiền = tiền phòng + tiền dịch vụ
		return totalRoomPrice + totalServicePrice;
	}
}
