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

        <form id="courseForm" action="${pageContext.request.contextPath}/veCourse" method="post">
            <input type="hidden" name="courseID" value="${course.courseID}">
            <div class="card mb-4 p-4 shadow-sm border-0">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Course Title</label>
                        <input type="text" class="form-control editable-field" name="title"
                               value="${course.title}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Category</label>
                        <input type="text" class="form-control editable-field" name="categoryName"
                               value="${course.categoryName}" readonly>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Description</label>
                        <textarea class="form-control editable-field" rows="4"
                                  name="description" readonly>${course.description}</textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Class</label>
                        <select class="form-select editable-field" name="className" disabled>
                            <option value="10" <c:if test="${course.className eq '10'}">selected</c:if>>10</option>
                            <option value="11" <c:if test="${course.className eq '11'}">selected</c:if>>11</option>
                            <option value="12" <c:if test="${course.className eq '12'}">selected</c:if>>12</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Price (₫)</label>
                        <input type="number" class="form-control editable-field" step="1000" min="0"
                               name="price" value="${course.price}" readonly>
                    </div>
                </div>
                <div class="text-end mt-4">
                    <a href="createChapter?courseID=${course.courseID}" class="btn btn-sm btn-orange me-2">
                        + Add Chapter
                    </a>
                    <button type="submit" id="saveBtn" class="btn btn-success fw-semibold d-none">
                        Save
                    </button>
                </div>
            </div>
        </form>

        <c:choose>
            <c:when test="${not empty course.chapters}">
                <div class="accordion" id="chapterAccordion">
                    <c:forEach var="chapter" items="${course.chapters}">
                        <div class="accordion-item mb-3 shadow-sm rounded-3">
                            <h2 class="accordion-header" id="heading${chapter.chapterID}">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapse${chapter.chapterID}" aria-expanded="false">
                                    <strong>Chapter ${chapter.chapterID}: ${chapter.title}</strong>
                                </button>
                            </h2>
                            <div id="collapse${chapter.chapterID}" class="accordion-collapse collapse"
                                 data-bs-parent="#chapterAccordion">
                                <div class="accordion-body">
                                    <ul class="list-group mb-3">
                                        <c:forEach var="lesson" items="${chapter.lessons}">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <span>${lesson.title}</span>
                                                <div>
                                                    <a href="editLesson?id=${lesson.lessonID}" class="btn btn-sm btn-outline-secondary me-2">Edit</a>
                                                    <a href="deleteLesson?id=${lesson.lessonID}" class="btn btn-sm btn-outline-danger">Delete</a>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <a href="createLesson?chapterID=${chapter.chapterID}" class="btn btn-sm btn-success">
                                        + Add Lesson
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">This course does not have any chapters yet.</div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/veCQ.js"></script>
</body>
</html>
