package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.utils.DatabaseConnection;

@Repository
public class BookingDAO {
    public void bookRoom(BookingRequest bookingRequest) {
        try (Connection conn = DatabaseConnection.getInstance().getConnection()) {
            // 1. Insert booking
            String sql = "INSERT INTO roombookings(userID, roomID, checkInDate, checkOutDate) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, bookingRequest.getUserId());
            stmt.setInt(2, bookingRequest.getRoomId());
            stmt.setDate(3, java.sql.Date.valueOf(bookingRequest.getCheckInDate()));
            stmt.setDate(4, java.sql.Date.valueOf(bookingRequest.getCheckOutDate()));
            stmt.executeUpdate();

            // 2. Lấy bookingID tự tăng
            int bookingId = -1;
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                bookingId = generatedKeys.getInt(1);
            }

            // 3. Insert các dịch vụ đi kèm nếu có
            if (bookingRequest.getSelectedServices() != null) {
                String serviceSql = "INSERT INTO servicebookings(bookingID, serviceID, quantity) VALUES (?, ?, ?)";
                PreparedStatement serviceStmt = conn.prepareStatement(serviceSql);
                for (var service : bookingRequest.getSelectedServices()) {
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
        }
    }
}