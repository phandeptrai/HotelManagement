package com.hotelmanagement.dtos;

import com.hotelmanagement.room.models.enums.RoomStatus;

public class RoomFormDTO {
	private int roomID;
	private String roomNumber;
	private int roomTypeID;
	private double price;
	private RoomStatus roomStatus;


	public int getRoomID() {
	    return roomID;
	}

	public void setRoomID(int roomID) {
	    this.roomID = roomID;
	}

	public String getRoomNumber() {
		return roomNumber;
	}

	public int getRoomTypeID() {
		return roomTypeID;
	}

	public void setRoomTypeID(int roomTypeID) {
		this.roomTypeID = roomTypeID;
	}

	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public RoomStatus getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(RoomStatus roomStatus) {
		this.roomStatus = roomStatus;
	}
}
