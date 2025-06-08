package com.hotelmanagement.room.factory;

import com.hotelmanagement.room.models.DoubleRoom;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.SingleRoom;
import com.hotelmanagement.room.models.SuiteRoom;
import com.hotelmanagement.room.models.enums.RoomTypeName;

public class RoomFactory {
	public static Room createRoomByTypeName(RoomTypeName typeName) {
		return switch (typeName) {
			case SINGLE -> new SingleRoom();
			case DOUBLE -> new DoubleRoom();
			case SUITE -> new SuiteRoom();
			default -> throw new IllegalArgumentException("Không hỗ trợ loại phòng: " + typeName);
		};
	}
}
