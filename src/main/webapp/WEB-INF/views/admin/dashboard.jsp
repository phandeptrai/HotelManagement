<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Hotel Management</title>
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
            <h1><i class="bi bi-graph-up"></i> Admin Dashboard</h1>
            <p class="text-muted">Tổng quan hệ thống quản lý khách sạn</p>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon booking-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.totalBookings}</h3>
                    <p>Tổng đặt phòng</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon revenue-icon">
                    <i class="bi bi-currency-dollar"></i>
                </div>
                <div class="stat-content">
                    <h3><fmt:formatNumber value="${stats.totalRevenue}" pattern="#,###" /> VNĐ</h3>
                    <p>Tổng doanh thu</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon room-icon">
                    <i class="bi bi-house-door"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.totalRooms}</h3>
                    <p>Tổng số phòng</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon user-icon">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-content">
                    <h3>${stats.totalUsers}</h3>
                    <p>Tổng người dùng</p>
                </div>
            </div>
        </div>

        <!-- Room Status Overview -->
        <div class="room-status-section">
            <h3><i class="bi bi-house-gear"></i> Trạng thái phòng</h3>
            <div class="room-status-grid">
                <div class="status-item available">
                    <div class="status-number">${stats.availableRooms}</div>
                    <div class="status-label">Phòng trống</div>
                </div>
                <div class="status-item booked">
                    <div class="status-number">${stats.bookedRooms}</div>
                    <div class="status-label">Phòng đã đặt</div>
                </div>
                <div class="status-item maintenance">
                    <div class="status-number">${stats.maintenanceRooms}</div>
                    <div class="status-label">Bảo trì</div>
                </div>
            </div>
        </div>

        <!-- Revenue Overview -->
        <div class="revenue-section">
            <h3><i class="bi bi-graph-up-arrow"></i> Doanh thu</h3>
            <div class="revenue-grid">
                <div class="revenue-item">
                    <div class="revenue-label">Tháng này</div>
                    <div class="revenue-amount"><fmt:formatNumber value="${stats.monthlyRevenue}" pattern="#,###" /> VNĐ</div>
                </div>
                <div class="revenue-item">
                    <div class="revenue-label">Tuần này</div>
                    <div class="revenue-amount"><fmt:formatNumber value="${stats.weeklyRevenue}" pattern="#,###" /> VNĐ</div>
                </div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="charts-section">
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-card">
                        <h4><i class="bi bi-bar-chart"></i> Doanh thu theo tháng</h4>
                        <canvas id="revenueChart" width="400" height="200"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-card">
                        <h4><i class="bi bi-line-chart"></i> Đặt phòng theo ngày</h4>
                        <canvas id="bookingChart" width="400" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Status Distribution -->
        <div class="status-distribution">
            <h3><i class="bi bi-pie-chart"></i> Phân bố trạng thái đặt phòng</h3>
            <div class="status-list">
                <c:forEach items="${stats.bookingStatusStats}" var="status">
                    <div class="status-item">
                        <span class="status-name">${status.key}</span>
                        <span class="status-count">${status.value}</span>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Room Type Distribution -->
        <div class="room-type-distribution">
            <h3><i class="bi bi-building"></i> Phân bố loại phòng</h3>
            <div class="room-type-list">
                <c:forEach items="${stats.roomTypeStats}" var="type">
                    <div class="room-type-item">
                        <span class="type-name">${type.key}</span>
                        <span class="type-count">${type.value}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script>
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        const revenueData = [
            <c:forEach items="${stats.monthlyRevenueData}" var="data" varStatus="status">
                {
                    month: '${data.month}',
                    revenue: ${data.revenue}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        new Chart(revenueCtx, {
            type: 'bar',
            data: {
                labels: revenueData.map(item => item.month),
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: revenueData.map(item => item.revenue),
                    backgroundColor: 'rgba(78, 115, 223, 0.8)',
                    borderColor: 'rgba(78, 115, 223, 1)',
                    borderWidth: 1
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
                }
            }
        });

        // Booking Chart
        const bookingCtx = document.getElementById('bookingChart').getContext('2d');
        const bookingData = [
            <c:forEach items="${stats.dailyBookingData}" var="data" varStatus="status">
                {
                    date: '${data.date}',
                    count: ${data.bookingCount}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        new Chart(bookingCtx, {
            type: 'line',
            data: {
                labels: bookingData.map(item => item.date),
                datasets: [{
                    label: 'Số đặt phòng',
                    data: bookingData.map(item => item.count),
                    borderColor: 'rgba(40, 167, 69, 1)',
                    backgroundColor: 'rgba(40, 167, 69, 0.1)',
                    borderWidth: 2,
                    fill: true
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
                }
            }
        });
    </script>
</body>
</html> 