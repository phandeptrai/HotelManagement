<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
	<title>Đặt Phòng</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
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
			background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
			min-height: 100vh;
		}

		.booking-container {
			max-width: 1100px;
			margin: 2rem auto;
			padding: 2rem;
			background: white;
			border-radius: 20px;
			box-shadow: 0 10px 30px rgba(0,0,0,0.1);
		}

		.booking-header {
			text-align: center;
			margin-bottom: 2rem;
			padding: 1rem;
			background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
			border-radius: 15px;
			color: white;
		}

		.booking-header h2 {
			margin: 0;
			font-size: 2rem;
			font-weight: 600;
		}

		.booking-header p {
			margin: 0.5rem 0 0;
			opacity: 0.9;
		}

		.form-section {
			background: white;
			padding: 1.5rem;
			border-radius: 15px;
			margin-bottom: 1.5rem;
			border: 1px solid #e3e6f0;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.form-section h4 {
			color: var(--primary-color);
			margin-bottom: 1.5rem;
			padding-bottom: 0.5rem;
			border-bottom: 2px solid var(--primary-color);
			font-size: 1.2rem;
		}

		.form-label {
			font-weight: 500;
			color: var(--dark-color);
			font-size: 0.9rem;
			margin-bottom: 0.3rem;
		}

		.form-control {
			border-radius: 8px;
			padding: 0.5rem 0.75rem;
			border: 1px solid #d1d3e2;
			font-size: 0.9rem;
			height: auto;
		}

		.form-control:focus {
			border-color: var(--primary-color);
			box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.15);
		}

		.error-message {
			color: var(--danger-color);
			font-size: 0.8rem;
			margin-top: 0.25rem;
		}

		.service-table {
			margin-top: 1rem;
			font-size: 0.9rem;
		}

		.service-table th {
			background-color: var(--light-color);
			color: var(--dark-color);
			font-weight: 600;
			padding: 0.75rem;
		}

		.service-table td {
			padding: 0.75rem;
			vertical-align: middle;
		}

		.btn-primary {
			background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
			border: none;
			padding: 0.6rem 2rem;
			font-weight: 500;
			border-radius: 8px;
			font-size: 0.95rem;
			transition: all 0.3s ease;
		}

		.btn-primary:hover {
			transform: translateY(-2px);
			box-shadow: 0 5px 15px rgba(78, 115, 223, 0.3);
		}

		.alert {
			border-radius: 10px;
			margin-bottom: 1.5rem;
			font-size: 0.9rem;
		}

		.alert-danger {
			background-color: #fdf3f2;
			border-color: var(--danger-color);
			color: var(--danger-color);
		}

		.price-display {
			font-size: 1.1rem;
			color: var(--dark-color);
			font-weight: 500;
		}

		.service-checkbox {
			width: 18px;
			height: 18px;
			accent-color: var(--primary-color);
		}

		.quantity-input {
			width: 70px;
			text-align: center;
			padding: 0.3rem;
		}

		.input-group-text {
			background-color: var(--light-color);
			border-color: #d1d3e2;
			color: var(--dark-color);
			font-size: 0.9rem;
		}

		.table-hover tbody tr:hover {
			background-color: rgba(78, 115, 223, 0.05);
		}

		.form-select {
			font-size: 0.9rem;
			padding: 0.5rem 0.75rem;
			height: auto;
		}

		.icon-color {
			color: var(--primary-color);
		}

		.section-icon {
			margin-right: 0.5rem;
			color: var(--primary-color);
		}

		.form-section:nth-child(2) h4 {
			color: var(--secondary-color);
			border-bottom-color: var(--secondary-color);
		}

		.form-section:nth-child(3) h4 {
			color: var(--accent-color);
			border-bottom-color: var(--accent-color);
		}

		.service-card {
			background: white;
			border: 1px solid #e3e6f0;
			border-radius: 10px;
			padding: 1rem;
			height: 100%;
			transition: all 0.3s ease;
		}

		.service-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 5px 15px rgba(0,0,0,0.1);
		}

		.service-header {
			margin-bottom: 1rem;
			padding-bottom: 0.5rem;
			border-bottom: 1px solid #e3e6f0;
		}

		.service-title {
			color: var(--dark-color);
			font-size: 1.1rem;
			margin: 0;
			font-weight: 600;
		}

		.service-price {
			color: var(--primary-color);
			font-weight: 600;
			font-size: 0.9rem;
		}

		.service-body {
			padding: 0.5rem 0;
		}

		.quantity-control {
			margin-top: 1rem;
		}

		.quantity-btn {
			width: 30px;
			height: 30px;
			padding: 0;
			display: flex;
			align-items: center;
			justify-content: center;
			font-size: 1.2rem;
			color: var(--primary-color);
			border-color: #d1d3e2;
		}

		.quantity-btn:hover {
			background-color: var(--primary-color);
			color: white;
		}

		.quantity-input {
			text-align: center;
			border-left: 0;
			border-right: 0;
			width: 60px;
		}

		.price-summary {
			background: var(--light-color);
			padding: 1.5rem;
			border-radius: 10px;
			margin-top: 1rem;
			border: 1px solid #e3e6f0;
		}

		.price-item {
			display: flex;
			justify-content: space-between;
			margin-bottom: 1rem;
			padding-bottom: 0.5rem;
			border-bottom: 1px dashed #d1d3e2;
		}

		.price-item:last-child {
			border-bottom: none;
			margin-bottom: 0;
			padding-bottom: 0;
		}

		.price-item.total {
			font-size: 1.2rem;
			font-weight: 600;
			color: var(--primary-color);
			margin-top: 1rem;
			padding-top: 1rem;
			border-top: 2px solid var(--primary-color);
		}

		.price-value {
			font-weight: 500;
		}
	</style>
