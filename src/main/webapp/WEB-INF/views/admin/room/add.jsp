<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Room</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/add-room.css">
</head>
<body>

    <h2 style="text-align: center;">Add New Room</h2>

    <form action="${pageContext.request.contextPath}/admin/room/add" method="post" style="width: 400px; margin: auto;">
        <!-- Room Number -->
        <label for="roomNumber">Room Number:</label>
        <input type="text" id="roomNumber" name="roomNumber" required />
        <br><br>

        <!-- Room Type -->
        <label for="roomType">Room Type:</label>
        <select id="roomType" name="roomTypeID" required>
            <c:forEach var="type" items="${roomTypes}">
                <option value="${type.roomTypeID}">${type.typeName}</option>
            </c:forEach>
        </select>
        <br><br>

        <!-- Room Status -->
        <label for="roomStatus">Status:</label>
        <select id="roomStatus" name="roomStatus" required>
            <c:forEach var="status" items="${statuses}">
                <option value="${status}">${status}</option>
            </c:forEach>
        </select>
        <br><br>

        <!-- Price -->
        <label for="price">Price (VND):</label>
        <input type="number" id="price" name="price" step="500" min="0" required />
        <br><br>

        <!-- Submit Button -->
        <button type="submit">Create Room</button>
    </form>

</body>
</html>
