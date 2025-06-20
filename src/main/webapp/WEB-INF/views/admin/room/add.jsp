<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Room</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-room-add.css">
</head>
<body>

    <div class="admin-form-card">
        <div class="admin-form-title">Add New Room</div>
        <form action="${pageContext.request.contextPath}/admin/room/add" method="post">
            <div class="form-group">
                <label for="roomNumber" class="form-label">Room Number:</label>
                <input type="text" id="roomNumber" name="roomNumber" class="form-control" required />
            </div>
            <div class="form-group">
                <label for="roomType" class="form-label">Room Type:</label>
                <select id="roomType" name="roomTypeID" class="form-control" required>
                    <c:forEach var="type" items="${roomTypes}">
                        <option value="${type.roomTypeID}">${type.typeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="roomStatus" class="form-label">Status:</label>
                <select id="roomStatus" name="roomStatus" class="form-control" required>
                    <c:forEach var="status" items="${statuses}">
                        <option value="${status}">${status}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="price" class="form-label">Price (VND):</label>
                <input type="number" id="price" name="price" class="form-control" step="500" min="0" required />
            </div>
            <button type="submit" class="btn-primary">Create Room</button>
        </form>
    </div>

</body>
</html>
