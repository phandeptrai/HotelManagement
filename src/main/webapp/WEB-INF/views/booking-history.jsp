<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Lịch Sử Đặt Phòng - Hotel Management</title>
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
	--primary-color: #4e73df;
	--secondary-color: #1cc88a;
	--accent-color: #f6c23e;
	--danger-color: #e74a3b;
	--dark-color: #5a5c69;
	--light-color: #f8f9fc;
}

body {
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	min-height: 100vh;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.navbar {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand {
	font-weight: 600;
	font-size: 1.5rem;
}

.navbar-nav .nav-link {
	color: white !important;
	font-weight: 500;
	transition: all 0.3s ease;
}

.navbar-nav .nav-link:hover {
	color: rgba(255, 255, 255, 0.8) !important;
	transform: translateY(-1px);
}

.page-header {
	background: white;
	padding: 2rem 0;
	margin-bottom: 2rem;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

.page-title {
	color: var(--primary-color);
	font-size: 2.5rem;
	font-weight: 700;
	margin-bottom: 0.5rem;
}

.page-subtitle {
	color: var(--dark-color);
	opacity: 0.8;
	font-size: 1.1rem;
}

.booking-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	transition: all 0.3s ease;
	border: none;
	margin-bottom: 1.5rem;
	overflow: hidden;
}

.booking-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.booking-header {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	color: white;
	padding: 1rem 1.5rem;
}

.booking-id {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 0.25rem;
}

.booking-date {
	opacity: 0.9;
	font-size: 0.9rem;
}

.booking-body {
	padding: 1.5rem;
}

.booking-info {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 1rem;
	margin-bottom: 1.5rem;
}

.info-item {
	display: flex;
	align-items: center;
	padding: 0.75rem;
	background: var(--light-color);
	border-radius: 8px;
}

.info-item i {
	color: var(--primary-color);
	margin-right: 0.75rem;
	font-size: 1.1rem;
	width: 20px;
}

.info-label {
	font-weight: 500;
	color: var(--dark-color);
	margin-right: 0.5rem;
}

.info-value {
	color: var(--dark-color);
	font-weight: 600;
}

.booking-status {
	display: inline-block;
	padding: 0.5rem 1rem;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
	text-transform: uppercase;
}

.booking-status.CONFIRMED {
	background-color: #d4edda;
	color: #155724;
}

.booking-status.CANCELLED {
	background-color: #f8d7da;
	color: #721c24;
}

.booking-status.PENDING {
	background-color: #fff3cd;
	color: #856404;
}

.booking-actions {
	display: flex;
	gap: 1rem;
	flex-wrap: wrap;
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	border: none;
	padding: 0.6rem 1.5rem;
	font-weight: 500;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(78, 115, 223, 0.3);
}

.btn-danger {
	background: linear-gradient(135deg, var(--danger-color) 0%, #c82333 100%);
	border: none;
	padding: 0.6rem 1.5rem;
	font-weight: 500;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.btn-danger:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(231, 74, 59, 0.3);
}

.btn-outline-secondary {
	border-color: var(--dark-color);
	color: var(--dark-color);
	border-radius: 8px;
	transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
	background-color: var(--dark-color);
	border-color: var(--dark-color);
	transform: translateY(-2px);
}

.alert {
	border-radius: 10px;
	margin-bottom: 1.5rem;
	font-size: 0.9rem;
}

.alert-success {
	background-color: #f0f9f4;
	border-color: var(--secondary-color);
	color: var(--secondary-color);
}

.alert-danger {
	background-color: #fdf3f2;
	border-color: var(--danger-color);
	color: var(--danger-color);
}

.empty-state {
	text-align: center;
	padding: 4rem 2rem;
	color: var(--dark-color);
}

.empty-state i {
	font-size: 4rem;
	color: var(--primary-color);
	margin-bottom: 1rem;
}

.cancel-form {
	background: var(--light-color);
	padding: 1rem;
	border-radius: 8px;
	margin-top: 1rem;
}

.cancel-form .form-control {
	border-radius: 8px;
	border: 1px solid #d1d3e2;
}

.cancel-form .form-control:focus {
	border-color: var(--danger-color);
	box-shadow: 0 0 0 0.2rem rgba(231, 74, 59, 0.15);
}

.price-highlight {
	font-size: 1.2rem;
	font-weight: 700;
	color: var(--primary-color);
}

@keyframes fadeInUp {
	from {
		transform: translateY(20px);
		opacity: 0;
	}
	to {
		transform: translateY(0);
		opacity: 1;
	}
}

.booking-card {
	animation: fadeInUp 0.6s ease-out;
}

.booking-card:nth-child(1) { animation-delay: 0.1s; }
.booking-card:nth-child(2) { animation-delay: 0.2s; }
.booking-card:nth-child(3) { animation-delay: 0.3s; }
.booking-card:nth-child(4) { animation-delay: 0.4s; }
.booking-card:nth-child(5) { animation-delay: 0.5s; }
    </style>
</head>
<body>
    <jsp:include page="components/header.jsp" />

    <div class="container">
        <!-- Page Header -->
        <div class="page-header text-center">
            <h1 class="page-title">
                <i class="bi bi-clock-history"></i> Lịch Sử Đặt Phòng
            </h1>
            <p class="page-subtitle">Xem lại các đặt phòng của bạn</p>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${error}
            </div>
        </c:if>

        <!-- Booking List -->
        <c:choose>
            <c:when test="${not empty bookings}">
                <c:forEach items="${bookings}" var="booking">
                    <div class="booking-card">
                        <div class="booking-header">
                            <div class="booking-id">
                                <i class="bi bi-calendar-event"></i> Đặt phòng #${booking.bookingId}
                            </div>
                            <div class="booking-date">
                                <i class="bi bi-clock"></i> Đặt lúc: ${booking.createdAt}
                            </div>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="info-item">
                                    <i class="bi bi-door-open"></i>
                                    <span class="info-label">Phòng:</span>
                                    <span class="info-value">${booking.roomNumber}</span>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-calendar-check"></i>
                                    <span class="info-label">Nhận phòng:</span>
                                    <span class="info-value">${booking.checkInDate}</span>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-calendar-x"></i>
                                    <span class="info-label">Trả phòng:</span>
                                    <span class="info-value">${booking.checkOutDate}</span>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-currency-dollar"></i>
                                    <span class="info-label">Tổng tiền:</span>
                                    <span class="info-value price-highlight"><fmt:formatNumber value="${booking.totalAmount}" pattern="#,###" /> VNĐ</span>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-info-circle"></i>
                                    <span class="info-label">Trạng thái:</span>
                                    <span class="booking-status ${booking.bookingStatus}">${booking.bookingStatus}</span>
                                </div>
                            </div>

                            <div class="booking-actions">
                                <c:choose>
                                    <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                                        <div class="text-muted">
                                            <i class="bi bi-x-circle"></i> Đã hủy lúc ${booking.cancelledAt}
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn btn-danger" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#cancelModal${booking.bookingId}">
                                            <i class="bi bi-x-circle"></i> Hủy phòng
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/booking/detail/${booking.bookingId}" 
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-eye"></i> Xem chi tiết
                                </a>
                                <c:if test="${booking.bookingStatus == 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/booking/confirm" method="post" style="display:inline-block;">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-check-circle"></i> Duyệt
                                        </button>
                                    </form>
                                </c:if>
                            </div>

                            <!-- Cancel Modal -->
                            <c:if test="${booking.bookingStatus != 'CANCELLED'}">
                                <div class="modal fade" id="cancelModal${booking.bookingId}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">
                                                    <i class="bi bi-exclamation-triangle"></i> Xác nhận hủy phòng
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/booking/cancel" method="post">
                                                <div class="modal-body">
                                                    <p>Bạn có chắc chắn muốn hủy đặt phòng #${booking.bookingId}?</p>
                                                    <div class="mb-3">
                                                        <label for="cancelReason${booking.bookingId}" class="form-label">Lý do hủy:</label>
                                                        <textarea class="form-control" id="cancelReason${booking.bookingId}" 
                                                                  name="cancelReason" rows="3" required 
                                                                  placeholder="Nhập lý do hủy phòng..."></textarea>
                                                    </div>
                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                    <input type="hidden" name="userId" value="${userId}" />
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        <i class="bi bi-x"></i> Hủy
                                                    </button>
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="bi bi-check"></i> Xác nhận hủy
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="bi bi-calendar-x"></i>
                    <h3>Chưa có đặt phòng nào</h3>
                    <p>Bạn chưa có lịch sử đặt phòng nào. Hãy thử đặt phòng ngay!</p>
                    <a href="${pageContext.request.contextPath}/booking/getform" class="btn btn-primary">
                        <i class="bi bi-calendar-check"></i> Đặt phòng ngay
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
