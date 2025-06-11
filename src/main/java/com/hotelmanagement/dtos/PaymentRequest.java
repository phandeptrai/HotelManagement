package com.hotelmanagement.dtos;

public class PaymentRequest {
    private BookingRequest bookingRequest;
    private int amount;
    private String paymentMethod;
    
    public PaymentRequest() {
    }
    
    public PaymentRequest(BookingRequest bookingRequest, int amount, String paymentMethod) {
        this.bookingRequest = bookingRequest;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
    }
    
    public BookingRequest getBookingRequest() {
        return bookingRequest;
    }
    
    public void setBookingRequest(BookingRequest bookingRequest) {
        this.bookingRequest = bookingRequest;
    }
    
    public int getAmount() {
        return amount;
    }
    
    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
} 