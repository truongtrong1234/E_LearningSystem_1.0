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
        <jsp:include page="/components/panelAdmin.jsp"/>
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
                <a href="manageCourse" class="text-decoration-none text-dark" style="flex:1;">
                    <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                        <h3>Courses</h3>
                        <p>${courseCount}</p>
                    </div>
                </a>

                <!-- Reports Card -->
                <a href="manageReport" class="text-decoration-none text-dark" style="flex:1;">
                    <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                        <h3>User Reports</h3>
                        <p>${reportCount}</p>
                    </div>
                </a>
                    
                    <a href="manageRequest" class="text-decoration-none text-dark" style="flex:1;">
                    <div class="card orange text-center p-4 shadow-sm" style="cursor:pointer;">
                        <h3>Instructor Requests</h3>
                        <p>${requestCount}</p>
                    </div>
                </a>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
    </body>
</html>
