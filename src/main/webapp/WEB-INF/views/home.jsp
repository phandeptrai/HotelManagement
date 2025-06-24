<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Hotel Management</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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

* {
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-rendering: optimizeLegibility;
}

body {
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	min-height: 100vh;
	font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
	font-weight: 400;
	line-height: 1.6;
	color: var(--dark-color);
}

.navbar {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	backdrop-filter: blur(10px);
}

.navbar-brand {
	font-weight: 600;
	font-size: 1.4rem;
	letter-spacing: -0.5px;
}

.navbar-nav .nav-link {
	color: white !important;
	font-weight: 500;
	font-size: 0.95rem;
	transition: all 0.3s ease;
	letter-spacing: 0.2px;
}

.navbar-nav .nav-link:hover {
	color: rgba(255, 255, 255, 0.9) !important;
	transform: translateY(-1px);
}

.hero-section {
	background: linear-gradient(135deg, rgba(78, 115, 223, 0.95) 0%, rgba(34, 74, 190, 0.95) 100%);
	color: white;
	padding: 4rem 0;
	text-align: center;
	margin-bottom: 3rem;
	position: relative;
	overflow: hidden;
}

.hero-section::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
	opacity: 0.3;
}

.hero-section h1 {
	font-size: 2.8rem;
	font-weight: 700;
	margin-bottom: 1rem;
	letter-spacing: -1px;
	line-height: 1.2;
	position: relative;
	z-index: 1;
}

.hero-section p {
	font-size: 1.1rem;
	opacity: 0.95;
	margin-bottom: 2rem;
	font-weight: 400;
	position: relative;
	z-index: 1;
}

.room-card {
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	border: none;
	overflow: hidden;
	margin-bottom: 2rem;
}

.room-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
}

.room-card .card-body {
	padding: 1.5rem;
}

.room-card .card-title {
	color: var(--primary-color);
	font-weight: 600;
	font-size: 1.2rem;
	margin-bottom: 1rem;
	letter-spacing: -0.3px;
}

.room-info {
	margin-bottom: 1.2rem;
}

.room-info .info-item {
	display: flex;
	align-items: center;
	margin-bottom: 0.6rem;
	color: var(--dark-color);
	font-size: 0.9rem;
}

.room-info .info-item i {
	color: var(--primary-color);
	margin-right: 0.6rem;
	width: 18px;
	font-size: 1rem;
}

