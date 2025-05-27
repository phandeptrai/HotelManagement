package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.ServiceBookingResponse;
import com.hotelmanagement.utils.DatabaseConnection;


@Repository
public class ServiceBookingDAO {
	public List<ServiceBookingResponse> getAllServices(){
		List<ServiceBookingResponse> serviceBookings = new ArrayList<ServiceBookingResponse>();
		
		String sql = "SELECT * FROM services";
		try(Connection conn = DatabaseConnection.getInstance().getConnection()){
			PreparedStatement stmt = conn.prepareStatement(sql);
			try(ResultSet rs = stmt.executeQuery()){
				while (rs.next()) {
					ServiceBookingResponse serviceBooking = new ServiceBookingResponse(
							rs.getInt(1),
							rs.getString(2),
							rs.getDouble(3));
					serviceBookings.add(serviceBooking);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return serviceBookings;
	}
}
