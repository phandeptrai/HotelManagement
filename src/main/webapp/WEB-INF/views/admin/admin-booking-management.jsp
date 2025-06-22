<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/components/admin-sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Booking Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-sidebar.css">
    <style>
        .status-badge.CONFIRMED { background: #d4edda; color: #155724; }
        .status-badge.PENDING { background: #fff3cd; color: #856404; }
        .status-badge.CANCELLED { background: #f8d7da; color: #721c24; }
        
        .booking-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 40px;
            margin: 0 auto;
            border: 1.5px solid #e3e6f0;
        }
        
        .booking-title {
            font-size: 1.7rem;
            font-weight: 700;
            color: #4e73df;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .table th {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            color: #fff;
            font-weight: 600;
            border: none;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.2s;
        }
        
        .btn:hover {
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
<div class="admin-content">
    <div class="booking-card">
        <h2 class="booking-title">
            <i class="bi bi-calendar-check"></i> Booking Management
        </h2>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Phòng</th>
                        <th>Khách hàng</th>
                        <th>Nhận phòng</th>
                        <th>Trả phòng</th>
                        <th>Trạng thái</th>
                        <th>Tổng tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${bookings}" var="booking" varStatus="stt">
                    <tr>
                        <td>${booking.bookingId}</td>
                        <td>${booking.roomNumber}</td>
                        <td>${booking.customerName}</td>
                        <td>${booking.checkInDate}</td>
                        <td>${booking.checkOutDate}</td>
                        <td><span class="status-badge ${booking.bookingStatus}">${booking.bookingStatus}</span></td>
                        <td><fmt:formatNumber value="${booking.totalAmount}" pattern="#,#00" /> VNĐ</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/booking/detail/${booking.bookingId}" class="btn btn-outline-secondary btn-sm mb-1">
                                <i class="bi bi-eye"></i> Xem
                            </a>
                            <c:if test="${booking.bookingStatus == 'PENDING'}">
                                <form action="${pageContext.request.contextPath}/booking/confirm" method="post" style="display:inline-block;">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                    <button type="submit" class="btn btn-success btn-sm mb-1">
                                        <i class="bi bi-check-circle"></i> Duyệt
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${booking.bookingStatus != 'CANCELLED'}">
                                <form action="${pageContext.request.contextPath}/booking/cancel" method="post" style="display:inline-block;">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                    <input type="hidden" name="userId" value="${booking.userId}" />
                                    <input type="hidden" name="cancelReason" value="Hủy bởi admin" />
                                    <button type="submit" class="btn btn-danger btn-sm mb-1">
                                        <i class="bi bi-x-circle"></i> Hủy
                                    </button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html> 