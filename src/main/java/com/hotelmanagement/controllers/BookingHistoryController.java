package com.hotelmanagement.controllers;

import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotelmanagement.dtos.BookingFilterRequest;
import com.hotelmanagement.dtos.BookingResponse;
import com.hotelmanagement.services.BookingService;
import com.hotelmanagement.services.JWTService;
import com.hotelmanagement.stub.User;
import com.hotelmanagement.stub.dao.UserDAO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/booking-history")
public class BookingHistoryController {
    @Autowired
    private UserDAO userDAO;

    private static final Logger logger = LoggerFactory.getLogger(BookingHistoryController.class);

    @Autowired
    private BookingService bookingService;

    @Autowired
    private JWTService jwtService;

    @GetMapping
    public String getBookingHistory(
            Model model,
            HttpServletRequest request,
            @RequestParam(name = "status", required = false) String status,
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate) {
        
        User user = userDAO.getStubUser();
        if (user == null) {
            logger.error("Could not get userId from token");
            return "redirect:/login";
        }

        BookingFilterRequest filter = new BookingFilterRequest();
        filter.setUserId(user.getUserID());
        filter.setBookingStatus(status);
        
        if (startDate != null && !startDate.isEmpty()) {
            filter.setFromDate(LocalDate.parse(startDate));
        }
        
        if (endDate != null && !endDate.isEmpty()) {
            filter.setToDate(LocalDate.parse(endDate));
        }

        logger.info("Filter request: {}", filter);
        List<BookingResponse> bookings = bookingService.getFilteredBookingHistory(filter);
        logger.info("Found {} bookings", bookings.size());

        model.addAttribute("bookings", bookings);
        model.addAttribute("today", LocalDate.now());
        return "booking-history";
    }

    @GetMapping("/{bookingId}")
    public String getBookingDetail(@PathVariable int bookingId, Model model, HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        logger.info("Authentication for booking detail: {}", authentication);
        
        if (authentication == null || !authentication.isAuthenticated()) {
            logger.warn("User not authenticated for booking detail, redirecting to login");
            return "redirect:/HotelManagement/login";
        }

        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwt_token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null) {
            logger.error("No JWT token found in cookies");
            return "redirect:/HotelManagement/login";
        }

        Integer userId = jwtService.getUserIdFromToken(token);
        logger.info("User ID from token for booking detail: {}", userId);

        if (userId == null) {
            logger.error("Could not get userId from token");
            return "redirect:/HotelManagement/login";
        }

        BookingResponse booking = bookingService.getBookingDetailById(bookingId, userId);
        if (booking == null) {
            logger.error("Booking not found or user not authorized");
            return "redirect:/HotelManagement/booking-history";
        }

        model.addAttribute("booking", booking);
        return "booking-detail";
    }
}
