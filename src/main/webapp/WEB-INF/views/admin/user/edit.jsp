<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit User</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/edit-user.css">
	
</head>
<body>
	<h2 style="text-align:center">Edit User</h2>

	<form action="${pageContext.request.contextPath}/admin/user/edit" method="post" style="width: 400px; margin: auto">

		<input type="hidden" name="id" value="${user.userID}" />

		<label>Username:</label>
		<input type="text" name="username" value="${user.username}" required />
		<br><br>

		<label>Full Name:</label>
		<input type="text" name="fullName" value="${user.fullName}"  />
		<br><br>

		<label>Email:</label>
		<input type="email" name="email" value="${user.email}"  />
		<br><br>

		<label>Phone Number:</label>
		<input type="text" name="phoneNumber" value="${user.phoneNumber}"  />
		<br><br>

		<label>Role:</label>
		<select name="userRole">
			<c:forEach var="r" items="${roles}">
				<option value="${r}" <c:if test="${r == user.userRole}">selected</c:if>>${r}</option>
			</c:forEach>
		</select>
		<br><br>

		<label>Password (leave blank to keep current):</label>
		<input type="password" name="password" />
		<br><br>

		<button type="submit">Save Changes</button>
	</form>
</body>
</html>
