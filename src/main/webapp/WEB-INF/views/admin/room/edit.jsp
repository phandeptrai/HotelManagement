<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-room-edit.css">
</head>
<body>
    <div class="admin-form-card">
        <div class="admin-form-title">Edit Room</div>
        <form action="${pageContext.request.contextPath}/admin/room/edit" method="post">
            <input type="hidden" name="roomID" value="${roomFormDTO.roomID}" />
            <div class="form-group">
                <label for="roomNumber" class="form-label">Room number:</label>
                <input type="text" id="roomNumber" name="roomNumber" class="form-control" value="${roomFormDTO.roomNumber}" required />
            </div>
            <div class="form-group">
                <label for="roomTypeID" class="form-label">Room Type:</label>
                <select id="roomTypeID" name="roomTypeID" class="form-control">
                    <c:forEach var="type" items="${roomTypes}">
                        <option value="${type.roomTypeID}" 
                            <c:if test="${type.roomTypeID == roomFormDTO.roomTypeID}">selected</c:if>>
                            ${type.typeName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="roomStatus" class="form-label">Status:</label>
                <select id="roomStatus" name="roomStatus" class="form-control">
                    <c:forEach var="status" items="${statuses}">
                        <option value="${status}" 
                            <c:if test="${status == roomFormDTO.roomStatus}">selected</c:if>>
                            ${status}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="price" class="form-label">Price:</label>
                <input type="number" id="price" name="price" class="form-control" step="0.01" value="${roomFormDTO.price}" required />
            </div>
            <button type="submit" class="btn-primary">Save</button>
        </form>
    </div>
</body>
</html>
