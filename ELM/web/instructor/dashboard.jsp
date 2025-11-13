<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang tổng quan</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/materialList.css">
    </head>
    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar d-flex flex-column" id="sidebar">
                <div class="sidebar-header p-3 text-white fs-4 fw-bold">
                    <span class="logo-icon">E</span>
                </div>
                <ul class="nav nav-pills flex-column mb-auto">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/instructor/dashboard" 
                           class="nav-link text-white sidebar-link
                           ${activeTab == null 
                             || activeTab == 'courses-content' ? 'active' : '' 
                             || activeTab == 'quiz-content' ? 'active' : ''
                             || activeTab == 'material-content' ? 'active' : ''}">
                            <i class="fas fa-tachometer-alt me-2"></i> Tổng quan
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-chart-bar me-2"></i> Phân tích
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/sendReport" class="nav-link text-white sidebar-link">
                            <i class="fas fa-question-circle me-2"></i> Hỗ trợ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content flex-grow-1 p-0">
                <!-- Navbar Header -->
                <jsp:include page="header.jsp"/>

                <div class="container-fluid p-4">
                    <!-- Tabs -->
                    <ul class="nav nav-tabs custom-tabs mb-4">
                        <li class="nav-item">
                            <a class="nav-link ${activeTab == null || activeTab == 'courses-content' ? 'active' : ''}" 
                               data-tab="courses-content" href="${pageContext.request.contextPath}/instructor/dashboard">
                                Khoá học
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${activeTab == 'quiz-content' ? 'active' : ''}" 
                               data-tab="quiz-content" href="${pageContext.request.contextPath}/instructor/quizList">
                                Bài kiểm tra
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${activeTab == 'material-content' ? 'active' : ''}"
                               data-tab="material-content" href="${pageContext.request.contextPath}/instructor/MaterialListController?activeTab=material-content">
                                Tài liệu
                            </a>
                        </li>
                    </ul>
                    <c:choose>
                        <c:when test="${empty actionCourse}">
                            <jsp:include page="manageCourse.jsp"/>
                        </c:when>
                        <c:when test="${actionCourse eq 'createCourse'}">
                            <div class="card shadow-sm p-4 mt-4">
                                <form id="courseForm" action="createCourse" method="post" enctype="multipart/form-data">
                                    <h5 class="mb-3">Thông tin cơ bản</h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="courseTitle" class="form-label">Tiêu đề khoá học *</label>
                                            <input type="text" id="courseTitle" name="courseTitle" class="form-control" placeholder="Enter course title" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Danh mục (Môn học) *</label>
                                            <select id="categorySelect" name="categoryID" class="form-select" required>
                                                <option value="" disabled selected>-- Select Category --</option>
                                                <c:forEach var="c" items="${categoryList}">
                                                    <option value="${c.cate_id}">${c.cate_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả</label>
                                        <textarea id="description" name="description" class="form-control" rows="3"></textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Khối *</label>
                                            <select id="class" name="class" class="form-select" required>
                                                <option value="">-- Chọn khối --</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label">Giá (đ) *</label>
                                            <input type="number" id="price" name="price" class="form-control" step="1000" min="10000" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Ảnh bìa</label>
                                        <input type="file" id="thumbnail" name="thumbnail" class="form-control">
                                    </div>

                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <strong>Lỗi:</strong> ${errorMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    </c:if>

                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark">
                                            <i class="fas fa-home"></i>
                                        </a>
                                        <button type="submit" class="btn create-cqm-btn">Tiếp theo</button>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                        <c:when test="${actionCourse eq 'createChapter'}">
                            <div class="container my-5">
                                <div class="card shadow-sm p-4">
                                    <form action="createChapter" method="post" class="d-flex mb-4">
                                        <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                        <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Nhập tiêu đề chương..." required>
                                        <button type="submit" class="btn create-cqm-btn">+ Thêm chương </button>                  
                                    </form>
                                    <!-- Danh sách chương -->
                                    <div id="chapterList">
                                        <c:if test="${empty chapters}">
                                            <p class="text-muted">Chưa có chương nào. Hãy tạo một cái ở trên!</p>
                                        </c:if>

                                        <c:forEach var="ch" items="${chapters}">
                                            <div class="card mb-3">
                                                <!-- Dòng hiển thị tiêu đề và nút chức năng -->
                                                <div class="card-body d-flex justify-content-between align-items-center">
                                                    <!-- Tiêu đề -->
                                                    <span><strong>${ch.title}</strong></span>

                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=createLesson&courseID=${thisCourseID}&ChapterID=${ch.chapterID}" 
                                                           class="btn btn-outline-success btn-sm me-2">
                                                            Tạo bài giảng
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/instructor/createQuiz?ChapterID=${ch.chapterID}" 
                                                           class="btn btn-outline-warning btn-sm me-2">
                                                            Tạo bài kiểm tra
                                                        </a>

                                                        <form action="createChapter" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="chapterID" value="${ch.chapterID}">
                                                            <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                                            <button type="submit" class="btn btn-danger btn-sm">Xoá chương</button>
                                                        </form>
                                                    </div>
                                                </div>

                                                <!-- Form edit nằm riêng bên dưới -->
                                                <div class="card-body border-top">
                                                    <form action="createChapter" method="post" class="d-flex gap-2 align-items-center">
                                                        <input type="text" name="title" placeholder="Bạn có thể nhập lại nếu muốn" class="form-control" required>
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="chapterID" value="${ch.chapterID}">
                                                        <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                                        <button type="submit" class="btn btn-success btn-sm">Lưu</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- Button -->
                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark"><i class="fas fa-home"></i></a>
                                        <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=editCourse&id=${thisCourseID}" class="btn btn-secondary">Quay lại</a>
                                    </div> 
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${actionCourse eq 'createLesson'}"> 
                            <div class="container my-5">
                                <form action="createLesson" method="post" class="d-flex mb-4">
                                    <input type="hidden" name="thisCourseID" value="${courseID}">
                                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Nhập tiêu đề bài giảng..." required>
                                    <button type="submit" class="btn create-cqm-btn">+ Thêm bài giảng</button>
                                </form>

                                <div id="lessonList">
                                    <c:if test="${empty Lessons}">
                                        <p class="text-muted">Chưa có bài giảng nào. Hãy tạo một cái ở trên!</p>
                                    </c:if>
                                    <c:forEach var="ch" items="${Lessons}">
                                        <div class="card mb-3">

                                            <div class="card-body d-flex justify-content-between align-items-center">
                                                <!-- Tiêu đề -->
                                                <span><strong>${ch.title}</strong></span>
                                                <div>
                                                    <!-- Upload material -->
                                                    <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=uploadMaterial&CourseID=${courseID}&ChapterID=${thischapterID}&LessonID=${ch.lessonID}" class="btn btn-outline-success btn-sm me-2">
                                                        Tải tài liệu
                                                    </a>

                                                    <!-- Delete lesson -->
                                                    <form action="createLesson" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="thisCourseID" value="${courseID}">
                                                        <input type="hidden" name="lessonID" value="${ch.lessonID}">
                                                        <input type="hidden" name="thischapterID" value="${thischapterID}">
                                                        <button type="submit" class="btn btn-danger btn-sm">Xoá bài giảng</button>
                                                    </form>
                                                </div>
                                            </div>

                                            <!-- Form edit lesson -->
                                            <div class="card-body border-top">
                                                <form action="createLesson" method="post" class="d-flex gap-2 align-items-center">
                                                    <input type="text" name="title" placeholder="Bạn có thể nhập lại nếu muốn" class="form-control" required>
                                                    <input type="hidden" name="action" value="edit">
                                                    <input type="hidden" name="thisCourseID" value="${courseID}">
                                                    <input type="hidden" name="lessonID" value="${ch.lessonID}">
                                                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                                                    <button type="submit" class="btn btn-success btn-sm">Lưu</button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Button -->
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark"><i class="fas fa-home"></i></a>
                                    <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=createChapter&courseID=${courseID}" class="btn btn-secondary">Quay lại</a>
                                </div> 
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${actionCourse eq 'uploadMaterial'}">
                        <div class="container mt-5">
                            <div class="row">
                                <!-- Cột trái: Form Upload -->
                                <div class="col-md-6">
                                    <h2 class="mb-4 fw-bold text-center text-primary">Upload Material</h2>
                                    <form action="uploadMaterial" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                        <input type="hidden" name="thisChapterID" value="${thischapterID}">
                                        <input type="hidden" name="thisLessonID" value="${thisLessonID}">
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Title *</label>
                                            <input type="text" class="form-control" name="title" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Material Type (tất cả các file đều phải dưới 10MB)</label>
                                            <select class="form-select" name="type" required>
                                                <option value="" disabled selected>Select type</option>
                                                <option value="Video">Video</option>
                                                <option value="PDF">PDF</option>
                                                <option value="Other">Khác</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Upload File</label>
                                            <input type="file" class="form-control" name="PartFile" required accept="video/*,.pdf,.doc,.docx">
                                        </div>

                                        <div class="d-flex justify-content-between">
                                            <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=uploadMaterial&courseID=${CourseID}&ChapterID=${ChapterID}" class="btn btn-secondary">Back</a>
                                            <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark">
                                                <i class="fas fa-home"></i>
                                            </a>
                                            <button type="submit" class="btn create-cqm-btn">Upload</button>
                                        </div>
                                    </form>
                                    <c:if test="${not empty sessionScope.errorMessage}">
                                        <div class="alert alert-danger mt-3">${sessionScope.errorMessage}</div>
                                    </c:if>
                                </div>

                                <div class="col-md-6">
                                    <h4 class="fw-bold mb-3 text-secondary">Uploaded Materials</h4>

                                    <c:if test="${empty material}">
                                        <p class="text-muted">Chưa có tài liệu nào được tải lên.</p>
                                    </c:if>

                                    <c:forEach var="m" items="${material}">
                                        <div class="card mb-3 shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title">${m.title}</h5>
                                                <p class="card-text">
                                                    Ngày đăng: ${m.createdAt}
                                                </p>
                                                <c:choose>
                                                    <c:when test="${m.materialType eq 'image'}">
                                                        <img src="${m.contentURL}" alt="${m.title}" class="img-fluid rounded">
                                                    </c:when>
                                                    <c:when test="${m.materialType eq 'video'}">
                                                        <video controls class="w-100 rounded">
                                                            <source src="${m.contentURL}" type="video/mp4">
                                                        </video>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/ELM/viewMaterial?LessonID=${thisLessonID}&url=${m.contentURL}" target="_blank" class="btn btn-outline-primary btn-sm">
                                                            Xem tài liệu
                                                        </a><br>
                                                        <form action="uploadMaterial" method="post" enctype="multipart/form-data">
                                                            <input type="hidden" name="thisCourseID" value="${CourseID}">
                                                            <input type="hidden" name="thisChapterID" value="${ChapterID}">
                                                            <input type="hidden" name="thisLessonID" value="${thisLessonID}">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="materialID" value="${m.materialID}">
                                                            <input type="hidden" name="PartFile" value="${m.contentURL}">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                Delete material 
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${actionCourse eq 'editCourse'}">
                        <div class="container mt-5 mb-5">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="fw-bold text-orange">Thông tin khoá học </h2>
                                <button id="editToggleBtn" class="btn btn-warning text-white fw-semibold px-4">Sửa</button>
                            </div>
                            <form id="courseForm" action="${pageContext.request.contextPath}/instructor/editCourse" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="thisCourseID" value=${course.courseID}>
                                <div class="card mb-4 p-4 shadow-sm border-0">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold">Tiêu đề khoá học</label>
                                            <input type="text" class="form-control editable-field" name="title"
                                                   value="${course.title}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold">Danh mục (Môn học)</label>
                                            <select id="categorySelect" name="categoryID" class="form-control editable-field" required="">
                                                <option value="" disabled selected>${course.categoryName}</option>
                                                <c:forEach var="c" items="${categoryList}">
                                                    <option value="${c.cate_id}">${c.cate_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label fw-semibold">Mô tả</label>
                                            <textarea class="form-control editable-field" rows="4"
                                                      name="description" readonly>${course.description}</textarea>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Khối</label>
                                            <select class="form-select editable-field" name="className" disabled>
                                                <option value="10" <c:if test="${course.courseclass eq '10'}">selected</c:if>>10</option>
                                                <option value="11" <c:if test="${course.courseclass eq '11'}">selected</c:if>>11</option>
                                                <option value="12" <c:if test="${course.courseclass eq '12'}">selected</c:if>>12</option>
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold">Giá(₫) (ít nhất 10000 VND)</label>
                                                <input type="number" class="form-control editable-field" step="1000" min="10000"
                                                       name="price" value="${course.price}" readonly>
                                        </div> 
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Ảnh bìa</label>
                                            <input type="file" id="thumbnail" name="thumbnail" class="form-control editable-field" readonly>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Ảnh bìa hiện tại: </label>
                                            <img src="${course.thumbnail}"/>
                                        </div>
                                    </div>
                                    <div class="text-end mt-4">
                                        <a href="/ELM/instructor/dashboard?actionCourse=createChapter&courseID=${course.courseID}" class="btn btn-sm create-cqm-btn me-2">
                                            Chỉnh sửa thêm
                                        </a>
                                        <a href="dashboard" class="btn btn-sm btn-dark me-2">
                                            Huỷ xem/chỉnh sửa
                                        </a>
                                        <button type="submit" id="saveBtn" class="btn btn-success fw-semibold d-none">
                                            Lưu
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                        <script src="${pageContext.request.contextPath}/assets/js/veCQ.js"></script>
                    </c:when>
                </c:choose>
                <c:choose> 
                    <c:when test="${empty actionQuiz}">
                        <jsp:include page="quizList.jsp"/>
                    </c:when>
                    <c:when test="${actionQuiz eq 'createQuiz'}">
                    </c:when>
                </c:choose>
                
                <jsp:include page="materialList.jsp"/>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
</body>
</html>
