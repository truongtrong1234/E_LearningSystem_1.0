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
        <jsp:include page="/components/panelAdmin.jsp"/>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Courses</h1>

            <!--             Category Header 
                        <div class="category-wrap mb-4">
                            <div class="category-bar d-flex flex-wrap gap-3">
            <c:forEach var="cat" items="${listOfCategories}">
                <a href="manageCourse?cats=${cat.cate_id}" 
                   class="btn btn-outline-primary btn-sm">
                ${cat.cate_name}
            </a>
            </c:forEach>
        </div>
    </div>-->
            <!-- Category & Instructor Filter -->
            <div class="category-wrap mb-4">
                <form class="row g-2 align-items-center" method="get" action="manageCourse">
                    <!-- Category -->
                    <div class="col-md-3">
                        <select name="cats" class="form-select">
                            <option value="">All Categories</option>
                            <c:forEach var="cat" items="${listOfCategories}">
                                <option value="${cat.cate_id}" 
                                        ${param.cats == cat.cate_id ? 'selected' : ''}>
                                    ${cat.cate_name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Instructor -->
                    <div class="col-md-3">
                        <select name="instructor" class="form-select">
                            <option value="">All Instructors</option>
                            <c:forEach var="ins" items="${listOfInstructors}">
                                <option value="${ins.instructorID}" 
                                        ${param.instructor == ins.instructorID ? 'selected' : ''}>
                                    ${ins.instructorName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Search -->
                    <div class="col-md-4">
                        <input type="text" name="search" class="form-control" 
                               placeholder="Search by course or instructor"
                               value="${param.search}">
                    </div>

                    <!-- Submit -->
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Filter</button>
                    </div>
                </form>
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
                                <a href="${pageContext.request.contextPath}/admin/viewCourseDetail?id=${c.courseID}" 
                                   class="btn btn-info btn-sm">View</a>

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
