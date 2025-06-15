<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            padding: 30px;
        }
        .details-box {
            background: white;
            padding: 30px;
            max-width: 600px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .details-box h2 {
            color: #333;
        }
        .details-box p {
            font-size: 16px;
            margin: 10px 0;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="details-box">
        <h2>Room ${room.roomNumber}</h2>
        <p><strong>Type:</strong> ${room.roomType.typeName}</p>
        <p><strong>Price:</strong> ${room.price} VND</p>
        <p><strong>Status:</strong> ${room.roomStatus}</p>
        <br/>
        <a href="${pageContext.request.contextPath}/rooms">← Back to Rooms</a>
    </div>

</body>
</html>
