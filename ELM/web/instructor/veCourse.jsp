<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%-->
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>View and Edit Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/veCQ.css">
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-orange">Course Information </h2>
            <button id="editToggleBtn" class="btn btn-warning text-white fw-semibold px-4">Edit</button>
        </div>

        <form id="courseForm" action="${pageContext.request.contextPath}/instructor/editCourse" method="post" enctype="multipart/form-data">
            <input type="hidden" name="thisCourseID" value=${course.courseID}>
            <div class="card mb-4 p-4 shadow-sm border-0">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Course Title</label>
                        <input type="text" class="form-control editable-field" name="title"
                               value="${course.title}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Category</label>
                        <select id="categorySelect" name="categoryID" class="form-control editable-field" required="">
                                    <option value="" disabled selected>${course.categoryName}</option>
                                    <c:forEach var="c" items="${categoryList}">
                                        <option value="${c.cate_id}">${c.cate_name}</option>
                                    </c:forEach>
                                </select>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Description</label>
                        <textarea class="form-control editable-field" rows="4"
                                  name="description" readonly>${course.description}</textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Class</label>
                        <select class="form-select editable-field" name="className" disabled>
                            <option value="10" <c:if test="${course.courseclass eq '10'}">selected</c:if>>10</option>
                            <option value="11" <c:if test="${course.courseclass eq '11'}">selected</c:if>>11</option>
                            <option value="12" <c:if test="${course.courseclass eq '12'}">selected</c:if>>12</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Price (₫)</label>
                        <input type="number" class="form-control editable-field" step="1000" min="0"
                               name="price" value="${course.price}" readonly>
                    </div> 
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Thumbnail</label>
                        <input type="file" id="thumbnail" name="thumbnail" class="form-control editable-field" readonly>
                    </div>
                     <div class="col-md-4">
                        <label class="form-label fw-semibold">My Thumbnail:</label>
                        <img src="${course.thumbnail}"/>
                    </div>
                </div>
                <div class="text-end mt-4">
                    <a href="createChapter?courseID=${course.courseID}" class="btn btn-sm btn-orange me-2">
                        Edit Chapter
                    </a>
                    <a href="dashboard" class="btn btn-sm btn-orange me-2">
                        Cancel View/Edit Course
                    </a>
                    <button type="submit" id="saveBtn" class="btn btn-success fw-semibold d-none">
                        Save
                    </button>
                </div>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/veCQ.js"></script>
</body>
</html>
