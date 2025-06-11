package com.hotelmanagement.room.models;

import com.hotelmanagement.room.models.enums.RoomStatus;

public abstract class Room {
	protected int roomID;
	protected String roomNumber;
	protected int RoomTypeID;
	protected RoomStatus roomStatus = RoomStatus.AVAILABLE;
	protected double price;
	protected RoomType roomType;

	public int getRoomID() {
		return roomID;
	}

	public RoomType getRoomType() {
		return roomType;
	}

	public void setRoomType(RoomType roomType) {
		this.roomType = roomType;
	}

	public void setRoomID(int roomID) {
		this.roomID = roomID;
	}

	public String getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

	public int getRoomTypeID() {
		return RoomTypeID;
	}

	public void setRoomTypeID(int roomTypeID) {
		RoomTypeID = roomTypeID;
	}

	public RoomStatus getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(RoomStatus roomStatus) {
		this.roomStatus = roomStatus;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

}
