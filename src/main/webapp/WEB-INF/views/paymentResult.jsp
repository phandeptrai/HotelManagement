<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Kết Quả Thanh Toán - Hotel Management</title>
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
	display: flex;
	align-items: center;
	justify-content: center;
}

.result-container {
	max-width: 600px;
	width: 100%;
	margin: 2rem auto;
	padding: 3rem;
	background: white;
	border-radius: 20px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.result-icon {
	font-size: 4rem;
	margin-bottom: 1.5rem;
}

.result-icon.success {
	color: var(--secondary-color);
}

.result-icon.error {
	color: var(--danger-color);
}

.result-icon.pending {
	color: var(--accent-color);
}

.result-title {
	font-size: 2rem;
	font-weight: 700;
	margin-bottom: 1rem;
}

.result-title.success {
	color: var(--secondary-color);
}

.result-title.error {
	color: var(--danger-color);
}

.result-title.pending {
	color: var(--accent-color);
}

.result-message {
	font-size: 1.1rem;
	color: var(--dark-color);
	margin-bottom: 2rem;
	line-height: 1.6;
}

.action-buttons {
	display: flex;
	gap: 1rem;
	justify-content: center;
	flex-wrap: wrap;
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	border: none;
	padding: 0.75rem 2rem;
	font-weight: 500;
	border-radius: 10px;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(78, 115, 223, 0.3);
}

.btn-success {
	background: linear-gradient(135deg, var(--secondary-color) 0%, #17a673 100%);
	border: none;
	padding: 0.75rem 2rem;
	font-weight: 500;
	border-radius: 10px;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.btn-success:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(28, 200, 138, 0.3);
}

.btn-outline-secondary {
	border-color: var(--dark-color);
	color: var(--dark-color);
	border-radius: 10px;
	padding: 0.75rem 2rem;
	font-weight: 500;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
	background-color: var(--dark-color);
	border-color: var(--dark-color);
	transform: translateY(-2px);
}

.payment-details {
	background: var(--light-color);
	padding: 1.5rem;
	border-radius: 10px;
	margin: 2rem 0;
	text-align: left;
}

.payment-details h4 {
	color: var(--primary-color);
	margin-bottom: 1rem;
	font-size: 1.2rem;
}

.detail-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 0.75rem;
	padding-bottom: 0.5rem;
	border-bottom: 1px solid #e3e6f0;
}

.detail-item:last-child {
	border-bottom: none;
	margin-bottom: 0;
	padding-bottom: 0;
}

.detail-label {
	font-weight: 500;
	color: var(--dark-color);
}

.detail-value {
	font-weight: 600;
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

.result-container {
	animation: fadeInUp 0.6s ease-out;
}
    </style>
</head>
<body>
    <div class="result-container">
        <c:choose>
            <c:when test="${not empty success && success}">
                <i class="bi bi-check-circle-fill result-icon success"></i>
                <h1 class="result-title success">Thanh Toán Thành Công!</h1>
                <p class="result-message">
                    Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Đặt phòng của bạn đã được xác nhận và thanh toán thành công.
                </p>
            </c:when>
            <c:when test="${not empty pending && pending}">
                <i class="bi bi-clock-history result-icon pending"></i>
                <h1 class="result-title pending">Đang Xử Lý Thanh Toán</h1>
                <p class="result-message">
                    Thanh toán của bạn đang được xử lý. Vui lòng chờ trong giây lát hoặc kiểm tra email để biết thêm thông tin.
                </p>
            </c:when>
            <c:otherwise>
                <i class="bi bi-x-circle-fill result-icon error"></i>
                <h1 class="result-title error">Thanh Toán Thất Bại</h1>
                <p class="result-message">
                    Rất tiếc, thanh toán của bạn không thành công. Vui lòng thử lại hoặc liên hệ với chúng tôi để được hỗ trợ.
                </p>
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty message}">
            <div class="payment-details">
                <h4><i class="bi bi-info-circle"></i> Thông Tin Chi Tiết</h4>
                <div class="detail-item">
                    <span class="detail-label">Trạng thái:</span>
                    <span class="detail-value">${message}</span>
                </div>
                <c:if test="${not empty bookingId}">
                    <div class="detail-item">
                        <span class="detail-label">Mã đặt phòng:</span>
                        <span class="detail-value">#${bookingId}</span>
                    </div>
                </c:if>
                <c:if test="${not empty amount}">
                    <div class="detail-item">
                        <span class="detail-label">Số tiền:</span>
                        <span class="detail-value"><fmt:formatNumber value="${amount}" pattern="#,###" /> VNĐ</span>
                    </div>
                </c:if>
            </div>
        </c:if>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/booking/getform" class="btn btn-primary">
                <i class="bi bi-calendar-check"></i> Đặt Phòng Mới
            </a>
            <a href="${pageContext.request.contextPath}/booking/history" class="btn btn-success">
                <i class="bi bi-clock-history"></i> Xem Lịch Sử
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                <i class="bi bi-house"></i> Về Trang Chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
