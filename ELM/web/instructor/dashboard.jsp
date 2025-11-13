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
                               <jsp:include page="manageCourse.jsp"/>
                    <c:choose>
                        <c:when test="${not empty actionCourse}">
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
                                        <button type="submit" class="btn btn-primary">Tiếp theo</button>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                    </c:choose>
                                

                    <jsp:include page="quizList.jsp"/>

                    <jsp:include page="materialList.jsp"/>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
    </body>
</html>
