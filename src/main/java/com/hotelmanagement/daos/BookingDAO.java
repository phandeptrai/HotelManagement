package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.hotelmanagement.dtos.BookingFilterRequest;
import com.hotelmanagement.dtos.BookingRequest;
import com.hotelmanagement.dtos.BookingResponse;
import com.hotelmanagement.dtos.CancelBookingRequest;
import com.hotelmanagement.services.IServiceBooking;

@Repository
public class BookingDAO {
	private final DataSource dataSource;
	private final IServiceBooking booking;
    public BookingDAO(DataSource dataSource,IServiceBooking booking) {
		this.dataSource = dataSource;
		this.booking = booking;
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
	public void cancelBooking(CancelBookingRequest cancelRequest) {
	    String sql = "UPDATE roombookings SET bookingStatus = ?, cancelReason = ?, cancelledAt = ? " +
	                 "WHERE bookingID = ? AND userID = ?";
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, "CANCELLED");
	        stmt.setString(2, cancelRequest.getCancelReason());
	        stmt.setTimestamp(3, java.sql.Timestamp.valueOf(cancelRequest.getCancelTime()));
	        stmt.setInt(4, cancelRequest.getBookingId());
	        stmt.setInt(5, cancelRequest.getUserId());
	        int affectedRows = stmt.executeUpdate();
	        if (affectedRows == 0) {
	            throw new RuntimeException("Không tìm thấy booking để hủy hoặc bạn không có quyền hủy.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Lỗi khi hủy đặt phòng: " + e.getMessage());
	    }
	}
	// Lấy danh sách lịch sử đặt phòng của 1 user
	public List<BookingResponse> getBookingHistoryByUserId(int userId) {
	    List<BookingResponse> result = new ArrayList<>();
	    String sql = "SELECT * FROM roombookings WHERE userID = ? ORDER BY createdAt DESC";
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, userId);
	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            BookingResponse booking = new BookingResponse();
	            booking.setBookingId(rs.getInt("bookingID"));
	            booking.setRoomId(rs.getInt("roomID"));
	            booking.setCheckInDate(rs.getDate("checkInDate").toLocalDate());
	            booking.setCheckOutDate(rs.getDate("checkOutDate").toLocalDate());
	            booking.setBookingStatus(rs.getString("bookingStatus"));
	            booking.setTotalAmount(rs.getBigDecimal("totalAmount"));
	            booking.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
	            booking.setCancelReason(rs.getString("cancelReason"));
	            booking.setCancelledAt(rs.getTimestamp("cancelledAt") != null ? rs.getTimestamp("cancelledAt").toLocalDateTime() : null);
	            // Nếu muốn lấy dịch vụ đi kèm, gọi ServiceBookingDAO ở đây
	            result.add(booking);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Lỗi khi lấy lịch sử đặt phòng: " + e.getMessage());
	    }
	    return result;
	}

	// Lấy chi tiết 1 booking theo bookingId và userId (đảm bảo chỉ chủ sở hữu mới xem được)
	public BookingResponse getBookingDetailById(int bookingId, int userId) {
	    String sql = "SELECT rb.*, r.roomNumber FROM roombookings rb " +
	                 "JOIN rooms r ON rb.roomID = r.roomID " +
	                 "WHERE rb.bookingID = ? AND rb.userID = ?";
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, bookingId);
	        stmt.setInt(2, userId);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            BookingResponse booking = new BookingResponse();
	            booking.setBookingId(rs.getInt("bookingID"));
	            booking.setRoomId(rs.getInt("roomID"));
	            booking.setRoomNumber(rs.getString("roomNumber"));
	            booking.setCheckInDate(rs.getDate("checkInDate").toLocalDate());
	            booking.setCheckOutDate(rs.getDate("checkOutDate").toLocalDate());
	            booking.setBookingStatus(rs.getString("bookingStatus"));
	            booking.setTotalAmount(rs.getBigDecimal("totalAmount"));
	            booking.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
	            booking.setCancelReason(rs.getString("cancelReason"));
	            booking.setCancelledAt(rs.getTimestamp("cancelledAt") != null ? rs.getTimestamp("cancelledAt").toLocalDateTime() : null);
	            booking.setServices(this.booking.getServiceByBookingId(bookingId));
	            return booking;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Lỗi khi lấy chi tiết đặt phòng: " + e.getMessage());
	    }
	    return null;
	}

	public List<BookingResponse> getFilteredBookingHistory(BookingFilterRequest filter) {
	    List<BookingResponse> result = new ArrayList<>();
	    StringBuilder sql = new StringBuilder(
	        "SELECT rb.*, r.roomNumber FROM roombookings rb " +
	        "JOIN rooms r ON rb.roomID = r.roomID " +
	        "WHERE rb.userID = ?");
	    List<Object> params = new ArrayList<>();
	    params.add(filter.getUserId());
	    
	    if (filter.getBookingStatus() != null && !filter.getBookingStatus().isEmpty()) {
	        sql.append(" AND rb.bookingStatus = ?");
	        params.add(filter.getBookingStatus());
	    }
	    
	    if (filter.getFromDate() != null) {
	        sql.append(" AND rb.checkInDate >= ?");
	        params.add(java.sql.Date.valueOf(filter.getFromDate()));
	    }
	    
	    if (filter.getToDate() != null) {
	        sql.append(" AND rb.checkOutDate <= ?");
	        params.add(java.sql.Date.valueOf(filter.getToDate()));
	    }
	    
	    sql.append(" ORDER BY rb.createdAt DESC");
	    
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
	        
	        for (int i = 0; i < params.size(); i++) {
	            stmt.setObject(i + 1, params.get(i));
	        }
	        
	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            BookingResponse booking = new BookingResponse();
	            booking.setBookingId(rs.getInt("bookingID"));
	            booking.setRoomId(rs.getInt("roomID"));
	            booking.setRoomNumber(rs.getString("roomNumber"));
	            booking.setCheckInDate(rs.getDate("checkInDate").toLocalDate());
	            booking.setCheckOutDate(rs.getDate("checkOutDate").toLocalDate());
	            booking.setBookingStatus(rs.getString("bookingStatus"));
	            booking.setTotalAmount(rs.getBigDecimal("totalAmount"));
	            booking.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
	            booking.setCancelReason(rs.getString("cancelReason"));
	            booking.setCancelledAt(rs.getTimestamp("cancelledAt") != null ? rs.getTimestamp("cancelledAt").toLocalDateTime() : null);
	            booking.setServices(this.booking.getServiceByBookingId(booking.getBookingId()));
	            result.add(booking);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Lỗi khi lấy lịch sử đặt phòng: " + e.getMessage());
	    }
	    return result;
	}
}