.room-status {
	display: inline-block;
	padding: 0.3rem 0.8rem;
	border-radius: 20px;
	font-size: 0.75rem;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.room-status.AVAILABLE {
	background-color: #d1f2eb;
	color: #0d9488;
}

.room-status.BOOKED {
	background-color: #fee2e2;
	color: #dc2626;
}

.room-status.MAINTENANCE {
	background-color: #fef3c7;
	color: #d97706;
}

.btn {
	font-weight: 500;
	letter-spacing: 0.3px;
	border-radius: 10px;
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	border: none;
	padding: 0.7rem 1.5rem;
	font-weight: 500;
	border-radius: 10px;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 20px rgba(78, 115, 223, 0.3);
}

.btn-outline-primary {
	border-color: var(--primary-color);
	color: var(--primary-color);
	border-radius: 10px;
	transition: all 0.3s ease;
}

.btn-outline-primary:hover {
	background-color: var(--primary-color);
	border-color: var(--primary-color);
	transform: translateY(-2px);
}

.btn-outline-secondary {
	border-color: #6c757d;
	color: #6c757d;
	border-radius: 10px;
	transition: all 0.3s ease;
}

.btn-outline-secondary:hover {
	background-color: #6c757d;
	border-color: #6c757d;
	transform: translateY(-2px);
}

.btn-danger {
	background: linear-gradient(135deg, var(--danger-color) 0%, #c82333 100%);
	border: none;
	border-radius: 10px;
	transition: all 0.3s ease;
}

.btn-danger:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 20px rgba(231, 74, 59, 0.3);
}

.section-title {
	text-align: center;
	margin-bottom: 3rem;
	color: var(--dark-color);
	font-weight: 500;
}

.section-title h2 {
	color: var(--primary-color);
	font-size: 2.2rem;
	margin-bottom: 1rem;
	font-weight: 700;
	letter-spacing: -0.8px;
}

.section-title p {
	font-size: 1rem;
	opacity: 0.8;
	font-weight: 400;
}

.empty-state {
	text-align: center;
	padding: 3rem;
	color: var(--dark-color);
}

.empty-state i {
	font-size: 4rem;
	color: var(--primary-color);
	margin-bottom: 1rem;
	opacity: 0.7;
}

.empty-state h3 {
	font-weight: 600;
	margin-bottom: 0.5rem;
	letter-spacing: -0.3px;
}

.empty-state p {
	font-weight: 400;
	opacity: 0.8;
}

.stats-section {
	background: white;
	padding: 2.5rem 0;
	margin-bottom: 3rem;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.search-section {
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
	overflow: hidden;
}

.search-section .card {
	border: none;
	border-radius: 16px;
}

.search-section .card-title {
	color: var(--primary-color);
	font-weight: 600;
	font-size: 1.2rem;
	letter-spacing: -0.3px;
}

.search-section .form-label {
	font-weight: 500;
	color: var(--dark-color);
	font-size: 0.9rem;
	letter-spacing: 0.2px;
}

.search-section .form-control,
.search-section .form-select {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	transition: all 0.3s ease;
	font-size: 0.9rem;
}

.search-section .form-control:focus,
.search-section .form-select:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
}

.search-section .form-check-input:checked {
	background-color: var(--primary-color);
	border-color: var(--primary-color);
}

.search-section .form-check-label {
	font-size: 0.9rem;
	color: var(--dark-color);
	font-weight: 500;
}

.stat-item {
	text-align: center;
	padding: 1.5rem 1rem;
}

.stat-number {
	font-size: 2.5rem;
	font-weight: 700;
	color: var(--primary-color);
	margin-bottom: 0.5rem;
	letter-spacing: -1px;
}

.stat-label {
	color: var(--dark-color);
	font-weight: 500;
	font-size: 0.95rem;
	letter-spacing: 0.2px;
}

@keyframes fadeInUp {
	from {
		transform: translateY(30px);
		opacity: 0;
	}
	to {
		transform: translateY(0);
		opacity: 1;
	}
}

.room-card {
	animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.room-card:nth-child(1) { animation-delay: 0.1s; }
.room-card:nth-child(2) { animation-delay: 0.2s; }
.room-card:nth-child(3) { animation-delay: 0.3s; }
.room-card:nth-child(4) { animation-delay: 0.4s; }
.room-card:nth-child(5) { animation-delay: 0.5s; }
.room-card:nth-child(6) { animation-delay: 0.6s; }

/* Responsive improvements */
@media (max-width: 768px) {
	.hero-section h1 {
		font-size: 2.2rem;
	}
	
	.hero-section p {
		font-size: 1rem;
	}
	
	.section-title h2 {
		font-size: 1.8rem;
	}
	
	.stat-number {
		font-size: 2rem;
	}
	
	.room-card .card-title {
		font-size: 1.1rem;
	}
	
	.search-section .card-body {
		padding: 1rem;
	}
	
	.search-section .row {
		margin: 0;
	}
	
	.search-section .col-md-3,
	.search-section .col-md-2 {
		padding: 0.5rem;
	}
	
	.search-section .d-flex {
		flex-direction: column;
		gap: 1rem !important;
	}
	
	.search-section .form-check {
		margin: 0;
	}
}
</style>
</head>
<body>
	<jsp:include page="components/header.jsp" />

	<!-- Hero Section -->
	<div class="hero-section">
		<div class="container">
			<h1>Chào mừng đến với Hotel Management</h1>
			<p>Khám phá các phòng khách sạn chất lượng cao với dịch vụ tuyệt vời</p>
			<a href="${pageContext.request.contextPath}/booking/getform" class="btn btn-light btn-lg">
				<i class="bi bi-calendar-check"></i> Đặt phòng ngay
			</a>
		</div>
	</div>

	<!-- Stats Section -->
	<div class="container">
		<div class="stats-section">
			<div class="row">
				<div class="col-md-4">
					<div class="stat-item">
						<div class="stat-number">${rooms.size()}</div>
						<div class="stat-label">Tổng số phòng</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-item">
						<div class="stat-number">
							<c:set var="availableCount" value="0" />
							<c:forEach var="room" items="${rooms}">
								<c:if test="${room.roomStatus == 'AVAILABLE'}">
									<c:set var="availableCount" value="${availableCount + 1}" />
								</c:if>
							</c:forEach>
							${availableCount}
						</div>
						<div class="stat-label">Phòng trống</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-item">
						<div class="stat-number">
							<c:set var="bookedCount" value="0" />
							<c:forEach var="room" items="${rooms}">
								<c:if test="${room.roomStatus == 'BOOKED'}">
									<c:set var="bookedCount" value="${bookedCount + 1}" />
								</c:if>
							</c:forEach>
							${bookedCount}
						</div>
						<div class="stat-label">Phòng đã đặt</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Search Section -->
	<div class="container">
		<div class="search-section mb-4">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title mb-3">
						<i class="bi bi-search"></i> Tìm kiếm phòng
					</h5>
					<form method="GET" action="${pageContext.request.contextPath}/home/search" class="row g-3">
						<div class="col-md-3">
							<label for="roomNumber" class="form-label">Số phòng</label>
							<input type="text" class="form-control" id="roomNumber" name="roomNumber" 
								   placeholder="Nhập số phòng..." value="${param.roomNumber}">
						</div>
						<div class="col-md-3">
							<label for="roomTypeName" class="form-label">Loại phòng</label>
							<select class="form-select" id="roomTypeName" name="roomTypeName">
								<option value="">Tất cả loại phòng</option>
								<option value="SINGLE" ${param.roomTypeName == 'SINGLE' ? 'selected' : ''}>Phòng đơn</option>
								<option value="DOUBLE" ${param.roomTypeName == 'DOUBLE' ? 'selected' : ''}>Phòng đôi</option>
								<option value="SUITE" ${param.roomTypeName == 'SUITE' ? 'selected' : ''}>Phòng Suite</option>
							</select>
						</div>
						<div class="col-md-2">
							<label for="minPrice" class="form-label">Giá từ</label>
							<input type="number" class="form-control" id="minPrice" name="minPrice" 
								   placeholder="VNĐ" value="${param.minPrice}">
						</div>
						<div class="col-md-2">
							<label for="maxPrice" class="form-label">Giá đến</label>
							<input type="number" class="form-control" id="maxPrice" name="maxPrice" 
								   placeholder="VNĐ" value="${param.maxPrice}">
						</div>
						<div class="col-md-2">
							<label for="roomStatus" class="form-label">Trạng thái</label>
							<select class="form-select" id="roomStatus" name="roomStatus">
								<option value="">Tất cả</option>
								<option value="AVAILABLE" ${param.roomStatus == 'AVAILABLE' ? 'selected' : ''}>Trống</option>
								<option value="BOOKED" ${param.roomStatus == 'BOOKED' ? 'selected' : ''}>Đã đặt</option>
								<option value="MAINTENANCE" ${param.roomStatus == 'MAINTENANCE' ? 'selected' : ''}>Bảo trì</option>
							</select>
						</div>
						<div class="col-12">
							<div class="d-flex gap-2">
								<button type="submit" class="btn btn-primary">
									<i class="bi bi-search"></i> Tìm kiếm
								</button>
								<a href="${pageContext.request.contextPath}/rooms/home" class="btn btn-outline-secondary">
									<i class="bi bi-arrow-clockwise"></i> Làm mới
								</a>
								<div class="form-check ms-3">
									<input class="form-check-input" type="checkbox" id="available" name="available" value="true" 
										   ${param.available == 'true' ? 'checked' : ''}>
									<label class="form-check-label" for="available">
										Chỉ hiển thị phòng trống
									</label>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Rooms Section -->
	<div class="container">
		<div class="section-title">
			<h2>Danh sách phòng</h2>
			<p>
				<c:choose>
					<c:when test="${not empty param.roomNumber or not empty param.roomTypeName or not empty param.minPrice or not empty param.maxPrice or not empty param.roomStatus or param.available == 'true'}">
						Kết quả tìm kiếm (${rooms.size()} phòng)
					</c:when>
					<c:otherwise>
						Chọn phòng phù hợp với nhu cầu của bạn
					</c:otherwise>
				</c:choose>
			</p>
		</div>

		<c:choose>
			<c:when test="${not empty rooms}">
				<div class="row">
					<c:forEach var="room" items="${rooms}">
						<div class="col-lg-4 col-md-6">
							<div class="card room-card">
								<div class="card-body">
									<h5 class="card-title">
										<i class="bi bi-door-open"></i> Phòng ${room.roomNumber}
									</h5>
									<div class="room-info">
										<div class="info-item">
											<i class="bi bi-tag"></i>
											<span>Loại: ${room.roomType.typeName}</span>
										</div>
										<div class="info-item">
											<i class="bi bi-currency-dollar"></i>
											<span>Giá: <fmt:formatNumber value="${room.price}" pattern="#,###" /> VNĐ</span>
										</div>
										<div class="info-item">
											<i class="bi bi-info-circle"></i>
											<span class="room-status ${room.roomStatus}">${room.roomStatus}</span>
										</div>
									</div>
									<div class="d-grid gap-2">
										<c:choose>
											<c:when test="${room.roomStatus == 'AVAILABLE'}">
												<a href="${pageContext.request.contextPath}/booking/getform?roomId=${room.roomID}" 
												   class="btn btn-primary">
													<i class="bi bi-calendar-check"></i> Đặt ngay
												</a>
											</c:when>
											<c:otherwise>
												<button class="btn btn-outline-secondary" disabled>
													<i class="bi bi-x-circle"></i> Không khả dụng
												</button>
											</c:otherwise>
										</c:choose>
										<a href="${pageContext.request.contextPath}/rooms/${room.roomID}" 
										   class="btn btn-outline-primary">
											<i class="bi bi-eye"></i> Xem chi tiết
										</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div class="empty-state">
					<i class="bi bi-building-x"></i>
					<h3>Không có phòng nào</h3>
					<p>Hiện tại không có phòng nào trong hệ thống.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// Form validation và auto-submit
		document.addEventListener('DOMContentLoaded', function() {
			const searchForm = document.querySelector('form[action*="/home/search"]');
			const inputs = searchForm.querySelectorAll('input, select');
			
			// Auto-submit khi thay đổi select
			const selects = searchForm.querySelectorAll('select');
			selects.forEach(select => {
				select.addEventListener('change', function() {
					if (this.value !== '') {
						searchForm.submit();
					}
				});
			});
			
			// Auto-submit khi check/uncheck available
			const availableCheckbox = document.getElementById('available');
			availableCheckbox.addEventListener('change', function() {
				searchForm.submit();
			});
			
			// Validation cho giá
			const minPriceInput = document.getElementById('minPrice');
			const maxPriceInput = document.getElementById('maxPrice');
			
			minPriceInput.addEventListener('input', function() {
				const minPrice = parseInt(this.value) || 0;
				const maxPrice = parseInt(maxPriceInput.value) || 0;
				
				if (maxPrice > 0 && minPrice > maxPrice) {
					this.setCustomValidity('Giá tối thiểu không được lớn hơn giá tối đa');
				} else {
					this.setCustomValidity('');
				}
			});
			
			maxPriceInput.addEventListener('input', function() {
				const maxPrice = parseInt(this.value) || 0;
				const minPrice = parseInt(minPriceInput.value) || 0;
				
				if (minPrice > 0 && maxPrice > 0 && minPrice > maxPrice) {
					this.setCustomValidity('Giá tối đa không được nhỏ hơn giá tối thiểu');
				} else {
					this.setCustomValidity('');
				}
			});
			
			// Clear form
			const clearBtn = document.querySelector('a[href*="/home"]');
			clearBtn.addEventListener('click', function(e) {
				e.preventDefault();
				inputs.forEach(input => {
					if (input.type === 'checkbox') {
						input.checked = false;
					} else {
						input.value = '';
					}
				});
				searchForm.submit();
			});
			
			// Highlight active search criteria
			const activeParams = new URLSearchParams(window.location.search);
			if (activeParams.toString()) {
				searchForm.style.border = '2px solid var(--primary-color)';
				searchForm.style.borderRadius = '16px';
				searchForm.style.padding = '1rem';
				searchForm.style.backgroundColor = 'rgba(78, 115, 223, 0.05)';
			}
		});
		
		// Smooth scroll to results
		function scrollToResults() {
			const roomsSection = document.querySelector('.section-title');
			if (roomsSection) {
				roomsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
			}
		}
		
		// Auto-scroll after search
		if (window.location.search.includes('roomNumber') || 
			window.location.search.includes('roomTypeName') || 
			window.location.search.includes('minPrice') || 
			window.location.search.includes('maxPrice') || 
			window.location.search.includes('roomStatus') || 
			window.location.search.includes('available')) {
			setTimeout(scrollToResults, 500);
		}
	</script>
</body>
</html>
