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
	border: none;
	border-radius: 10px;
	padding: 1rem 1.5rem;
	margin-bottom: 1.5rem;
	font-weight: 500;
}

.alert-success {
	background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
	color: #155724;
	border-left: 4px solid #28a745;
}

.alert-danger {
	background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
	color: #721c24;
	border-left: 4px solid #dc3545;
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

/* Loading state for buttons */
.btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    pointer-events: none;
}
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
                                            <c:if test="${not empty booking.cancelReason}">
                                                <br><small class="text-muted">Lý do: ${booking.cancelReason}</small>
                                            </c:if>
                                        </div>
                                    </c:when>
                                    <c:when test="${booking.bookingStatus == 'CONFIRMED' and booking.checkInDate <= today}">
                                        <div class="text-muted">
                                            <i class="bi bi-info-circle"></i> Không thể hủy - đã đến ngày nhận phòng
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn btn-danger cancel-booking-btn" 
                                                data-booking-id="${booking.bookingId}"
                                                data-room-number="${booking.roomNumber}"
                                                data-check-in="${booking.checkInDate}">
                                            <i class="bi bi-x-circle"></i> Hủy phòng
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/booking/detail/${booking.bookingId}" 
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-eye"></i> Xem chi tiết
                                </a>
                            </div>
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

    <!-- Single Cancel Modal for all bookings -->
    <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cancelModalLabel">
                        <i class="bi bi-exclamation-triangle"></i> Xác nhận hủy phòng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/booking/cancel" method="post" id="cancelForm">
                    <div class="modal-body">
                        <p id="cancelModalText">Bạn có chắc chắn muốn hủy đặt phòng?</p>
                        <div class="mb-3">
                            <label for="cancelReason" class="form-label">Lý do hủy:</label>
                            <textarea class="form-control" id="cancelReason" 
                                      name="cancelReason" rows="3" required 
                                      placeholder="Nhập lý do hủy phòng..."></textarea>
                        </div>
                        <input type="hidden" name="bookingId" id="cancelBookingId" />
                        <input type="hidden" name="userId" value="${currentUser.userID}" />
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle cancel booking button clicks
        document.addEventListener('DOMContentLoaded', function() {
            const cancelButtons = document.querySelectorAll('.cancel-booking-btn');
            const cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
            
            cancelButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const bookingId = this.getAttribute('data-booking-id');
                    const roomNumber = this.getAttribute('data-room-number');
                    const checkInDate = this.getAttribute('data-check-in');
                    
                    // Update modal content with more details
                    document.getElementById('cancelModalText').innerHTML = 
                        `<strong>Bạn có chắc chắn muốn hủy đặt phòng #${bookingId}?</strong><br>
                         <small class="text-muted">
                         Phòng: ${roomNumber}<br>
                         Ngày nhận phòng: ${checkInDate}
                         </small>`;
                    document.getElementById('cancelBookingId').value = bookingId;
                    
                    // Clear previous reason
                    document.getElementById('cancelReason').value = '';
                    
                    // Show modal
                    cancelModal.show();
                });
            });
            
            // Handle form submission with better validation
            document.getElementById('cancelForm').addEventListener('submit', function(e) {
                const reason = document.getElementById('cancelReason').value.trim();
                if (!reason) {
                    e.preventDefault();
                    alert('Vui lòng nhập lý do hủy phòng!');
                    document.getElementById('cancelReason').focus();
                    return false;
                }
                
                if (reason.length < 10) {
                    e.preventDefault();
                    alert('Lý do hủy phòng phải có ít nhất 10 ký tự!');
                    document.getElementById('cancelReason').focus();
                    return false;
                }
                
                // Show loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
                submitBtn.disabled = true;
                
                // Hide modal
                cancelModal.hide();
                
                // Submit form
                this.submit();
            });
            
            // Auto-resize textarea
            const textarea = document.getElementById('cancelReason');
            textarea.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = Math.min(this.scrollHeight, 120) + 'px';
            });
            
            // Auto-refresh page after successful cancellation
            const successMessage = document.querySelector('.alert-success');
            if (successMessage && successMessage.textContent.includes('Hủy đặt phòng thành công')) {
                setTimeout(() => {
                    window.location.reload();
                }, 2000);
            }
        });
    </script>
</body>
</html>
