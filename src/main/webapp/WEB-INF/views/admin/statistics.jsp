<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê chi tiết - Hotel Management</title>
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
            <h1><i class="bi bi-bar-chart"></i> Thống kê chi tiết</h1>
            <p class="text-muted">Báo cáo và phân tích dữ liệu hệ thống</p>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-funnel"></i> Bộ lọc thời gian</h5>
                    <form method="GET" action="${pageContext.request.contextPath}/admin/statistics" class="row g-3">
                        <div class="col-md-4">
                            <label for="startDate" class="form-label">Từ ngày</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" 
                                   value="${startDate}" required>
                        </div>
                        <div class="col-md-4">
                            <label for="endDate" class="form-label">Đến ngày</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" 
                                   value="${endDate}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">&nbsp;</label>
                            <div>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-search"></i> Lọc dữ liệu
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/statistics" class="btn btn-secondary">
                                    <i class="bi bi-arrow-clockwise"></i> Làm mới
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Summary Cards -->
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

        <!-- Detailed Statistics -->
        <div class="row">
            <!-- Booking Status Chart -->
            <div class="col-md-6">
                <div class="chart-card">
                    <h4><i class="bi bi-pie-chart"></i> Phân bố trạng thái đặt phòng</h4>
                    <canvas id="bookingStatusChart" width="400" height="300"></canvas>
                </div>
            </div>

            <!-- Room Type Chart -->
            <div class="col-md-6">
                <div class="chart-card">
                    <h4><i class="bi bi-building"></i> Phân bố loại phòng</h4>
                    <canvas id="roomTypeChart" width="400" height="300"></canvas>
                </div>
            </div>
        </div>

        <!-- Revenue Trend -->
        <div class="chart-card">
            <h4><i class="bi bi-graph-up"></i> Xu hướng doanh thu</h4>
            <canvas id="revenueTrendChart" width="800" height="300"></canvas>
        </div>

        <!-- Detailed Tables -->
        <div class="row">
            <!-- Booking Status Table -->
            <div class="col-md-6">
                <div class="table-card">
                    <h4><i class="bi bi-table"></i> Chi tiết trạng thái đặt phòng</h4>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Trạng thái</th>
                                    <th>Số lượng</th>
                                    <th>Tỷ lệ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${stats.bookingStatusStats}" var="status">
                                    <tr>
                                        <td>
                                            <span class="badge bg-primary">${status.key}</span>
                                        </td>
                                        <td>${status.value}</td>
                                        <td>
                                            <fmt:formatNumber value="${status.value * 100.0 / stats.totalBookings}" 
                                                            pattern="#.##" />%
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Room Type Table -->
            <div class="col-md-6">
                <div class="table-card">
                    <h4><i class="bi bi-table"></i> Chi tiết loại phòng</h4>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Loại phòng</th>
                                    <th>Số lượng</th>
                                    <th>Tỷ lệ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${stats.roomTypeStats}" var="type">
                                    <tr>
                                        <td>${type.key}</td>
                                        <td>${type.value}</td>
                                        <td>
                                            <fmt:formatNumber value="${type.value * 100.0 / stats.totalRooms}" 
                                                            pattern="#.##" />%
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Export Section -->
        <div class="export-section">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-download"></i> Xuất báo cáo</h5>
                    <p class="card-text">Tải xuống báo cáo thống kê dưới dạng CSV hoặc PDF</p>
                    <button class="btn btn-success" onclick="exportToExcel()">
                        <i class="bi bi-file-earmark-text"></i> Xuất CSV
                    </button>
                    <button class="btn btn-danger" onclick="exportToPDF()">
                        <i class="bi bi-file-earmark-pdf"></i> Xuất PDF
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Booking Status Chart
        const bookingStatusCtx = document.getElementById('bookingStatusChart').getContext('2d');
        const bookingStatusData = {
            labels: [
                <c:forEach items="${stats.bookingStatusStats.keySet()}" var="key" varStatus="status">
                    '${key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                data: [
                    <c:forEach items="${stats.bookingStatusStats.keySet()}" var="key" varStatus="status">
                        ${stats.bookingStatusStats[key]}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: [
                    '#4e73df', '#28a745', '#ffc107', '#dc3545', '#6c757d'
                ]
            }]
        };

        new Chart(bookingStatusCtx, {
            type: 'doughnut',
            data: bookingStatusData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Room Type Chart
        const roomTypeCtx = document.getElementById('roomTypeChart').getContext('2d');
        const roomTypeData = {
            labels: [
                <c:forEach items="${stats.roomTypeStats.keySet()}" var="key" varStatus="status">
                    '${key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                data: [
                    <c:forEach items="${stats.roomTypeStats.keySet()}" var="key" varStatus="status">
                        ${stats.roomTypeStats[key]}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: [
                    '#ff6384', '#36a2eb', '#cc65fe', '#ffce56', '#4bc0c0'
                ]
            }]
        };

        new Chart(roomTypeCtx, {
            type: 'pie',
            data: roomTypeData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Revenue Trend Chart
        const revenueTrendCtx = document.getElementById('revenueTrendChart').getContext('2d');
        const revenueTrendData = {
            labels: [
                <c:forEach items="${stats.monthlyRevenueData}" var="data" varStatus="status">
                    '${data.month}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: [
                    <c:forEach items="${stats.monthlyRevenueData}" var="data" varStatus="status">
                        ${data.revenue}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                borderColor: 'rgba(78, 115, 223, 1)',
                backgroundColor: 'rgba(78, 115, 223, 0.1)',
                borderWidth: 2,
                fill: true
            }]
        };

        new Chart(revenueTrendCtx, {
            type: 'line',
            data: revenueTrendData,
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

        // Export functions
        function exportToExcel() {
            window.location.href = '${pageContext.request.contextPath}/admin/export/excel';
        }

        function exportToPDF() {
            alert('Chức năng xuất PDF sẽ được triển khai sau!');
        }
    </script>

    <style>
        .filter-section {
            margin-bottom: 30px;
        }
        
        .table-card {
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e6f0;
            margin-bottom: 20px;
        }
        
        .table-card h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .export-section {
            margin-top: 30px;
        }
        
        .export-section .btn {
            margin-right: 10px;
        }
    </style>
</body>
</html> 