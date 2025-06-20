<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Phòng - Hotel Management</title>
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

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            font-weight: 400;
            letter-spacing: -0.025em;
        }

        .details-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
        }

        .details-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: slideInUp 0.6s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .details-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .details-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .details-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
        }

        .room-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        .details-body {
            padding: 2.5rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #e3e6f0;
            transition: all 0.3s ease;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-item:hover {
            background-color: var(--light-color);
            border-radius: 10px;
            padding-left: 1rem;
            padding-right: 1rem;
            margin-left: -1rem;
            margin-right: -1rem;
        }

        .detail-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--secondary-color) 0%, #17a673 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            margin-right: 1.5rem;
            flex-shrink: 0;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-size: 0.9rem;
            color: var(--dark-color);
            font-weight: 500;
            margin-bottom: 0.25rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-color);
            margin: 0;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-available {
            background-color: #f0f9f4;
            color: var(--secondary-color);
            border: 2px solid var(--secondary-color);
        }

        .status-occupied {
            background-color: #fdf3f2;
            color: var(--danger-color);
            border: 2px solid var(--danger-color);
        }

        .status-maintenance {
            background-color: #fff8e6;
            color: var(--accent-color);
            border: 2px solid var(--accent-color);
        }

        .price-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--secondary-color);
        }

        .action-buttons {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e3e6f0;
        }

        .btn-back {
            background: linear-gradient(135deg, var(--dark-color) 0%, #4a4b53 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(90, 92, 105, 0.3);
            color: white;
        }

        .btn-book {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #17a673 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-left: 1rem;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(28, 200, 138, 0.3);
            color: white;
        }

        @media (max-width: 768px) {
            .details-container {
                margin: 1rem;
                padding: 1rem;
            }
            
            .details-header h1 {
                font-size: 2rem;
            }
            
            .detail-item {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .detail-icon {
                margin-right: 0;
            }
            
            .action-buttons {
                text-align: center;
            }
            
            .btn-book {
                margin-left: 0;
                margin-top: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="details-container">
        <div class="details-card">
            <div class="details-header">
                <i class="bi bi-building room-icon"></i>
                <h1>Phòng ${room.roomNumber}</h1>
                <p>Thông tin chi tiết về phòng</p>
            </div>
            
            <div class="details-body">
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-door-open"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Số phòng</div>
                        <div class="detail-value">${room.roomNumber}</div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-house"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Loại phòng</div>
                        <div class="detail-value">${room.roomType.typeName}</div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-currency-dollar"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Giá phòng</div>
                        <div class="price-value">
                            <fmt:formatNumber value="${room.price}" type="number" pattern="#,###" /> VND
                        </div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="bi bi-info-circle"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Trạng thái</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${room.roomStatus == 'AVAILABLE'}">
                                    <span class="status-badge status-available">
                                        <i class="bi bi-check-circle-fill"></i> Có sẵn
                                    </span>
                                </c:when>
                                <c:when test="${room.roomStatus == 'OCCUPIED'}">
                                    <span class="status-badge status-occupied">
                                        <i class="bi bi-x-circle-fill"></i> Đã thuê
                                    </span>
                                </c:when>
                                <c:when test="${room.roomStatus == 'MAINTENANCE'}">
                                    <span class="status-badge status-maintenance">
                                        <i class="bi bi-tools"></i> Bảo trì
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-available">
                                        <i class="bi bi-question-circle-fill"></i> ${room.roomStatus}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/rooms" class="btn-back">
                        <i class="bi bi-arrow-left"></i> Quay lại danh sách phòng
                    </a>
                    
                    <c:if test="${room.roomStatus == 'AVAILABLE'}">
                        <a href="${pageContext.request.contextPath}/booking/getform?roomId=${room.id}&roomPrice=${room.price}" class="btn-book">
                            <i class="bi bi-calendar-check"></i> Đặt phòng ngay
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
