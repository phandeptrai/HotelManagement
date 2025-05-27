<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Đặt Phòng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
</head>
<body class="container py-5">

	<h2 class="mb-4">Đặt phòng</h2>

	<form:form modelAttribute="request"
		action="${pageContext.request.contextPath}/booking/action"
		method="post" cssClass="needs-validation">
		<input type="hidden" name="action" value="book" />

		<div class="mb-3">
			<label class="form-label">User ID:</label>
			<form:input path="userId" cssClass="form-control" />
			<form:errors path="userId" cssClass="text-danger" />
		</div>

		<div class="mb-3">
			<label class="form-label">Room ID:</label>
			<form:input path="roomId" cssClass="form-control" />
			<form:errors path="roomId" cssClass="text-danger" />
		</div>

		<div class="mb-3">
			<label class="form-label">Ngày nhận phòng:</label>
			<form:input path="checkInDate" type="date" cssClass="form-control" />
			<form:errors path="checkInDate" cssClass="text-danger" />
		</div>

		<div class="mb-3">
			<label class="form-label">Ngày trả phòng:</label>
			<form:input path="checkOutDate" type="date" cssClass="form-control" />
			<form:errors path="checkOutDate" cssClass="text-danger" />
		</div>

		<div class="mb-3">
			<label class="form-label">Phương thức thanh toán:</label>
			<form:select path="paymentMethodID" cssClass="form-select">
				<form:option value="0" label="-- Chọn phương thức --" />
				<form:option value="1" label="VNPay" />
				<form:option value="2" label="Tiền mặt" />
			</form:select>
			<form:errors path="paymentMethodID" cssClass="text-danger" />
		</div>

		<h4>Dịch vụ bổ sung:</h4>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Chọn</th>
					<th>Tên dịch vụ</th>
					<th>Giá</th>
					<th>Số lượng</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="service" items="${availableServices}"
					varStatus="status">
					<tr>
						<td><input type="checkbox"
							name="selectedServices[${status.index}].selected" value="true" />
							<input type="hidden"
							name="selectedServices[${status.index}].serviceId"
							value="${service.id}" /></td>
						<td>${service.name}</td>
						<td>${service.price}VND</td>
						<td><input type="number"
							name="selectedServices[${status.index}].quantity" value="1"
							min="1" class="form-control" /></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

		<button type="submit" class="btn btn-primary">Đặt phòng</button>
	</form:form>

	<c:if test="${not empty message}">
		<div class="alert alert-info mt-3">${message}</div>
	</c:if>

</body>
</html>
