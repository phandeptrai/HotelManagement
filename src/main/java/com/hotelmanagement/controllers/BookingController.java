package com.hotelmanagement.controllers;

import com.hotelmanagement.command.BookingCommand;
import com.hotelmanagement.command.BookingCommandFactory;
import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.ServiceBookingResponse;
import com.hotelmanagement.payment.PaymentStrategy;
import com.hotelmanagement.services.IServiceBooking;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/booking")
public class BookingController {

	private final BookingCommandFactory commandFactory;
	private final ApplicationContext context;
	private final IServiceBooking services;

	private static final Map<Integer, String> paymentMethodMap = Map.of(1, "vnpay", 2, "cash");

	@Autowired
	public BookingController(BookingCommandFactory commandFactory, ApplicationContext context,
			IServiceBooking services) {
		this.commandFactory = commandFactory;
		this.context = context;
		this.services = services;
	}

	@GetMapping("/getform")
	public String getFormBooking(Model model) {
		model.addAttribute("request", new BookingRequest());
		model.addAttribute("availableServices", services.getAllServices());
		return "createBooking";
	}

	@PostMapping("/action")
	public String handleAction(@Valid @ModelAttribute BookingRequest request, BindingResult bindingResult,
			@RequestParam("action") String action, Model model, HttpSession session,
			HttpServletRequest servletRequest) {


		BookingCommand command = commandFactory.getCommand(action);
		if (bindingResult.hasErrors()) {

			List<ServiceBookingResponse> availableServices = services.getAllServices();
			model.addAttribute("availableServices", availableServices);
			model.addAttribute("request", request);
			return "createBooking";
		}else if (command != null) {
			command.execute(request);
			session.setAttribute("bookingRequest", request);
			session.setAttribute("amount", 100000); // mock amount

			String strategyName = paymentMethodMap.get(request.getPaymentMethodID());
			if (strategyName == null) {
				model.addAttribute("message", "Phương thức thanh toán không hợp lệ.");
				return "createBooking";
			}

			try {
				PaymentStrategy strategy = context.getBean(strategyName, PaymentStrategy.class);
				return strategy.pay(servletRequest, session, 100000);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "Lỗi khi xử lý thanh toán.");
				return "createBooking";
			}
		} else {
			model.addAttribute("message", "Hành động không hợp lệ: " + action);
			model.addAttribute("request", request);
			return "createBooking";
		}
	}

	@GetMapping("/success")
	public String bookingSuccess() {
		return "paymentResult";
	}
}
