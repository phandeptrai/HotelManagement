package com.hotelmanagement.dtos;

public class DailyBookingDataDTO {
    private String date;
    private long bookingCount;

    public DailyBookingDataDTO() {}

    public DailyBookingDataDTO(String date, long bookingCount) {
        this.date = date;
        this.bookingCount = bookingCount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public long getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(long bookingCount) {
        this.bookingCount = bookingCount;
    }
} 