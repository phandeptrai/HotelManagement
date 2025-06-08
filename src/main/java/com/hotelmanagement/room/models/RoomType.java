package com.hotelmanagement.room.models;

import com.hotelmanagement.room.models.enums.RoomTypeName;

public class RoomType {
	private int roomTypeID;
	private RoomTypeName typeName;

	public int getRoomTypeID() {
		return roomTypeID;
	}

	public void setRoomTypeID(int roomTypeID) {
		this.roomTypeID = roomTypeID;
	}

	public RoomTypeName getTypeName() {
		return typeName;
	}

	public void setTypeName(RoomTypeName typeName) {
		this.typeName = typeName;
	}

    @Override
    public String toString() {
        return typeName.name();
    }
	
}
