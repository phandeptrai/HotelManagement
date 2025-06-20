package com.hotelmanagement.dtos;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class BookingRequest {

    @NotNull(message = "User ID không được để trống")
    @Min(value = 1, message = "User ID không hợp lệ")
    private int userId;

    @NotNull(message = "Room ID không được để trống")
    @Min(value = 1, message = "Room ID không hợp lệ")
    private int roomId;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "Ngày nhận phòng không được để trống")
    @FutureOrPresent(message = "Ngày nhận phòng phải là ngày hiện tại hoặc tương lai")
    private LocalDate checkInDate;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "Ngày trả phòng không được để trống")
    @FutureOrPresent(message = "Ngày trả phòng phải là ngày hiện tại hoặc tương lai")
    private LocalDate checkOutDate;

    @NotNull(message = "Vui lòng chọn phương thức thanh toán")
    @Min(value = 1, message = "Phương thức thanh toán không hợp lệ")
    private int paymentMethodID;

    @NotNull(message = "Giá phòng không được để trống")
    @Min(value = 0, message = "Giá phòng không hợp lệ")
    private int roomPrice;
    
    private int totalPrice;
    
    private List<SelectedService> selectedServices = new ArrayList<>();
	
    private String bookingStatus;
	
	
	public BookingRequest() {
		super();
	}
	public BookingRequest(int userId, int roomId, LocalDate checkInDate, LocalDate checkOutDate, int paymentMethodID) {
		super();
		this.userId = userId;
		this.roomId = roomId;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.paymentMethodID = paymentMethodID;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public LocalDate getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(LocalDate checkInDate) {
		this.checkInDate = checkInDate;
	}
	public LocalDate getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(LocalDate checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public int getPaymentMethodID() {
		return paymentMethodID;
	}
	public void setPaymentMethodID(int paymentMethodID) {
		this.paymentMethodID = paymentMethodID;
	}
	public List<SelectedService> getSelectedServices() {
	    return selectedServices;
	}

	public void setSelectedServices(List<SelectedService> selectedServices) {
	    this.selectedServices = selectedServices;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getBookingStatus() {
		return bookingStatus;
	}
	public void setBookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}



	
	
}
