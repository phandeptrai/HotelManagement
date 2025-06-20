<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đổi mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/changePassword.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="../components/header.jsp" />

    <div class="change-password-card">
        <div class="change-password-header">
            <h3><i class="bi bi-shield-lock"></i> Đổi mật khẩu</h3>
            <p>Nhập mật khẩu cũ và mật khẩu mới để cập nhật</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle"></i> ${message}
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/user/change-password">
            <div class="form-group">
                <label for="oldPassword" class="form-label">
                    <i class="bi bi-key"></i> Mật khẩu cũ
                </label>
                <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword" class="form-label">
                    <i class="bi bi-key-fill"></i> Mật khẩu mới
                </label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword" class="form-label">
                    <i class="bi bi-check-circle"></i> Xác nhận mật khẩu mới
                </label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-lg"></i> Đổi mật khẩu
                </button>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 