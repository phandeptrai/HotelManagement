<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-user-management.css">
</head>
<body>

    <div class="admin-content">
        <div class="admin-user-card">
            <div class="admin-user-title">
                <i class="bi bi-people"></i> User Management - All Users
            </div>
            <div class="table-responsive">
                <table class="admin-user-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.fullName}</td>
                                <td>${user.username}</td>
                                <td>${user.password}</td>
                                <td>${user.email}</td>
                                <td>${user.phoneNumber}</td>
                                <td>${user.role}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/user/edit?username=${user.username}" style="text-decoration:none;">
                                        <button class="action-btn edit-btn">
                                            <i class="bi bi-pencil"></i> Edit
                                        </button>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/deleteUserById?username=${user.username}" onclick="return confirm('Are you sure you want to delete this user?')" style="text-decoration:none;">
                                        <button class="action-btn delete-btn">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
