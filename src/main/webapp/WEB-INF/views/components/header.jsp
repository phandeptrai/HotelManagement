<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/home">
			<i class="bi bi-building"></i> Hotel Management
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/home"> <i
						class="bi bi-house"></i> Trang chủ
				</a></li>
				<c:if test="${not empty sessionScope.currentUser}">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/booking/history"> <i
							class="bi bi-clock-history"></i> Lịch sử
					</a></li>
				</c:if>
				<c:if test="${empty sessionScope.currentUser}">

					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/auth/login"> <i
							class="bi bi-box-arrow-right"></i> Đăng Nhập
					</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.currentUser}">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/user/profile"> <i
							class="bi bi-person-circle"></i> Thông tin cá nhân
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/auth/logout"> <i
							class="bi bi-box-arrow-right"></i> Đăng xuất
					</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>
<style>
:root {
	--primary-color: #4e73df;
	--secondary-color: #1cc88a;
	--accent-color: #f6c23e;
	--danger-color: #e74a3b;
	--dark-color: #5a5c69;
	--light-color: #f8f9fc;
}

.navbar {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe
		100%);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
</style>
