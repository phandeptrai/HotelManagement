
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Rooms</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
	margin: 0;
	padding: 0;
}

h2 {
	text-align: center;
	margin-top: 30px;
	color: #333;
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
	transition: transform 0.3s ease, box-shadow 0.3s ease, background-color
		0.3s ease;
	opacity: 0;
	animation: fadeInUp 0.5s forwards;
}

.room-box:hover {
	transform: translateY(-6px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
	background-color: #fefefe;
}

.room-box h3 {
	margin-top: 0;
	font-size: 18px;
	color: #007bff;
}

.room-box p {
	margin: 8px 0;
	font-size: 14px;
	color: #555;
}

.room-box .price {
	font-weight: bold;
	color: #28a745;
	font-size: 16px;
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

.room-box button {
	margin-top: 12px;
	padding: 8px 16px;
	width: 100%;
	border: none;
	background-color: #007bff;
	color: white;
	font-size: 14px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.room-box button:hover:enabled {
	background-color: #0056b3;
	transform: scale(1.04);
}

.room-box button:disabled {
	background-color: #ccc;
	cursor: not-allowed;
}

@
keyframes fadeInUp {from { transform:translateY(20px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}
.room-box button {
	animation: pulse 1s ease-in-out 0.5s 1;
}

@
keyframes pulse { 0% {
	transform: scale(1);
}
50






%
{
transform






:






scale




(






1




.08






)




;
}
100






%
{
transform






:






scale




(






1






)




;
}
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
				<br />
				<button ${room.roomStatus != 'AVAILABLE' ? 'disabled' : ''}>Book
					Now</button>
			</div>
		</c:forEach>
	</div>
	<c:if test="${not empty sessionScope.loggedInUser}">
		<a href="<%=request.getContextPath()%>/auth/logout"
			class="btn btn-danger btn-sm btn-hover"> <i
			class="bi bi-box-arrow-right"></i> Logout
		</a>
	</c:if>

</body>
</html>