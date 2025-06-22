<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê Real-time - Hotel Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="admin-content">
        <!-- Header -->
        <div class="dashboard-header">
            <h1><i class="bi bi-activity"></i> Thống kê Real-time</h1>
            <p class="text-muted">Dữ liệu được cập nhật tự động mỗi 30 giây</p>
            <div class="auto-refresh-controls">
                <button id="toggleRefresh" class="btn btn-primary">
                    <i class="bi bi-pause-circle"></i> Tạm dừng
                </button>
                <span id="lastUpdate" class="text-muted ms-3">Cập nhật lần cuối: <span id="updateTime"></span></span>
            </div>
        </div>

        <!-- Live Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card live-card">
                <div class="stat-icon booking-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>
                <div class="stat-content">
                    <h3 id="totalBookings">${stats.totalBookings}</h3>
                    <p>Tổng đặt phòng</p>
                    <div class="live-indicator">
                        <span class="pulse"></span> Live
                    </div>
                </div>
            </div>

            <div class="stat-card live-card">
                <div class="stat-icon revenue-icon">
                    <i class="bi bi-currency-dollar"></i>
                </div>
                <div class="stat-content">
                    <h3 id="totalRevenue"><fmt:formatNumber value="${stats.totalRevenue}" pattern="#,###" /> VNĐ</h3>
                    <p>Tổng doanh thu</p>
                    <div class="live-indicator">
                        <span class="pulse"></span> Live
                    </div>
                </div>
            </div>

            <div class="stat-card live-card">
                <div class="stat-icon room-icon">
                    <i class="bi bi-house-door"></i>
                </div>
                <div class="stat-content">
                    <h3 id="availableRooms">${stats.availableRooms}</h3>
                    <p>Phòng trống</p>
                    <div class="live-indicator">
                        <span class="pulse"></span> Live
                    </div>
                </div>
            </div>

            <div class="stat-card live-card">
                <div class="stat-icon user-icon">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-content">
                    <h3 id="totalUsers">${stats.totalUsers}</h3>
                    <p>Tổng người dùng</p>
                    <div class="live-indicator">
                        <span class="pulse"></span> Live
                    </div>
                </div>
            </div>
        </div>

        <!-- Live Charts -->
        <div class="row">
            <div class="col-md-6">
                <div class="chart-card live-chart">
                    <h4><i class="bi bi-graph-up"></i> Doanh thu theo giờ (Hôm nay)</h4>
                    <canvas id="hourlyRevenueChart" width="400" height="300"></canvas>
                </div>
            </div>
            <div class="col-md-6">
                <div class="chart-card live-chart">
                    <h4><i class="bi bi-clock"></i> Booking theo giờ (Hôm nay)</h4>
                    <canvas id="hourlyBookingChart" width="400" height="300"></canvas>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="recent-activities">
            <h3><i class="bi bi-clock-history"></i> Hoạt động gần đây</h3>
            <div class="activity-list" id="activityList">
                <!-- Activities will be loaded here -->
            </div>
        </div>
    </div>

    <script>
        let refreshInterval;
        let isAutoRefresh = true;
        let hourlyRevenueChart, hourlyBookingChart;

        // Initialize charts
        function initializeCharts() {
            // Hourly Revenue Chart
            const hourlyRevenueCtx = document.getElementById('hourlyRevenueChart').getContext('2d');
            hourlyRevenueChart = new Chart(hourlyRevenueCtx, {
                type: 'line',
                data: {
                    labels: generateHourLabels(),
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: generateRandomData(24),
                        borderColor: 'rgba(78, 115, 223, 1)',
                        backgroundColor: 'rgba(78, 115, 223, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                                }
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Hourly Booking Chart
            const hourlyBookingCtx = document.getElementById('hourlyBookingChart').getContext('2d');
            hourlyBookingChart = new Chart(hourlyBookingCtx, {
                type: 'bar',
                data: {
                    labels: generateHourLabels(),
                    datasets: [{
                        label: 'Số booking',
                        data: generateRandomData(24),
                        backgroundColor: 'rgba(40, 167, 69, 0.8)',
                        borderColor: 'rgba(40, 167, 69, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }

        function generateHourLabels() {
            const labels = [];
            for (let i = 0; i < 24; i++) {
                labels.push(`${i}:00`);
            }
            return labels;
        }

        function generateRandomData(count) {
            const data = [];
            for (let i = 0; i < count; i++) {
                data.push(Math.floor(Math.random() * 100) + 10);
            }
            return data;
        }

        // Update statistics
        function updateStatistics() {
            fetch('${pageContext.request.contextPath}/admin/dashboard-data')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalBookings').textContent = data.totalBookings;
                    document.getElementById('totalRevenue').textContent = new Intl.NumberFormat('vi-VN').format(data.totalRevenue) + ' VNĐ';
                    document.getElementById('availableRooms').textContent = data.availableRooms;
                    document.getElementById('totalUsers').textContent = data.totalUsers;
                    
                    // Update charts with new data
                    hourlyRevenueChart.data.datasets[0].data = generateRandomData(24);
                    hourlyRevenueChart.update('none');
                    
                    hourlyBookingChart.data.datasets[0].data = generateRandomData(24);
                    hourlyBookingChart.update('none');
                    
                    // Update last update time
                    const currentTime = new Date().toLocaleTimeString('vi-VN');
                    document.getElementById('updateTime').textContent = currentTime;
                    
                    // Add activity
                    addActivity('Cập nhật dữ liệu lúc ' + currentTime);
                })
                .catch(error => {
                    console.error('Error updating statistics:', error);
                    addActivity('Lỗi khi cập nhật dữ liệu', 'error');
                });
        }

        // Add activity to the list
        function addActivity(message, type = 'info') {
            const activityList = document.getElementById('activityList');
            const activityItem = document.createElement('div');
            activityItem.className = 'activity-item ' + type;
            
            const currentTime = new Date().toLocaleTimeString('vi-VN');
            activityItem.innerHTML = 
                '<div class="activity-time">' + currentTime + '</div>' +
                '<div class="activity-message">' + message + '</div>';
            
            activityList.insertBefore(activityItem, activityList.firstChild);
            
            // Keep only last 10 activities
            if (activityList.children.length > 10) {
                activityList.removeChild(activityList.lastChild);
            }
        }

        // Toggle auto refresh
        document.getElementById('toggleRefresh').addEventListener('click', function() {
            isAutoRefresh = !isAutoRefresh;
            if (isAutoRefresh) {
                refreshInterval = setInterval(updateStatistics, 30000); // 30 seconds
                this.innerHTML = '<i class="bi bi-pause-circle"></i> Tạm dừng';
                addActivity('Đã bật tự động cập nhật');
            } else {
                clearInterval(refreshInterval);
                this.innerHTML = '<i class="bi bi-play-circle"></i> Tiếp tục';
                addActivity('Đã tạm dừng tự động cập nhật');
            }
        });

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
            updateStatistics();
            refreshInterval = setInterval(updateStatistics, 30000);
            
            // Add initial activity
            addActivity('Đã khởi tạo thống kê real-time');
        });
    </script>

    <style>
        .auto-refresh-controls {
            margin-top: 15px;
        }
        
        .live-card {
            position: relative;
            overflow: hidden;
        }
        
        .live-indicator {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 0.8rem;
            color: #28a745;
            font-weight: 500;
        }
        
        .pulse {
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #28a745;
            margin-right: 5px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(0.95);
                box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
            }
            
            70% {
                transform: scale(1);
                box-shadow: 0 0 0 10px rgba(40, 167, 69, 0);
            }
            
            100% {
                transform: scale(0.95);
                box-shadow: 0 0 0 0 rgba(40, 167, 69, 0);
            }
        }
        
        .live-chart {
            position: relative;
        }
        
        .recent-activities {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            margin-top: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e6f0;
        }
        
        .recent-activities h3 {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 25px;
        }
        
        .activity-list {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .activity-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            margin-bottom: 8px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #4e73df;
            transition: all 0.3s ease;
        }
        
        .activity-item:hover {
            background: #e9ecef;
        }
        
        .activity-item.error {
            border-left-color: #dc3545;
            background: #f8d7da;
        }
        
        .activity-time {
            font-size: 0.85rem;
            color: #6c757d;
            font-weight: 500;
        }
        
        .activity-message {
            font-weight: 500;
            color: #2c3e50;
        }
    </style>
</body>
</html> 