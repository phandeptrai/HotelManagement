<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lịch sử đặt phòng</title>
</head>
<body>
<h2>Lịch sử đặt phòng</h2>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Mã đặt phòng</th>
        <th>Phòng</th>
        <th>Ngày nhận</th>
        <th>Ngày trả</th>
        <th>Trạng thái</th>
        <th>Tổng tiền</th>
        <th>Thời gian đặt</th>
        <th>Thao tác</th>
    </tr>
    <c:forEach items="${bookings}" var="booking">
        <tr>
            <td>${booking.bookingId}</td>
            <td>${booking.roomNumber}</td>
            <td>${booking.checkInDate}</td>
            <td>${booking.checkOutDate}</td>
            <td>${booking.bookingStatus}</td>
            <td>${booking.totalAmount}</td>
            <td>${booking.createdAt}</td>
            <td>
                <c:if test="${booking.bookingStatus != 'CANCELLED'}">
                    <form action="${pageContext.request.contextPath}/bookings/cancel" method="post">
                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                        <input type="hidden" name="userId" value="${userId}" />
                        <input type="text" name="cancelReason" placeholder="Lý do hủy" required />
                        <input type="hidden" name="cancelTime" value="<%= java.time.LocalDateTime.now() %>" />
                        <input type="submit" value="Hủy phòng" />
                    </form>
                </c:if>
                <c:if test="${booking.bookingStatus == 'CANCELLED'}">
                    <i>Đã hủy lúc ${booking.cancelledAt}</i>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
