<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Rooms - Home</title>
<style>
/* Dán toàn bộ style từ room/list.jsp vào đây hoặc dùng file CSS riêng */
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
	margin: 0;
	padding: 0;
}
.container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	margin: 30px auto;
	max-width: 1200px;
}
.room-box {
	width: 250px;
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 16px;
	background-color: #fff;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
	text-align: center;
}
.room-box h3 {
	color: #007bff;
}
.room-box .status {
	font-weight: bold;
	text-transform: capitalize;
	color: green;
}
.room-box .status.BOOKED {
	color: red;
}
.room-box .status.MAINTENANCE {
	color: orange;
}
button {
	margin-top: 10px;
	padding: 8px 16px;
	border: none;
	background-color: #007bff;
	color: white;
	border-radius: 6px;
	cursor: pointer;
}
button:disabled {
	background-color: #ccc;
	cursor: not-allowed;
}
</style>
</head>
<body>

	<h2 style="text-align: center">Available Rooms</h2>

	<div class="container">
		<c:forEach var="room" items="${rooms}">
			<div class="room-box">
				<h3>Room ${room.roomNumber}</h3>
				<p>Type: ${room.roomType.typeName}</p>
				<p>Price: ${room.price} VND</p>
				<p class="status ${room.roomStatus}">Status: ${room.roomStatus}</p>
				<button ${room.roomStatus != 'AVAILABLE' ? 'disabled' : ''}>Book Now</button>
				<br/><br/>
				<a href="${pageContext.request.contextPath}/rooms/${room.roomID}">View Details</a>
			</div>
		</c:forEach>
	</div>

</body>
</html>
