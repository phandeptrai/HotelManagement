<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin cá nhân</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userProfile.css">
</head>
<body>
    <!-- Navbar/Header giống home.jsp -->
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/user/profile">
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
    <!-- End Navbar -->

    <div class="profile-card">
        <div class="profile-avatar">
            <i class="bi bi-person-circle"></i>
        </div>
        
        <!-- View Mode -->
        <div id="viewMode">
            <div class="profile-title text-center">${user.fullName}</div>
            <div class="text-muted text-center mb-4">@${user.username}</div>
            <div class="profile-info mb-2">
                <label>Họ tên:</label> <span>${user.fullName}</span>
            </div>
            <div class="profile-info mb-2">
                <label>Tên đăng nhập:</label> <span>${user.username}</span>
            </div>
            <div class="profile-info mb-2">
                <label>Mật khẩu:</label> <span>********</span>
            </div>
            <div class="profile-info mb-2">
                <label>Email:</label> <span>${user.email}</span>
            </div>
            <div class="profile-info mb-2">
                <label>Số điện thoại:</label> <span>${user.phoneNumber}</span>
            </div>
            <div class="text-center mt-4">
                <button class="btn btn-outline-primary edit-btn" onclick="showEditForm()">
                    <i class="bi bi-pencil"></i> Chỉnh sửa thông tin
                </button>
                <a href="${pageContext.request.contextPath}/user/change-password" class="btn btn-outline-primary edit-btn mt-2">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </div>
        </div>
        
        <!-- Edit Mode -->
        <div id="editMode" class="edit-form">
            <h4 class="text-center mb-4">Chỉnh sửa thông tin</h4>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <form method="post" action="${pageContext.request.contextPath}/user/update-profile">
                <div class="form-group">
                    <label for="fullName" class="form-label">Họ tên</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check"></i> Lưu thay đổi
                    </button>
                    <button type="button" class="btn btn-outline-secondary" onclick="hideEditForm()">
                        <i class="bi bi-x"></i> Hủy
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showEditForm() {
            document.getElementById('viewMode').style.display = 'none';
            document.getElementById('editMode').classList.add('show');
        }
        
        function hideEditForm() {
            document.getElementById('viewMode').style.display = 'block';
            document.getElementById('editMode').classList.remove('show');
        }
    </script>
</body>
</html>