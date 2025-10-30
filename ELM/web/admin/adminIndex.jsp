<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="context.DBContext" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
                <li><a href="adminIndex">Dashboard</a></li>
                <li><a href="manageAccount">Manage Accounts</a></li>
                <li><a href="manageCourse.jsp">Manage Courses</a></li>
                <li><a href="manageReport.jsp">User Reports</a></li>
            </ul>
            <div class="logout-btn">
                <a href="../logout" style="text-decoration: none">Logout</a>
            </div>
        </div>

<!--        <div class="main-content">
            <h1>Admin Dashboard</h1>
            <div class="card orange">
                <h3>User Accounts</h3>
                <p>${userCount}</p>
            </div>

            <div class="card orange">
                <h3>Courses</h3>
                <p>${courseCount}</p>
            </div>

            <div class="card orange">
                <h3>Feedback</h3>
                <p>${feedbackCount}</p>
            </div>

        </div>-->
    <div class="main-content">
        <h1>Admin Dashboard</h1>
        <div class="dashboard-cards d-flex gap-4">

            <!-- User Accounts Card -->
            <a href="manageAccount" class="text-decoration-none text-dark" style="flex:1;">
                <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                    <h3>User Accounts</h3>
                    <p>${userCount}</p>
                </div>
            </a>

            <!-- Courses Card -->
            <a href="manageCourse.jsp" class="text-decoration-none text-dark" style="flex:1;">
                <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                    <h3>Courses</h3>
                    <p>${courseCount}</p>
                </div>
            </a>

            <!-- Feedback Card (dùng sau này) -->
            <a href="manageReport.jsp" class="text-decoration-none text-dark" style="flex:1;">
                <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                    <h3>Feedback</h3>
                    <p>${feedbackCount}</p>
                </div>
            </a>

        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
    </body>
</html>
