package com.hotelmanagement.services;

import com.hotelmanagement.dtos.StatisticsDTO;

public interface StatisticsService {
    StatisticsDTO getDashboardStatistics();
    StatisticsDTO getStatisticsByDateRange(String startDate, String endDate);
} 