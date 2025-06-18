package com.hotelmanagement.dtos;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotNull;

public class CancelBookingRequest {

	    @NotNull(message = "Booking ID không được để trống")
	    private int bookingId;
	    
	    @NotNull(message = "User ID không được để trống")
	    private int userId;
	    
	    @NotNull(message = "Không được để trống lý do")
	    private String cancelReason;
	    
	    @NotNull(message = "Thời gian hủy không được để trống")
	    private LocalDateTime cancelTime;

		public int getBookingId() {
			return bookingId;
		}

		public void setBookingId(int bookingId) {
			this.bookingId = bookingId;
		}

		public int getUserId() {
			return userId;
		}

		public void setUserId(int userId) {
			this.userId = userId;
		}

		public String getCancelReason() {
			return cancelReason;
		}

		public void setCancelReason(String cancelReason) {
			this.cancelReason = cancelReason;
		}

		public LocalDateTime getCancelTime() {
			return cancelTime;
		}

		public void setCancelTime(LocalDateTime cancelTime) {
			this.cancelTime = cancelTime;
		}
	    

}
