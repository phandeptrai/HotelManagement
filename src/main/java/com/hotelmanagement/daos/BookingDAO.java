package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.BookingRequest;

@Repository
public class BookingDAO {
	private final DataSource dataSource;
	
    public BookingDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void bookRoom(BookingRequest bookingRequest) {
        try (Connection conn = dataSource.getConnection()) {
            // 1. Insert booking với tổng tiền
            String sql = "INSERT INTO roombookings(userID, roomID, checkInDate, checkOutDate, totalAmount) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, bookingRequest.getUserId());
            stmt.setInt(2, bookingRequest.getRoomId());
            stmt.setDate(3, java.sql.Date.valueOf(bookingRequest.getCheckInDate()));
            stmt.setDate(4, java.sql.Date.valueOf(bookingRequest.getCheckOutDate()));
            stmt.setInt(5, bookingRequest.getTotalPrice());
            stmt.executeUpdate();

            // 2. Lấy bookingID tự tăng
            int bookingId = -1;
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                bookingId = generatedKeys.getInt(1);
            }

            // 3. Insert các dịch vụ đi kèm nếu có
            if (bookingRequest.getSelectedServices() != null && !bookingRequest.getSelectedServices().isEmpty()) {
                String serviceSql = "INSERT INTO servicebookings(bookingID, serviceID, quantity) VALUES (?, ?, ?)";
                PreparedStatement serviceStmt = conn.prepareStatement(serviceSql);
                
                for (com.hotelmanagement.dtos.SelectedService service : bookingRequest.getSelectedServices()) {
                    if (service.isSelected()) {
                        serviceStmt.setInt(1, bookingId);
                        serviceStmt.setInt(2, service.getServiceId());
                        serviceStmt.setInt(3, service.getQuantity());
                        serviceStmt.addBatch();
                    }
                }
                serviceStmt.executeBatch();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error booking room: " + e.getMessage());
        }
    }
}