package com.hotelmanagement.services;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.dtos.StatisticsDTO;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private StatisticsService statisticsService;

    @Override
    public ByteArrayOutputStream generateExcelReport() {
        // Tạm thời trả về CSV format thay vì Excel
        try {
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            
            // Tạo CSV content
            StringBuilder csvContent = new StringBuilder();
            
            // Header cho tổng quan
            csvContent.append("=== TỔNG QUAN ===\n");
            csvContent.append("Chỉ số,Giá trị,Mô tả\n");
            
            StatisticsDTO stats = statisticsService.getDashboardStatistics();
            csvContent.append("Tổng số booking,").append(stats.getTotalBookings()).append(",Tổng số đặt phòng trong hệ thống\n");
            csvContent.append("Tổng doanh thu,").append(formatCurrency(stats.getTotalRevenue())).append(",Tổng doanh thu từ các booking đã xác nhận\n");
            csvContent.append("Tổng số phòng,").append(stats.getTotalRooms()).append(",Tổng số phòng trong khách sạn\n");
            csvContent.append("Tổng người dùng,").append(stats.getTotalUsers()).append(",Tổng số người dùng đăng ký\n");
            csvContent.append("Phòng trống,").append(stats.getAvailableRooms()).append(",Số phòng hiện đang trống\n");
            csvContent.append("Phòng đã đặt,").append(stats.getBookedRooms()).append(",Số phòng đã được đặt\n");
            csvContent.append("Phòng bảo trì,").append(stats.getMaintenanceRooms()).append(",Số phòng đang bảo trì\n");
            csvContent.append("Doanh thu tháng,").append(formatCurrency(stats.getMonthlyRevenue())).append(",Doanh thu tháng hiện tại\n");
            csvContent.append("Doanh thu tuần,").append(formatCurrency(stats.getWeeklyRevenue())).append(",Doanh thu tuần hiện tại\n\n");
            
            // Chi tiết booking
            csvContent.append("=== CHI TIẾT BOOKING ===\n");
            csvContent.append("Booking ID,Phòng,Khách hàng,Ngày check-in,Ngày check-out,Trạng thái,Tổng tiền,Ngày tạo\n");
            
            try (Connection conn = dataSource.getConnection()) {
                String sql = "SELECT rb.bookingID, r.roomNumber, u.fullName, rb.checkInDate, rb.checkOutDate, " +
                            "rb.bookingStatus, rb.totalAmount, rb.createdAt " +
                            "FROM roombookings rb " +
                            "JOIN rooms r ON rb.roomID = r.roomID " +
                            "JOIN users u ON rb.userID = u.userID " +
                            "ORDER BY rb.createdAt DESC";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    
                    while (rs.next()) {
                        csvContent.append(rs.getInt("bookingID")).append(",");
                        csvContent.append(rs.getString("roomNumber")).append(",");
                        csvContent.append(rs.getString("fullName")).append(",");
                        csvContent.append(rs.getDate("checkInDate")).append(",");
                        csvContent.append(rs.getDate("checkOutDate")).append(",");
                        csvContent.append(rs.getString("bookingStatus")).append(",");
                        csvContent.append(formatCurrency(rs.getBigDecimal("totalAmount"))).append(",");
                        csvContent.append(rs.getTimestamp("createdAt")).append("\n");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            csvContent.append("\n=== THỐNG KÊ PHÒNG ===\n");
            csvContent.append("Loại phòng,Số lượng,Tỷ lệ (%)\n");
            
            Map<String, Long> roomTypeStats = stats.getRoomTypeStats();
            long totalRooms = stats.getTotalRooms();
            
            for (Map.Entry<String, Long> entry : roomTypeStats.entrySet()) {
                csvContent.append(entry.getKey()).append(",");
                csvContent.append(entry.getValue()).append(",");
                double percentage = totalRooms > 0 ? (entry.getValue() * 100.0 / totalRooms) : 0;
                csvContent.append(String.format("%.2f", percentage)).append("\n");
            }
            
            csvContent.append("\n=== DOANH THU THEO THÁNG ===\n");
            csvContent.append("Tháng,Doanh thu (VNĐ),Số booking\n");
            
            try (Connection conn = dataSource.getConnection()) {
                String sql = "SELECT DATE_FORMAT(createdAt, '%Y-%m') as month, " +
                            "COALESCE(SUM(totalAmount), 0) as revenue, " +
                            "COUNT(*) as bookingCount " +
                            "FROM roombookings " +
                            "WHERE bookingStatus = 'CONFIRMED' " +
                            "AND createdAt >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH) " +
                            "GROUP BY DATE_FORMAT(createdAt, '%Y-%m') " +
                            "ORDER BY month";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    
                    while (rs.next()) {
                        csvContent.append(rs.getString("month")).append(",");
                        csvContent.append(formatCurrency(rs.getBigDecimal("revenue"))).append(",");
                        csvContent.append(rs.getLong("bookingCount")).append("\n");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            outputStream.write(csvContent.toString().getBytes("UTF-8"));
            return outputStream;
            
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tạo báo cáo: " + e.getMessage());
        }
    }

    @Override
    public ByteArrayOutputStream generatePDFReport() {
        // TODO: Implement PDF generation
        throw new UnsupportedOperationException("Chức năng xuất PDF chưa được triển khai");
    }

    private String formatCurrency(BigDecimal amount) {
        if (amount == null) return "0 VNĐ";
        return String.format("%,.0f VNĐ", amount.doubleValue());
    }
}