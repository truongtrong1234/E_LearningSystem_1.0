<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Report</title>
    <link rel="stylesheet" href="../css/instructor.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css">
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
                <a href="${pageContext.request.contextPath}/instructor/dashboard" class="nav-link text-white sidebar-link">
                    <i class="fas fa-tachometer-alt me-2"></i> Tổng quan 
                </a>
            </li>
        <li>
            <a href="${pageContext.request.contextPath}/instructor/communication.jsp" class="nav-link text-white sidebar-link">
                <i class="fas fa-comments me-2"></i> Tương tác
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link">
                <i class="fas fa-chart-bar me-2"></i> Phân tích
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/instructor/sendReport.jsp" class="nav-link text-white sidebar-link active">
                <i class="fas fa-question-circle me-2"></i> Hỗ trợ
            </a>
        </li>
        </ul>
    </div>
    <!-- Main Content -->
    <div class="main-content flex-grow-1 p-0">
        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
            <div class="container-fluid">
                <div class="mx-auto">
                    <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
                </div>
            <div class="d-flex align-items-center ms-auto">
                <span class="me-3 text-muted nav-profile-text">
                    <a href="${pageContext.request.contextPath}/Learner/home_learner.jsp" style="color: #495057; text-decoration: none;">Học sinh</a>
                </span>
                <button class="btn btn-sm me-3 notification-btn" type="button">
                    <a href="${pageContext.request.contextPath}/notification.jsp" style="color: #495057">
                        <i class="fas fa-bell"></i>
                    </a>
                </button>
                <button class="btn btn-sm me-3 notification-btn" type="button">
                    <a href="${pageContext.request.contextPath}/myProfile.jsp" style="color: #495057">
                        <i class="fa-solid fa-user-circle fa-2x"></i>
                    </a>
                </button>
            </div>
            </div>
        </nav>
                        
        <!-- Report Form Card -->
        <div class="send-report-container card border-0 shadow-sm rounded-4 p-5">
            <h4 class="fw-bold text-center mb-4" style="color: var(--primary-dark);">
                Gửi báo cáo tới QUẢN TRỊ VIÊN
            </h4>
            <form action="SendReportServlet" method="post" class="send-report-form">
                <div class="mb-4">
                    <label class="form-label fw-semibold">Tiêu đề</label>
                    <input type="text" name="subject" class="form-control" placeholder="" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold">Mô tả</label>
                    <textarea name="description" class="form-control" rows="7" placeholder="Mô tả vấn đề một cách chi tiết..." required></textarea>
                </div>

                <!-- Type bug 
                <div class="mb-4">
                    <label class="form-label fw-semibold">Type</label>
                    <select name="category" class="form-select">
                        <option value="System Bug">System Bug</option>
                        <option value="UI Problem">UI Problem</option>
                        <option value="Course Issue">Course Issue</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                -->
                <div class="text-end">
                    <button type="submit" class="btn send-report-btn px-5 py-2">Gửi</button>
                </div>
                <c:if test="${not empty message}">
                    <div class="send-report-message ${status}">
                        ${message}
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</div>
</body>
</html>
