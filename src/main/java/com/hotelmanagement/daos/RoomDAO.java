package com.hotelmanagement.daos;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.room.models.Room;

@Repository
public class RoomDAO {
    private final DataSource dataSource;
    
    @Autowired
    public RoomDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public List<Room> getAllRooms(){
    	String sql ="SELECT * FROM rooms";
    	List<Room> rooms = new ArrayList<Room>();
    	 try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return rooms;
    }
}
