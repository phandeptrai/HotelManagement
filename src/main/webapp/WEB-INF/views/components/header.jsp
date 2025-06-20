<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/home">
			<i class="bi bi-building"></i> Hotel Management
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/home">
						<i class="bi bi-house"></i> Trang chủ
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/booking/getform">
						<i class="bi bi-calendar-check"></i> Đặt phòng
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/booking/history">
						<i class="bi bi-clock-history"></i> Lịch sử
					</a>
				</li>
				<c:if test="${not empty sessionScope.currentUser}">
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/user/profile">
							<i class="bi bi-person-circle"></i> Thông tin cá nhân
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">
							<i class="bi bi-box-arrow-right"></i> Đăng xuất
						</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</nav> 