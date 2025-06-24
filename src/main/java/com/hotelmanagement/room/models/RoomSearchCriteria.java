package com.hotelmanagement.room.models;

import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.models.enums.RoomTypeName;

public class RoomSearchCriteria {
    private String roomNumber;
    private RoomTypeName roomTypeName;
    private Integer minPrice;
    private Integer maxPrice;
    private RoomStatus roomStatus;
    private Boolean available;

    // Getters & Setters
    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public RoomTypeName getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(RoomTypeName roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public Integer getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Integer minPrice) {
        this.minPrice = minPrice;
    }

    public Integer getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Integer maxPrice) {
        this.maxPrice = maxPrice;
    }

    public RoomStatus getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(RoomStatus roomStatus) {
        this.roomStatus = roomStatus;
    }

    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    // Constructor
    public RoomSearchCriteria() {
    }

    public RoomSearchCriteria(String roomNumber, RoomTypeName roomTypeName, Integer minPrice, 
                             Integer maxPrice, RoomStatus roomStatus, Boolean available) {
        this.roomNumber = roomNumber;
        this.roomTypeName = roomTypeName;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
        this.roomStatus = roomStatus;
        this.available = available;
    }

    @Override
    public String toString() {
        return "RoomSearchCriteria{" +
                "roomNumber='" + roomNumber + '\'' +
                ", roomTypeName=" + roomTypeName +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                ", roomStatus=" + roomStatus +
                ", available=" + available +
                '}';
    }
}

