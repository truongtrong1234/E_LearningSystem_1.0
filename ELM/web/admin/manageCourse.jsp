<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    
<head>
    <meta charset="UTF-8">
    <title>Manage Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex">Dashboard</a></li>
            <li><a href="manageAccount" >Manage Accounts</a></li>
            <li><a href="manageCourse.jsp">Manage Courses</a></li>
            <li><a href="manageReport.jsp">User Reports</a></li>
        </ul>
        <div class="logout-btn">
            <a href="../logout" style="text-decoration: none">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Manage Courses</h1>
        <table class="table data-table table-bordered align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Level</th>
                    <th>Language</th>
                    <th>Price</th>
                    <th>Instructor</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${listCourse}">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.title}</td>
                        <td>${c.category}</td>
                        <td>${c.level}</td>
                        <td>${c.language}</td>
                        <td>$${c.price}</td>
                        <td>${c.instructorName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${c.active}">Active</c:when>
                                <c:otherwise>Inactive</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="action-btn edit-btn" href="editCourse?id=${c.id}">Edit</a>
                            <a class="action-btn delete-btn" href="deleteCourse?id=${c.id}" 
                               onclick="return confirm('Bạn có chắc muốn xóa khóa học này không?')">Delete</a>
                            <a class="action-btn role-btn" href="deleteCourseRole?id=${c.id}">Delete Role</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
