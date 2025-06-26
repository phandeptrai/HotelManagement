package com.hotelmanagement.dtos;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class StatisticsDTO {
	private long totalBookings;
	private long totalUsers;
	private long totalRooms;
	private long availableRooms;
	private long bookedRooms;
	private long maintenanceRooms;
	private BigDecimal totalRevenue;
	private BigDecimal monthlyRevenue;
	private BigDecimal weeklyRevenue;
	private Map<String, Long> bookingStatusStats;
	private Map<String, Long> roomTypeStats;
	private List<MonthlyRevenueDTO> monthlyRevenueData;
	private List<DailyBookingDTO> dailyBookingData;

	public static class MonthlyRevenueDTO extends MonthlyRevenueDataDTO {
		public MonthlyRevenueDTO() {
			super();
		}

		public MonthlyRevenueDTO(String month, BigDecimal revenue) {
			super(month, revenue);
		}
	}

	public static class DailyBookingDTO extends DailyBookingDataDTO {
		public DailyBookingDTO() {
			super();
		}

		public DailyBookingDTO(String date, long bookingCount) {
			super(date, bookingCount);
		}
	}

	// Constructors
	public StatisticsDTO() {
	}

	// Getters and Setters
	public long getTotalBookings() {
		return totalBookings;
	}

	public void setTotalBookings(long totalBookings) {
		this.totalBookings = totalBookings;
	}

	public long getTotalUsers() {
		return totalUsers;
	}

	public void setTotalUsers(long totalUsers) {
		this.totalUsers = totalUsers;
	}

	public long getTotalRooms() {
		return totalRooms;
	}

	public void setTotalRooms(long totalRooms) {
		this.totalRooms = totalRooms;
	}

	public long getAvailableRooms() {
		return availableRooms;
	}

	public void setAvailableRooms(long availableRooms) {
		this.availableRooms = availableRooms;
	}

	public long getBookedRooms() {
		return bookedRooms;
	}

	public void setBookedRooms(long bookedRooms) {
		this.bookedRooms = bookedRooms;
	}

	public long getMaintenanceRooms() {
		return maintenanceRooms;
	}

	public void setMaintenanceRooms(long maintenanceRooms) {
		this.maintenanceRooms = maintenanceRooms;
	}

	public BigDecimal getTotalRevenue() {
		return totalRevenue;
	}

	public void setTotalRevenue(BigDecimal totalRevenue) {
		this.totalRevenue = totalRevenue;
	}

	public BigDecimal getMonthlyRevenue() {
		return monthlyRevenue;
	}

	public void setMonthlyRevenue(BigDecimal monthlyRevenue) {
		this.monthlyRevenue = monthlyRevenue;
	}

	public BigDecimal getWeeklyRevenue() {
		return weeklyRevenue;
	}

	public void setWeeklyRevenue(BigDecimal weeklyRevenue) {
		this.weeklyRevenue = weeklyRevenue;
	}

	public Map<String, Long> getBookingStatusStats() {
		return bookingStatusStats;
	}

	public void setBookingStatusStats(Map<String, Long> bookingStatusStats) {
		this.bookingStatusStats = bookingStatusStats;
	}

	public Map<String, Long> getRoomTypeStats() {
		return roomTypeStats;
	}

	public void setRoomTypeStats(Map<String, Long> roomTypeStats) {
		this.roomTypeStats = roomTypeStats;
	}

	public List<MonthlyRevenueDTO> getMonthlyRevenueData() {
		return monthlyRevenueData;
	}

	public void setMonthlyRevenueData(List<MonthlyRevenueDTO> monthlyRevenueData) {
		this.monthlyRevenueData = monthlyRevenueData;
	}

	public List<DailyBookingDTO> getDailyBookingData() {
		return dailyBookingData;
	}

	public void setDailyBookingData(List<DailyBookingDTO> dailyBookingData) {
		this.dailyBookingData = dailyBookingData;
	}
}