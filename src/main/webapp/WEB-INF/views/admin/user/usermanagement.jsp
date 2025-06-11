<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-room.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-user.css">
</head>
<body>

    <h2>User Management - All Users</h2>


   <table>
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
					<a href="${pageContext.request.contextPath}/admin/user/edit?username=${user.username}">
						<button class="action-btn edit-btn">Edit</button>
					</a>
					<a href="${pageContext.request.contextPath}/admin/deleteUserById?username=${user.username}" onclick="return confirm('Are you sure you want to delete this user?')">
						<button class="action-btn delete-btn">Delete</button>
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


</body>
</html>
