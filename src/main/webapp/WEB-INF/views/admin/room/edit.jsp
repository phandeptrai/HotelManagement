<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/edit-room.css">
</head>
<body>
    <h2 style="text-align:center">Edit Room</h2>

    <form action="${pageContext.request.contextPath}/admin/room/edit" method="post" style="width: 400px; margin: auto">

        <input type="hidden" name="roomID" value="${roomFormDTO.roomID}" />

        <label>Room number:</label>
        <input type="text" name="roomNumber" value="${roomFormDTO.roomNumber}" required />
        <br><br>

        <label>Room Type:</label>
        <select name="roomTypeID">
            <c:forEach var="type" items="${roomTypes}">
                <option value="${type.roomTypeID}" 
                    <c:if test="${type.roomTypeID == roomFormDTO.roomTypeID}">selected</c:if>>
                    ${type.typeName}
                </option>
            </c:forEach>
        </select>
        <br><br>

        <label>Status:</label>
        <select name="roomStatus">
            <c:forEach var="status" items="${statuses}">
                <option value="${status}" 
                    <c:if test="${status == roomFormDTO.roomStatus}">selected</c:if>>
                    ${status}
                </option>
            </c:forEach>
        </select>
        <br><br>

        <label>Price:</label>
        <input type="number" name="price" step="0.01" value="${roomFormDTO.price}" required />
        <br><br>

        <button type="submit">Save</button>
    </form>
</body>
</html>
