package com.hotelmanagement.controllers;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.BookingResponse;
import com.hotelmanagement.dtos.CancelBookingRequest;
import com.hotelmanagement.dtos.PaymentRequest;
import com.hotelmanagement.dtos.SelectedService;
import com.hotelmanagement.dtos.ServiceBookingResponse;
import com.hotelmanagement.payment.PaymentStrategy;
import com.hotelmanagement.room.services.RoomService;
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
import com.hotelmanagement.user.entities.User;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import com.hotelmanagement.user.entities.UserRole;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/booking")
public class BookingController {

	private final ApplicationContext context;
	private final IServiceBooking services;
	private final BookingService bookingService;
	private final PaymentMethodService paymentMethodService;
	private final RoomService roomService;

	@Autowired
	public BookingController(ApplicationContext context, IServiceBooking services, 
			BookingService bookingService, PaymentMethodService paymentMethodService,
			RoomService roomService) {
		this.context = context;
		this.services = services;
		this.bookingService = bookingService;
		this.paymentMethodService = paymentMethodService;
		this.roomService = roomService;
	}

	@GetMapping("/getform")
	public String getFormBooking(HttpServletRequest request, HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		
		// Lấy parameters từ request
		String roomIdStr = request.getParameter("roomId");
		String roomPriceStr = request.getParameter("roomPrice");
		
		Integer roomId = null;
		Integer roomPrice = null;
		
		if (roomIdStr != null && !roomIdStr.trim().isEmpty()) {
			try {
				roomId = Integer.parseInt(roomIdStr);
			} catch (NumberFormatException e) {
				System.err.println("Room ID không hợp lệ: " + roomIdStr);
			}
		}
		
		if (roomPriceStr != null && !roomPriceStr.trim().isEmpty()) {
			try {
				roomPrice = Integer.parseInt(roomPriceStr);
			} catch (NumberFormatException e) {
				System.err.println("Room Price không hợp lệ: " + roomPriceStr);
			}
		}
		
		BookingRequest bookingRequest = new BookingRequest();
		
		// Map thông tin phòng từ URL parameters
		if (roomId != null) {
			bookingRequest.setRoomId(roomId);
			
			// Lấy thông tin phòng từ database
			try {
				var room = roomService.getRoomByID(roomId);
				if (room != null) {
					model.addAttribute("selectedRoom", room);
					// Cập nhật giá phòng từ database nếu có
					if (roomPrice == null) {
						roomPrice = (int) room.getPrice();
					}
				}
			} catch (Exception e) {
				System.err.println("Không thể lấy thông tin phòng: " + e.getMessage());
			}
		}
		
		if (roomPrice != null) {
			bookingRequest.setRoomPrice(roomPrice);
		} else {
			// Default price nếu không có
			bookingRequest.setRoomPrice(20000);
		}
		
		bookingRequest.setUserId(user.getUserID());
		
		model.addAttribute("user", user);
		model.addAttribute("request", bookingRequest);
		model.addAttribute("availableServices", services.getAllServices());
		model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethods());
		
		System.err.println("User trong session: " + user);
		System.err.println("Room ID: " + roomId + ", Room Price: " + roomPrice);
		
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
	public String bookingSuccess(Model model, HttpSession session) {
		BookingRequest bookingRequest = (BookingRequest) session.getAttribute("bookingRequest");
		if (bookingRequest != null && "PENDING".equals(bookingRequest.getBookingStatus())) {
			model.addAttribute("pending", true);
			model.addAttribute("message", "Đặt phòng của bạn đang chờ xác nhận từ quản trị viên.");
			session.removeAttribute("bookingRequest");
		} else {
			model.addAttribute("success", true);
			model.addAttribute("message", "Thanh toán thành công. Đặt phòng đã được xác nhận.");
			session.removeAttribute("bookingRequest");
		}
		return "paymentResult";
	}
	
    @GetMapping("/history")
    public String viewBookingHistory(HttpSession session, Model model) {
    	 User user = (User) session.getAttribute("currentUser");
        List<BookingResponse> bookings = bookingService.getBookingHistoryByUserId(user.getUserID());
        model.addAttribute("bookings", bookings);
        model.addAttribute("userId", user.getUserID());
        return "booking-history";
    }

    // Hủy phòng
    @PostMapping("/cancel")
    public String cancelBooking(@ModelAttribute CancelBookingRequest cancelRequest, 
                               RedirectAttributes redirectAttributes) {
        try {
            bookingService.cancelBookRoom(cancelRequest);
            redirectAttributes.addFlashAttribute("message", "Hủy đặt phòng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/booking-history";
    }

	@PostMapping("/confirm")
	public String confirmBooking(@RequestParam("bookingId") int bookingId, Model model, HttpSession session) {
		// Kiểm tra quyền admin
		User currentUser = (User) session.getAttribute("currentUser");
		if (currentUser == null || currentUser.getRole() != UserRole.ROLE_ADMIN) {
			model.addAttribute("error", "Bạn không có quyền thực hiện thao tác này!");
			return "redirect:/booking-history";
		}
		
		try {
			bookingService.confirmBooking(bookingId);
			model.addAttribute("message", "Duyệt đặt phòng thành công!");
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
		}
		return "redirect:/booking-history";
	}

	private int calculateTotalPrice(BookingRequest request) {

		long numberOfDays = ChronoUnit.DAYS.between(request.getCheckInDate(), request.getCheckOutDate());
		

		int totalRoomPrice = request.getRoomPrice() * (int)numberOfDays;
		

		int totalServicePrice = 0;
		if (request.getSelectedServices() != null) {
			for (SelectedService s : request.getSelectedServices()) {
				if (s.isSelected()) {
					int servicePrice = services.getPriceById(s.getServiceId());
					totalServicePrice += servicePrice * s.getQuantity();
				}
			}
		}
		

		return totalRoomPrice + totalServicePrice;
	}
	
	@GetMapping("/admin-management")
	public String adminBookingManagement(Model model) {
		List<BookingResponse> bookings = bookingService.getAllBookings();
		model.addAttribute("bookings", bookings);
		return "admin/admin-booking-management";
	}
}