</head>
<body>
	<div class="booking-container">
		<div class="booking-header">
			<h2><i class="bi bi-calendar-check"></i> Đặt Phòng Khách Sạn</h2>
			<p class="text-white">Vui lòng điền đầy đủ thông tin để đặt phòng</p>
		</div>

		<c:if test="${not empty message}">
			<div class="alert alert-danger" role="alert">
				<i class="bi bi-exclamation-triangle-fill"></i> ${message}
			</div>
		</c:if>

		<form:form modelAttribute="request" action="${pageContext.request.contextPath}/booking/bookroom" method="post" cssClass="needs-validation">
			<div class="row">
				<!-- Bên trái: Thông tin đặt phòng và dịch vụ -->
				<div class="col-md-7">
					<!-- Thông tin đặt phòng -->
					<div class="form-section">
						<h4><i class="bi bi-info-circle section-icon"></i> Thông tin đặt phòng</h4>
						
						<div class="mb-3">
							<label class="form-label">User ID:</label>
							<form:input path="userId" cssClass="form-control" placeholder="Nhập ID người dùng" />
							<form:errors path="userId" cssClass="error-message" />
						</div>

						<div class="mb-3">
							<label class="form-label">Room ID:</label>
							<form:input path="roomId" cssClass="form-control" placeholder="Nhập ID phòng" />
							<form:errors path="roomId" cssClass="error-message" />
						</div>

						<div class="mb-3">
							<label class="form-label">Ngày nhận phòng:</label>
							<form:input path="checkInDate" type="date" cssClass="form-control" id="checkInDate" onchange="calculateTotalDays()" />
							<form:errors path="checkInDate" cssClass="error-message" />
						</div>

						<div class="mb-3">
							<label class="form-label">Ngày trả phòng:</label>
							<form:input path="checkOutDate" type="date" cssClass="form-control" id="checkOutDate" onchange="calculateTotalDays()" />
							<form:errors path="checkOutDate" cssClass="error-message" />
						</div>

						<div class="mb-3">
							<label class="form-label">Số ngày đặt phòng:</label>
							<input type="text" class="form-control" id="totalDays" readonly />
						</div>
					</div>

					<!-- Dịch vụ đi kèm -->
					<div class="form-section">
						<h4><i class="bi bi-list-check section-icon"></i> Dịch vụ đi kèm</h4>
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>Dịch vụ</th>
										<th>Giá</th>
										<th>Chọn</th>
										<th>Số lượng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${availableServices}" var="service" varStatus="status">
										<tr>
											<td>${service.name}</td>
											<td>${service.price} VNĐ</td>
											<td>
												<div class="form-check">
													<form:checkbox path="selectedServices[${status.index}].selected" 
																 cssClass="form-check-input service-checkbox" 
																 id="service-${status.index}" />
													<form:hidden path="selectedServices[${status.index}].serviceId" 
															   value="${service.id}" />
												</div>
											</td>
											<td>
												<div class="input-group input-group-sm" style="width: 120px;">
													<button type="button" class="btn btn-outline-secondary btn-sm quantity-btn" 
															onclick="decreaseQuantity(${status.index})">-</button>
													<form:input path="selectedServices[${status.index}].quantity" 
															  type="number" min="0" 
															  cssClass="form-control quantity-input" 
															  id="quantity-${status.index}" />
													<button type="button" class="btn btn-outline-secondary btn-sm quantity-btn" 
															onclick="increaseQuantity(${status.index})">+</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- Bên phải: Thông tin thanh toán -->
				<div class="col-md-5">
					<div class="form-section sticky-top" style="top: 20px;">
						<h4><i class="bi bi-credit-card section-icon"></i> Thông tin thanh toán</h4>
						
						<div class="mb-4">
							<label class="form-label">Phương thức thanh toán:</label>
							<form:select path="paymentMethodID" cssClass="form-select">
								<form:option value="0" label="-- Chọn phương thức thanh toán --" />
								<form:options items="${paymentMethods}" itemValue="paymentMethodID" itemLabel="methodName" />
							</form:select>
							<form:errors path="paymentMethodID" cssClass="error-message" />
						</div>

						<div class="price-summary">
							<div class="price-item">
								<span>Giá phòng/ngày:</span>
								<span class="price-value" id="roomPricePerDay">${request.roomPrice != null ? request.roomPrice : 2000000} VNĐ</span>
							</div>
							<div class="price-item">
								<span>Số ngày:</span>
								<span class="price-value" id="displayDays">0 ngày</span>
							</div>
							<div class="price-item">
								<span>Tổng tiền phòng:</span>
								<span class="price-value" id="totalRoomPrice">0 VNĐ</span>
							</div>
							<div class="price-item">
								<span>Dịch vụ đi kèm:</span>
								<span class="price-value" id="services-total">0 VNĐ</span>
							</div>
							<div class="price-item total">
								<span>Tổng cộng:</span>
								<span class="price-value" id="total-price">0 VNĐ</span>
							</div>
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary btn-lg w-100">
								<i class="bi bi-check-circle"></i> Xác nhận đặt phòng
							</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// Lấy giá phòng từ BookingRequest, nếu không có thì dùng giá mặc định
		const ROOM_PRICE_PER_DAY = ${request.roomPrice != null ? request.roomPrice : 2000000};

		function calculateTotalDays() {
			const checkInDate = new Date(document.getElementById('checkInDate').value);
			const checkOutDate = new Date(document.getElementById('checkOutDate').value);
			
			if (checkInDate && checkOutDate && !isNaN(checkInDate) && !isNaN(checkOutDate)) {
				const diffTime = Math.abs(checkOutDate - checkInDate);
				const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
				document.getElementById('totalDays').value = diffDays;
				document.getElementById('displayDays').textContent = diffDays + ' ngày';
				updateTotalPrice();
			}
		}

		function increaseQuantity(index) {
			const input = document.getElementById('quantity-' + index);
			const currentValue = parseInt(input.value) || 0;
			input.value = currentValue + 1;
			updateTotalPrice();
		}

		function decreaseQuantity(index) {
			const input = document.getElementById('quantity-' + index);
			const currentValue = parseInt(input.value) || 0;
			if (currentValue > 0) {
				input.value = currentValue - 1;
				updateTotalPrice();
			}
		}

		function updateTotalPrice() {
			let servicesTotal = 0;
			const checkboxes = document.querySelectorAll('.service-checkbox');
			const rows = document.querySelectorAll('tbody tr');
			
			rows.forEach((row, index) => {
				const checkbox = row.querySelector('.service-checkbox');
				if (checkbox.checked) {
					const quantity = parseInt(document.getElementById('quantity-' + index).value) || 0;
					const priceText = row.querySelector('td:nth-child(2)').textContent;
					const price = parseInt(priceText.replace(/[^0-9]/g, '')) || 0;
					servicesTotal += price * quantity;
				}
			});

			const totalDays = parseInt(document.getElementById('totalDays').value) || 0;
			const totalRoomPrice = ROOM_PRICE_PER_DAY * totalDays;
			const totalPrice = totalRoomPrice + servicesTotal;

			document.getElementById('totalRoomPrice').textContent = totalRoomPrice.toLocaleString() + ' VNĐ';
			document.getElementById('services-total').textContent = servicesTotal.toLocaleString() + ' VNĐ';
			document.getElementById('total-price').textContent = totalPrice.toLocaleString() + ' VNĐ';
		}

		// Add event listeners for checkboxes and quantity inputs
		document.addEventListener('DOMContentLoaded', function() {
			const checkboxes = document.querySelectorAll('.service-checkbox');
			const quantityInputs = document.querySelectorAll('.quantity-input');

			checkboxes.forEach(checkbox => {
				checkbox.addEventListener('change', updateTotalPrice);
			});

			quantityInputs.forEach(input => {
				input.addEventListener('change', updateTotalPrice);
				input.addEventListener('input', updateTotalPrice);
			});

			// Initial calculation
			calculateTotalDays();
			updateTotalPrice();
		});
	</script>
</body>
</html>
