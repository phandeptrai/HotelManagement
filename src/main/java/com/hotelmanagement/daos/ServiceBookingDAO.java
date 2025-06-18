package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.ServiceBookingResponse;



@Repository
public class ServiceBookingDAO {
	private final DataSource dataSource;
	
	@Autowired
	public ServiceBookingDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public List<ServiceBookingResponse> getAllServices(){
		List<ServiceBookingResponse> serviceBookings = new ArrayList<ServiceBookingResponse>();
		
		String sql = "SELECT * FROM services";
		try(Connection conn = dataSource.getConnection()){
			PreparedStatement stmt = conn.prepareStatement(sql);
			try(ResultSet rs = stmt.executeQuery()){
				while (rs.next()) {
					ServiceBookingResponse serviceBooking = new ServiceBookingResponse(
							rs.getInt(1),
							rs.getString(2),
							rs.getInt(3));
					serviceBookings.add(serviceBooking);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return serviceBookings;
	}
	public List<ServiceBookingResponse> getServiceByBookingId(int bookingID){
		List<ServiceBookingResponse> serviceBookings = new ArrayList<ServiceBookingResponse>();
		String sql = "SELECT services.serviceName,services.servicePrice,servicesbookings.quantity FROM servicebookings JOIN roombookings ON "
				+ "roombookings.bookingID = servicebookings.bookingID JOIN services ON "
				+ "servicebookings.serviceID = services.serviceID "
				+ "WHERE servicebookings.bookingID = ?";
		
		try(Connection conn = dataSource.getConnection()){
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, bookingID);
			try(ResultSet rs = stmt.executeQuery()){
				while (rs.next()) {
					ServiceBookingResponse serviceBooking = new ServiceBookingResponse(
							rs.getInt(1),
							rs.getString(2),
							rs.getInt(3));
					serviceBookings.add(serviceBooking);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return serviceBookings;
	}

}


