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
                <jsp:include page="manageCourse.jsp"/>

                <!-- Quiz Tab -->
                <jsp:include page="quizList.jsp"/>

                <!-- Material Tab -->
                <jsp:include page="materialList.jsp"/>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
</body>
</html>
