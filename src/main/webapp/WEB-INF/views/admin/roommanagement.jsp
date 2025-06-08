<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin - Room List</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-room.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-sidebar.css">
	
	<style>
		.action-btn {
			padding: 5px 10px;
			margin: 0 3px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			font-size: 13px;
		}
		.edit-btn {
			background-color: #ffc107;
			color: white;
		}
		.delete-btn {
			background-color: #dc3545;
			color: white;
		}
		.add-btn {
			background-color: #28a745;
			color: white;
			padding: 8px 16px;
			text-decoration: none;
			border-radius: 5px;
			display: inline-block;
			margin: 15px 5%;
		}
	</style>
</head>
<body>


	<h2>Room Management - All Rooms</h2>

	<a href="${pageContext.request.contextPath}/admin/room/add" class="add-btn">+ Add Room</a>

	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Room Number</th>
				<th>Type</th>
				<th>Price (VND)</th>
				<th>Status</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="room" items="${rooms}">
				<tr>
					<td>${room.roomID}</td>
					<td>${room.roomNumber}</td>
					<td>${room.roomType.typeName}</td>
					<td>${room.price}</td>
					<td class="status-${room.roomStatus}">${room.roomStatus}</td>
					<td>
						<a href="${pageContext.request.contextPath}/admin/room/edit?id=${room.roomID}">
							<button class="action-btn edit-btn">Edit</button>
						</a>	
						<a href="${pageContext.request.contextPath}/admin/room/lock?id=${room.roomID}" onclick="return confirm('Are you sure you want to delete this room?')">
							<button class="action-btn delete-btn">Lock</button>
						</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>
 