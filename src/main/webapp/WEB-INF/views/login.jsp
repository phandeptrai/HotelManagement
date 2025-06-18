<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng Nhập - Hotel Management</title>
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
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-container {
	max-width: 400px;
	width: 100%;
	margin: 2rem auto;
	padding: 2.5rem;
	background: white;
	border-radius: 20px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
}

.login-header {
	text-align: center;
	margin-bottom: 2rem;
}

.login-header h2 {
	color: var(--primary-color);
	font-size: 2rem;
	font-weight: 600;
	margin-bottom: 0.5rem;
}

.login-header p {
	color: var(--dark-color);
	opacity: 0.8;
	margin: 0;
}

.form-label {
	font-weight: 500;
	color: var(--dark-color);
	font-size: 0.9rem;
	margin-bottom: 0.5rem;
}

.form-control {
	border-radius: 10px;
	padding: 0.75rem 1rem;
	border: 2px solid #e3e6f0;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.form-control:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.15);
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
	border: none;
	padding: 0.75rem 2rem;
	font-weight: 500;
	border-radius: 10px;
	font-size: 1rem;
	transition: all 0.3s ease;
	width: 100%;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(78, 115, 223, 0.3);
}

.signup-link {
	display: block;
	margin-top: 1.5rem;
	color: var(--primary-color);
	text-decoration: none;
	font-weight: 500;
	text-align: center;
	transition: all 0.3s ease;
}

.signup-link:hover {
	color: #224abe;
	text-decoration: underline;
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

.input-group-text {
	background-color: var(--light-color);
	border-color: #e3e6f0;
	color: var(--dark-color);
	border-radius: 10px 0 0 10px;
}

.input-group .form-control {
	border-radius: 0 10px 10px 0;
}

.login-icon {
	font-size: 3rem;
	color: var(--primary-color);
	margin-bottom: 1rem;
}

.divider {
	margin: 1.5rem 0;
	text-align: center;
	position: relative;
}

.divider::before {
	content: '';
	position: absolute;
	top: 50%;
	left: 0;
	right: 0;
	height: 1px;
	background: #e3e6f0;
}

.divider span {
	background: white;
	padding: 0 1rem;
	color: var(--dark-color);
	font-size: 0.9rem;
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-header">
			<i class="bi bi-building login-icon"></i>
			<h2>Đăng Nhập</h2>
			<p>Chào mừng bạn đến với hệ thống quản lý khách sạn</p>
		</div>

		<c:if test="${not empty message and message != ''}">
			<div class="alert alert-success" role="alert">
				<i class="bi bi-check-circle-fill"></i> ${message}
			</div>
		</c:if>

		<c:if test="${not empty error and error != ''}">
			<div class="alert alert-danger" role="alert">
				<i class="bi bi-exclamation-triangle-fill"></i> ${error}
			</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/auth/login" method="post">
			<div class="mb-3">
				<label for="username" class="form-label">
					<i class="bi bi-person"></i> Tên đăng nhập
				</label>
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-person-fill"></i>
					</span>
					<input type="text" class="form-control" id="username" name="username" 
						placeholder="Nhập tên đăng nhập" required>
				</div>
			</div>

			<div class="mb-4">
				<label for="password" class="form-label">
					<i class="bi bi-lock"></i> Mật khẩu
				</label>
				<div class="input-group">
					<span class="input-group-text">
						<i class="bi bi-shield-lock-fill"></i>
					</span>
					<input type="password" class="form-control" id="password" name="password" 
						placeholder="Nhập mật khẩu" required>
				</div>
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="bi bi-box-arrow-in-right"></i> Đăng Nhập
			</button>
		</form>

		<div class="divider">
			<span>hoặc</span>
		</div>

		<a href="${pageContext.request.contextPath}/auth/signup" class="signup-link">
			<i class="bi bi-person-plus"></i> Chưa có tài khoản? Đăng ký ngay
		</a>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>