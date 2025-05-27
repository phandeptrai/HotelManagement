package com.hotelmanagement.dtos;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class BookingRequest {

    private int userId;

    private int roomId;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "Ngày nhận phòng không được để trống")
    private LocalDate checkInDate;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @FutureOrPresent(message = "Ngày nhận phòng phải là ngày hiện tại hoặc tương lai")
    @NotNull(message = "Ngày trả phòng không được để trống")
    private LocalDate checkOutDate;

    @Min(value = 1, message = "Vui lòng chọn phương thức thanh toán")
    private int paymentMethodID;

    private int amount;
    
    private List<SelectedService> selectedServices = new ArrayList<>();
	
	
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
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}

	
	
}
