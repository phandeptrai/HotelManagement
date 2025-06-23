<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Đặt Phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --accent-color: #f6c23e;
            --danger-color: #e74a3b;
            --dark-color: #5a5c69;
            --light-color: #f8f9fc;
        }
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-weight: 600;
            font-size: 1.4rem;
            letter-spacing: -0.5px;
        }
        .navbar-nav .nav-link {
            color: white !important;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            letter-spacing: 0.2px;
        }
        .navbar-nav .nav-link:hover {
            color: rgba(255, 255, 255, 0.9) !important;
            transform: translateY(-1px);
        }
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .container { max-width: 1100px; margin: 2rem auto; padding-left: 2rem; padding-right: 2rem; }
        .card { border-radius: 18px; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .card-header { background: linear-gradient(135deg, #4e73df 0%, #224abe 100%); color: white; border-radius: 18px 18px 0 0; }
        .section-title { font-size: 1.2rem; font-weight: 600; color: #4e73df; margin-top: 2rem; }
        .table-services th, .table-services td { vertical-align: middle; }
        .badge-status { font-size: 1rem; padding: 0.5em 1em; border-radius: 1em; }
        .badge-CONFIRMED { background: #d4edda; color: #155724; }
        .badge-CANCELLED { background: #f8d7da; color: #721c24; }
        .badge-PENDING { background: #fff3cd; color: #856404; }
    </style>
</head>
<body>
    <jsp:include page="components/header.jsp" />
    <div class="page-header text-center" style="background: white; padding: 2rem 0; margin-bottom: 2rem; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08);">
        <h1 class="page-title" style="color: var(--primary-color); font-size: 2.5rem; font-weight: 700; margin-bottom: 0.5rem;">
            <i class="bi bi-receipt"></i> Chi Tiết Lịch Sử Đặt Phòng
        </h1>
        <p class="page-subtitle" style="color: var(--dark-color); opacity: 0.8; font-size: 1.1rem;">Xem thông tin chi tiết về đơn đặt phòng của bạn</p>
    </div>
    <div class="container">
        <div class="card mt-4">
            <div class="card-header text-center">
                <h2><i class="bi bi-receipt"></i> Chi Tiết Lịch Sử Đặt Phòng #${booking.bookingId}</h2>
                <div>Ngày đặt: <c:out value="${booking.createdAt}"/></div>
            </div>
            <div class="card-body">
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">Số phòng:</label>
                    <div class="col-sm-8 fw-bold">${booking.roomNumber}</div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">Nhận phòng:</label>
                    <div class="col-sm-8">${booking.checkInDate}</div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">Trả phòng:</label>
                    <div class="col-sm-8">${booking.checkOutDate}</div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">Trạng thái:</label>
                    <div class="col-sm-8">
                        <span class="badge badge-${booking.bookingStatus}">${booking.bookingStatus}</span>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">Tổng tiền:</label>
                    <div class="col-sm-8 fw-bold text-primary">
                        <fmt:formatNumber value="${booking.totalAmount}" pattern="#,#00" /> VNĐ
                    </div>
                </div>
                <c:if test="${booking.bookingStatus == 'CANCELLED'}">
                    <div class="alert alert-danger">
                        <i class="bi bi-x-circle"></i> Đã hủy lúc <c:out value="${booking.cancelledAt}"/>
                        <c:if test="${not empty booking.cancelReason}">
                            <br/><small>Lý do: ${booking.cancelReason}</small>
                        </c:if>
                    </div>
                </c:if>
                <h4 class="section-title"><i class="bi bi-list-check"></i> Dịch vụ đã đặt</h4>
                <c:choose>
                    <c:when test="${not empty booking.services}">
                        <table class="table table-bordered table-services mt-2">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Giá</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="service" items="${booking.services}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${service.name}</td>
                                        <td><fmt:formatNumber value="${service.price}" pattern="#,#00" /> VNĐ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="text-muted">Không có dịch vụ nào được đặt kèm.</div>
                    </c:otherwise>
                </c:choose>
                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/booking/history" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Quay lại lịch sử đặt phòng
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 