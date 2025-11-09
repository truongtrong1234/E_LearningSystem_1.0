<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Instructor Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard 
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link active">
                        <i class="fas fa-chart-bar me-2"></i> Analytics
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/instructor/sendReport" class="nav-link text-white sidebar-link">
                        <i class="fas fa-question-circle me-2"></i> Helps
                    </a>
                </li>
            </ul>
        </div>
                            
        <div class="main-content flex-grow-1 p-0">
            <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
                <div class="container-fluid">
                    <div class="mx-auto">
                        <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
                    </div>
                    <div class="d-flex align-items-center ms-auto">
                        <span class="me-3 text-muted nav-profile-text">
                            <a href="${pageContext.request.contextPath}/Learner/home_learner.jsp" style="color: #495057; text-decoration: none;">Learner</a>
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
            <div class="container-fluid p-4">                    
                <div class="row g-4">
                    <div class="col-md-3">
                        <div class="card p-3 text-center">
                            <h5 class="card-title mt-2">Tổng học viên</h5>
                            <h3>${totalStudents}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card p-3 text-center">
                            <h5 class="card-title mt-2">Khóa học</h5>
                            <h3>${totalCourses}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card p-3 text-center">
                            <h5 class="card-title mt-2">Điểm Quiz TB</h5>
                            <h3>${averageQuizScore}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card p-3 text-center">
                            <h5 class="card-title mt-2">Doanh thu tháng</h5>
                            <h3>${monthlyRevenue}₫</h3>
                        </div>
                    </div>
                </div>
                <!-- Student Progress Table -->
                <div class="mt-5">
                    <h5 class="card-title mb-3">Tiến độ học viên theo khóa học</h5>
                    <table class="table table-hover">
                        <thead class="table-warning">
                        <tr>
                            <th>Tên học viên</th>
                            <th>Khóa học</th>
                            <th>Tiến độ</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="progress" items="${studentProgressList}">
                            <tr>
                                <td>${progress.studentName}</td>
                                <td>${progress.courseName}</td>
                                <td>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar" style="width: ${progress.percent}%"></div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${progress.percent >= 100}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${progress.percent >= 50}">
                                            <span class="badge bg-warning text-dark">Đang học</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Chưa bắt đầu</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>                      
</body>
</html>
