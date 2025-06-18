package com.hotelmanagement.dtos;

import java.time.LocalDate;

public class BookingFilterRequest {
    private int userId;
    private String bookingStatus;
    private LocalDate fromDate;
    private LocalDate toDate;
    
    public BookingFilterRequest() {
    }
    
    public BookingFilterRequest(int userId, String bookingStatus, LocalDate fromDate, LocalDate toDate) {
        this.userId = userId;
        this.bookingStatus = bookingStatus;
        this.fromDate = fromDate;
        this.toDate = toDate;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getBookingStatus() {
        return bookingStatus;
    }
    
    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    public LocalDate getFromDate() {
        return fromDate;
    }
    
    public void setFromDate(LocalDate fromDate) {
        this.fromDate = fromDate;
    }
    
    public LocalDate getToDate() {
        return toDate;
    }
    
    public void setToDate(LocalDate toDate) {
        this.toDate = toDate;
    }
} 