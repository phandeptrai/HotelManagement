package com.hotelmanagement.room.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.RoomFormDTO;
import com.hotelmanagement.room.factory.RoomFactory;
import com.hotelmanagement.room.models.Room;
import com.hotelmanagement.room.models.RoomType;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.models.enums.RoomTypeName;

@Repository
public class RoomDAOImpl implements RoomDAO {
	
    private final DataSource dataSource;
    
    @Autowired
    public RoomDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }
	
	@Override
	public Room getRoomByID(int id) {
	    String sql = "SELECT r.*, rt.typeName FROM rooms r JOIN roomtypes rt ON r.roomTypeID = rt.roomTypeID WHERE r.roomID = ?";
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                RoomTypeName typeName = RoomTypeName.valueOf(rs.getString("typeName").toUpperCase());
	                Room room = RoomFactory.createRoomByTypeName(typeName);
	                room.setRoomID(rs.getInt("roomID"));
	                room.setRoomNumber(rs.getString("roomNumber"));
	                room.setRoomTypeID(rs.getInt("roomTypeID"));
	                room.setPrice(rs.getDouble("price"));
	                room.setRoomStatus(RoomStatus.valueOf(rs.getString("status")));

	                RoomType roomType = new RoomType();
	                roomType.setRoomTypeID(rs.getInt("roomTypeID"));
	                roomType.setTypeName(typeName);
	                room.setRoomType(roomType);

	                return room;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	@Override
	public void updateRoom(RoomFormDTO room) {
	    String sql = "UPDATE rooms SET roomNumber = ?, roomTypeID = ?, status = ?, price = ? WHERE roomID = ?";
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, room.getRoomNumber());
	        ps.setInt(2, room.getRoomTypeID());
	        ps.setString(3, room.getRoomStatus().name());
	        ps.setDouble(4, room.getPrice());
	        ps.setInt(5, room.getRoomID());
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	@Override
	public List<Room>getAllRoom(){
		 List<Room> rooms = new ArrayList<>();

		    String sql = "SELECT r.roomID, r.roomNumber, r.roomTypeID, r.status, r.price, rt.typeName "
		               + "FROM rooms r "
		               + "JOIN roomtypes rt ON r.roomTypeID = rt.roomTypeID";

		    try (Connection conn = dataSource.getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql);
		         ResultSet rs = ps.executeQuery()) {

		        while (rs.next()) {
		            RoomTypeName typeName = RoomTypeName.valueOf(rs.getString("typeName").toUpperCase());

		            Room room = RoomFactory.createRoomByTypeName(typeName);
		            room.setRoomID(rs.getInt("roomID"));
		            room.setRoomNumber(rs.getString("roomNumber"));
		            room.setRoomTypeID(rs.getInt("roomTypeID"));
		            room.setRoomStatus(RoomStatus.valueOf(rs.getString("status")));
		            room.setPrice(rs.getDouble("price"));

		            RoomType roomType = new RoomType();
		            roomType.setRoomTypeID(rs.getInt("roomTypeID"));
		            roomType.setTypeName(typeName);
		            room.setRoomType(roomType);

		            rooms.add(room);
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return rooms;
	}

	public List<Room> getAvailableRooms() {
		List<Room> rooms = new ArrayList<>();

		String sql = "SELECT r.roomID, r.roomNumber, r.roomTypeID, r.status, r.price, rt.typeName " + "FROM rooms r "
				+ "JOIN roomtypes rt ON r.roomTypeID = rt.roomTypeID " + "WHERE r.status = 'AVAILABLE'";

		try (Connection conn = dataSource.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				RoomTypeName typeName = RoomTypeName.valueOf(rs.getString("typeName").toUpperCase());

				Room room = RoomFactory.createRoomByTypeName(typeName);

				room.setRoomID(rs.getInt("roomID"));
				room.setRoomNumber(rs.getString("roomNumber"));
				room.setRoomTypeID(rs.getInt("roomTypeID"));
				room.setRoomStatus(RoomStatus.valueOf(rs.getString("status")));
				room.setPrice(rs.getDouble("price"));

				RoomType roomType = new RoomType();

				roomType.setRoomTypeID(rs.getInt("roomTypeID"));
				roomType.setTypeName(RoomTypeName.valueOf(rs.getString("typeName").toUpperCase()));
				room.setRoomType(roomType);

				rooms.add(room);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rooms;
	}
	
    @Override
    public void insertRoom(RoomFormDTO room) {
        String sql = "INSERT INTO rooms (roomNumber, roomTypeID, status, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

        	ps.setString(1, room.getRoomNumber());
        	ps.setInt(2, room.getRoomTypeID());
        	ps.setString(3, room.getRoomStatus().name());
        	ps.setDouble(4, room.getPrice());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public List<RoomType> getAllRoomTypes() {
        List<RoomType> roomTypes = new ArrayList<>();
        String sql = "SELECT * FROM roomtypes";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType roomType = new RoomType();
                roomType.setRoomTypeID(rs.getInt("roomTypeID"));
                roomType.setTypeName(RoomTypeName.valueOf(rs.getString("typeName").toUpperCase()));
                roomTypes.add(roomType);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roomTypes;
    }
    
    @Override
    public void updateRoomStatus(int roomID, RoomStatus status) {
        String sql = "UPDATE rooms SET status = ? WHERE roomID = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status.name()); // "MAINTENANCE"
            ps.setInt(2, roomID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}