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
import com.hotelmanagement.user.entities.User;
import com.hotelmanagement.user.entities.UserRole;
import com.hotelmanagement.user.services.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/booking-history")
public class BookingHistoryController {

    private static final Logger logger = LoggerFactory.getLogger(BookingHistoryController.class);

    @Autowired
    private BookingService bookingService;

    @Autowired
    private JWTService jwtService;
    
    @Autowired
    private UserService userService;

    @GetMapping
    public String getBookingHistory(
            Model model,
            HttpServletRequest request,
            HttpSession session,
            @RequestParam(name = "status", required = false) String status,
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate) {
        
        // Try to get user from session first
        User user = (User) session.getAttribute("currentUser");
        logger.info("User from session: {}", user);
        
        // If not in session, try authentication
        if (user == null) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            logger.info("Authentication object: {}", authentication);
            logger.info("Authentication name: {}", authentication != null ? authentication.getName() : "null");
            logger.info("Authentication is authenticated: {}", authentication != null ? authentication.isAuthenticated() : "null");
            
            if (authentication == null || !authentication.isAuthenticated()) {
                logger.warn("User not authenticated, redirecting to login");
                return "redirect:/HotelManagement/login";
            }

            String username = authentication.getName();
            logger.info("Username from authentication: {}", username);
            
            user = userService.findByUsername(username);
            logger.info("User found from authentication: {}", user);
            
            if (user == null) {
                logger.error("Could not find user: {}", username);
                return "redirect:/HotelManagement/login";
            }
            
            // Store user in session for future use
            session.setAttribute("currentUser", user);
        }

        model.addAttribute("currentUser", user);

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
