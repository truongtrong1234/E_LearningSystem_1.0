<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Courses</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
        <style>
            .category-wrap {
                background: #f8f9fa;
                padding: 10px 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .category-bar a {
                margin-right: 15px;
                text-decoration: none;
                color: #007bff;
                font-weight: 500;
            }
            .category-bar a:hover {
                text-decoration: underline;
            }
            .course-img {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
                <li><a href="adminIndex">Dashboard</a></li>
                <li><a href="manageAccount">Manage Accounts</a></li>
                <li><a href="manageCourse">Manage Courses</a></li>
                <li><a href="manageReport">User Reports</a></li>

                <div class="logout-btn mt-4">
                    <a href="../logout" style="text-decoration: none;">Logout</a>
                </div>
            </ul>      
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Courses</h1>

            <!-- Category Header -->
            <div class="category-wrap mb-4">
                <div class="category-bar d-flex flex-wrap gap-3">
                    <c:forEach var="cat" items="${listOfCategories}">
                        <a href="manageCourse?cats=${cat.cate_id}" 
                           class="btn btn-outline-primary btn-sm">
                            ${cat.cate_name}
                        </a>
                    </c:forEach>
                </div>
            </div>


            <table class="table table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Class</th>
                        <th>Price</th>
                        <th>Instructor</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${listCourse}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/assets/images/${c.thumbnail}" 
                                     alt="${c.title}" style="width:80px; height:50px; object-fit:cover; border-radius:8px;">
                            </td>
                            <td>${c.title}</td>
                            <td>${c.categoryName}</td>
                            <td>${c.courseclass}</td>
                            <td>$${c.price}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/instructorDetail?id=${c.instructorID}">
                                    ${c.instructorName}
                                </a>
                            </td>
                            <td>
                                <a href="editCourse?id=${c.courseID}" class="btn btn-warning btn-sm">Edit</a>
                                <a href="deleteCourse?id=${c.courseID}" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete this course?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </body>
</html>
