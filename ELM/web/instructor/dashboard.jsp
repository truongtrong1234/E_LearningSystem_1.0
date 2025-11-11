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
                       class="nav-link text-white sidebar-link ${activeTab == null || activeTab == 'courses-content' ? 'active' : ''}">
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
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
                <div class="container-fluid">
                    <div class="mx-auto">
                        <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
                    </div>
                    <div class="d-flex align-items-center ms-auto">
                        <span class="me-3 text-muted nav-profile-text">
                            <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse" style="color: #495057; text-decoration: none;">Learner</a>
                        </span>
                        <button class="btn btn-sm me-3 notification-btn" type="button">
                            <a href="${pageContext.request.contextPath}/notification.jsp" style="color: #495057"><i class="fas fa-bell"></i></a>
                        </button>
                        <button class="btn btn-sm me-3 notification-btn" type="button">
                            <a href="${pageContext.request.contextPath}/myProfile.jsp" style="color: #495057"><i class="fa-solid fa-user-circle fa-2x"></i></a>
                        </button>
                    </div>
                </div>
            </nav>

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

                <!-- Course Tab -->
                <div id="courses-content" class="tab-content-block ${activeTab == 'course-content' || activeTab == 'material-content' ? 'd-none' : ''}">
                    <!-- Create Course Box -->
                    <div class="create-cqm-box p-4 rounded shadow-sm border mb-4 d-flex justify-content-between align-items-center">
                        <span class="fs-5 text-muted">Ấn tạo khoá học mới ở bên phải</span>
                        <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href='createCourse'">Tạo khoá học mới</button>
                    </div>

                    <!-- Course List -->
                    <div class="row mt-4 course-list">
                        <c:choose>
                            <c:when test="${not empty courseList}">
                                <c:forEach var="course" items="${courseList}">
                                    <div class="col-xl-3 col-lg-4 col-md-6 mb-4" onclick="window.location='/ELM/myContent?CourseID=${course.courseID}'">
                                        <div class="card cqm-card border-0 shadow-sm">
                                            <div class="dropdown cqm-actions" onclick="event.stopPropagation()">
                                                <button class="btn p-0 text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="editCourse?id=${course.courseID}"><i class="fas fa-edit me-2"></i> Sửa khoá học </a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li>
                                                        <form action="/ELM/instructor/dashboard" method="post">
                                                            <button type="submit" class="dropdown-item" value="${course.courseID}" name="action">Xoá khoá học</button>
                                                        </form>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="cqm-image-placeholder bg-light rounded-top">
                                                    <img src="${course.thumbnail}" alt="alt"/>
                                            </div>
                                            <div class="card-body">
                                                <h5 class="card-title fw-bold text-truncate" title="${course.title}">${course.title}</h5>
                                                <p class="card-text text-muted mb-2">${course.price} VND</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="alert alert-info text-center" role="alert">
                                        Chưa có khoá học nào được tạo. Hãy ấn
                                        <a href="createCourse" style="text-decoration: none">"Tạo khoá học mới"</a> để bắt đầu!
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Quiz Tab -->
                <div id="quiz-content" class="tab-content-block ${activeTab != 'quiz-content' ? 'd-none' : ''}">
                    <!-- Create Quiz Box -->
                    <div class="create-cqm-box p-4 rounded shadow-sm border mb-4 d-flex justify-content-between align-items-center">
                        <span class="fs-5 text-muted">Ấn tạo bài kiểm tra mới ở bên phải</span>
                        <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href='createQuiz'">Tạo bài kiểm tra mới</button>
                    </div>

                    <!-- Quiz List -->
                    <div class="row mt-4 quiz-list">
                        <c:choose>
                            <c:when test="${not empty quizList}">
                                <table class="table table-hover align-middle">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>#</th>
                                            <th>Title</th>
                                            <th>Questions</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="quiz" items="${quizList}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>${quiz.title}</td>
                                                <td>
                                                    <c:set var="questionCount" value="0"/>
                                                    <c:forEach var="q" items="${quiz.questions}">
                                                        <c:set var="questionCount" value="${questionCount + 1}"/>
                                                    </c:forEach>
                                                    ${questionCount}
                                                </td>
                                                <td>
                                                    <a href="viewQuiz?id=${quiz.quizID}" class="btn btn-info btn-sm">Xem</a>
                                                    <a href="editQuiz?id=${quiz.quizID}" class="btn btn-warning btn-sm">Sửa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="alert alert-info text-center" role="alert">
                                        Chưa có bài kiểm tra nào. Click 
                                        <a href="${pageContext.request.contextPath}/instructor/createQuiz" style="text-decoration: none">"Tạo bài kiểm tra mới"</a> để bắt đầu!
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Material Tab -->
                <div id="material-content" class="tab-content-block ${activeTab != 'material-content' ? 'd-none' : ''}">
                    <!-- Material List -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <form action="${pageContext.request.contextPath}/instructor/MaterialListController" method="get" id="filterForm" class="mb-5">
                                <input type="hidden" name="activeTab" value="material-content">
                                <div class="d-flex align-items-center">
                                    <label for="courseFilter" class="form-label me-3 mb-0 fw-bold">Lọc theo Khóa học:</label>
                                    <select class="form-select w-auto" id="courseFilter" name="courseID" 
                                            onchange="document.getElementById('filterForm').submit()">
                                        <option value="0">Tất cả Khóa học</option>
                                        <c:forEach var="course" items="${courseList}">
                                            <option value="${course.courseID}" 
                                                    ${param.courseID == course.courseID || selectedCourseID == course.courseID ? 'selected' : ''}>
                                                ${course.title}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                            <c:choose>
                                <c:when test="${not empty materialList}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Loại</th>
                                                    <th>Khoá học</th> 
                                                    <th>Chương</th> 
                                                    <th>Bài giảng</th>
                                                    <th class="text-center">Tạo ngày</th>
                                                    <th class="text-center">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="m" items="${materialList}" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.index + 1}</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/viewMaterial?url=${m.contentURL}" target="_blank" class="text-decoration-none fw-semibold text-dark">
                                                                ${m.title}
                                                            </a>
                                                        </td>
                                                        <td>${m.materialType}</td>
                                                        <td>${m.lessonName}</td>
                                                        <td>${m.chapterName}</td>
                                                        <td>${m.courseName}</td>
                                                        <td class="text-center">
                                                            <fmt:formatDate value="${m.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="${pageContext.request.contextPath}/viewMaterial?url=${m.contentURL}" 
                                                               class="btn btn-view btn-sm btn-outline-success me-2" target="_blank">
                                                               <i class="fas fa-eye"></i> Xem
                                                            </a>
                                                            <button type="button" 
                                                                    class="btn btn-delete btn-sm btn-outline-danger" 
                                                                    onclick="confirmDelete(${m.materialID})">
                                                                <i class="fas fa-trash-alt"></i> Xoá
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-info text-center" role="alert">
                                        Chưa có tài liệu nào. Hãy tạo khoá học mới trước để bắt đầu!
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
</body>
</html>
