package com.hotelmanagement.services;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelmanagement.dtos.StatisticsDTO;
import com.hotelmanagement.dtos.StatisticsDTO.DailyBookingDTO;
import com.hotelmanagement.dtos.StatisticsDTO.MonthlyRevenueDTO;
import com.hotelmanagement.room.models.enums.RoomStatus;
import com.hotelmanagement.room.services.RoomService;
import com.hotelmanagement.user.services.UserService;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private RoomService roomService;

    @Autowired
    private UserService userService;

    @Override
    public StatisticsDTO getDashboardStatistics() {
        StatisticsDTO stats = new StatisticsDTO();
        
        // Lấy thống kê cơ bản
        stats.setTotalRooms(roomService.getAllRoom().size());
        stats.setTotalUsers(userService.getAllUser().size());
        
        // Thống kê phòng theo trạng thái
        long availableRooms = roomService.getAllRoom().stream()
                .filter(room -> room.getRoomStatus() == RoomStatus.AVAILABLE)
                .count();
        long bookedRooms = roomService.getAllRoom().stream()
                .filter(room -> room.getRoomStatus() == RoomStatus.BOOKED)
                .count();
        long maintenanceRooms = roomService.getAllRoom().stream()
                .filter(room -> room.getRoomStatus() == RoomStatus.MAINTENANCE)
                .count();
        
        stats.setAvailableRooms(availableRooms);
        stats.setBookedRooms(bookedRooms);
        stats.setMaintenanceRooms(maintenanceRooms);
        
        // Lấy thống kê từ database
        try (Connection conn = dataSource.getConnection()) {
            // Tổng số booking
            stats.setTotalBookings(getTotalBookings(conn));
            
            // Tổng doanh thu
            stats.setTotalRevenue(getTotalRevenue(conn));
            
            // Doanh thu tháng hiện tại
            stats.setMonthlyRevenue(getMonthlyRevenue(conn));
            
            // Doanh thu tuần hiện tại
            stats.setWeeklyRevenue(getWeeklyRevenue(conn));
            
            // Thống kê theo trạng thái booking
            stats.setBookingStatusStats(getBookingStatusStats(conn));
            
            // Thống kê theo loại phòng
            stats.setRoomTypeStats(getRoomTypeStats(conn));
            
            // Dữ liệu biểu đồ doanh thu theo tháng (6 tháng gần nhất)
            stats.setMonthlyRevenueData(getMonthlyRevenueData(conn));
            
            // Dữ liệu biểu đồ booking theo ngày (7 ngày gần nhất)
            stats.setDailyBookingData(getDailyBookingData(conn));
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }

    @Override
    public StatisticsDTO getStatisticsByDateRange(String startDate, String endDate) {
        // Tương tự như getDashboardStatistics nhưng với filter theo date range
        return getDashboardStatistics(); // Tạm thời return như cũ, có thể mở rộng sau
    }

    private long getTotalBookings(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM roombookings";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getLong(1);
            }
        }
        return 0;
    }

    private BigDecimal getTotalRevenue(Connection conn) throws SQLException {
        String sql = "SELECT COALESCE(SUM(totalAmount), 0) FROM roombookings WHERE bookingStatus = 'CONFIRMED'";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        }
        return BigDecimal.ZERO;
    }

    private BigDecimal getMonthlyRevenue(Connection conn) throws SQLException {
        String sql = "SELECT COALESCE(SUM(totalAmount), 0) FROM roombookings " +
                    "WHERE bookingStatus = 'CONFIRMED' " +
                    "AND MONTH(createdAt) = MONTH(CURRENT_DATE()) " +
                    "AND YEAR(createdAt) = YEAR(CURRENT_DATE())";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        }
        return BigDecimal.ZERO;
    }

    private BigDecimal getWeeklyRevenue(Connection conn) throws SQLException {
        String sql = "SELECT COALESCE(SUM(totalAmount), 0) FROM roombookings " +
                    "WHERE bookingStatus = 'CONFIRMED' " +
                    "AND createdAt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        }
        return BigDecimal.ZERO;
    }

    private Map<String, Long> getBookingStatusStats(Connection conn) throws SQLException {
        Map<String, Long> stats = new HashMap<>();
        String sql = "SELECT bookingStatus, COUNT(*) FROM roombookings GROUP BY bookingStatus";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString(1), rs.getLong(2));
            }
        }
        return stats;
    }

    private Map<String, Long> getRoomTypeStats(Connection conn) throws SQLException {
        Map<String, Long> stats = new HashMap<>();
        String sql = "SELECT rt.typeName, COUNT(*) FROM rooms r " +
                    "JOIN roomtypes rt ON r.roomTypeID = rt.roomTypeID " +
                    "GROUP BY rt.typeName";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString(1), rs.getLong(2));
            }
        }
        return stats;
    }

    private List<MonthlyRevenueDTO> getMonthlyRevenueData(Connection conn) throws SQLException {
        List<MonthlyRevenueDTO> data = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(createdAt, '%Y-%m') as month, " +
                    "COALESCE(SUM(totalAmount), 0) as revenue " +
                    "FROM roombookings " +
                    "WHERE bookingStatus = 'CONFIRMED' " +
                    "AND createdAt >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH) " +
                    "GROUP BY DATE_FORMAT(createdAt, '%Y-%m') " +
                    "ORDER BY month";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                data.add(new MonthlyRevenueDTO(rs.getString(1), rs.getBigDecimal(2)));
            }
        }
        return data;
    }

    private List<DailyBookingDTO> getDailyBookingData(Connection conn) throws SQLException {
        List<DailyBookingDTO> data = new ArrayList<>();
        String sql = "SELECT DATE(createdAt) as date, COUNT(*) as bookingCount " +
                    "FROM roombookings " +
                    "WHERE createdAt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) " +
                    "GROUP BY DATE(createdAt) " +
                    "ORDER BY date";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                data.add(new DailyBookingDTO(rs.getString(1), rs.getLong(2)));
            }
        }
        return data;
    }
} 