<div class="sidebar">
	<h3>Admin Panel</h3>
	<ul>
		<li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-graph-up"></i> Dashboard</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/statistics"><i class="bi bi-bar-chart"></i> Detail Statistic</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/realtime-stats"><i class="bi bi-activity"></i> Real-time Stats</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/roommanagement"><i class="bi bi-house-door"></i> Manage Rooms</a></li>
		<li><a href="${pageContext.request.contextPath}/booking/admin-management"><i class="bi bi-calendar-check"></i> Manage Bookings</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/user/usermanagement"><i class="bi bi-people"></i> Manage Users</a></li>
		<li>
			<a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn">
				<i class="bi bi-box-arrow-right"></i> Logout
			</a>
		</li>
	</ul>
</div>

<style>
.sidebar {
	background-color: #2c3e50;
	color: white;
	padding: 15px;
	width: 200px;
	height: 100vh;
	position: fixed;
}

.sidebar h3 {
	margin-bottom: 20px;
}

.sidebar ul {
	list-style-type: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 15px;
}

.sidebar ul li a {
	color: white;
	text-decoration: none;
	display: block;
	padding: 8px;
	border-radius: 4px;
	transition: background-color 0.2s;
}

.sidebar ul li a:hover {
	background-color: #34495e;
}

.sidebar ul li a i {
	margin-right: 8px;
}

.logout-btn {
	background-color: #e74c3c;
	color: white;
	display: block;
	text-align: center;
	padding: 8px;
	border-radius: 5px;
	text-decoration: none;
	margin-top: 20px;
}

.logout-btn:hover {
	background-color: #c0392b;
}
</style>
