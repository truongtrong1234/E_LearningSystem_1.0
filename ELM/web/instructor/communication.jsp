<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Instructor Communication</title>

        <!-- Bootstrap & Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

        <!-- CSS ngoài -->
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
                        <!-- Active ở Communication -->
                        <a href="${pageContext.request.contextPath}/instructor/communication.jsp" class="nav-link text-white sidebar-link active">
                            <i class="fas fa-comments me-2"></i> Tương tác
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-chart-bar me-2"></i> Phân tích
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/sendReport.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-question-circle me-2"></i> Hỗ trợ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main -->
            <div class="main-content flex-grow-1 p-0">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
                    <div class="container-fluid">
                        <div class="mx-auto">
                            <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
                        </div>
                        <div class="d-flex align-items-center ms-auto">
                            <span class="me-3 text-muted nav-profile-text">
                                <a href="${pageContext.request.contextPath}/Learner/home_learner" style="color:#495057;text-decoration:none;">Học sinh</a>
                            </span>
                            <a class="btn btn-sm me-3 notification-btn" href="${pageContext.request.contextPath}/notification" style="color:#495057">
                                <i class="fas fa-bell"></i>
                            </a>
                            <a class="btn btn-sm me-3 notification-btn" href="${pageContext.request.contextPath}/myProfile" style="color:#495057">
                                <i class="fa-solid fa-user-circle fa-2x"></i>
                            </a>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid p-4 communication-page">

                    <!--Simple Communication Form--> 
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="card shadow-sm mb-4">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">
                                        <i class="fa-solid fa-paper-plane me-2"></i>Gửi thông báo / tin nhắn
                                    </h5>

                                    <form action="${pageContext.request.contextPath}/instructor/communication" method="post">
                                        <div class="mb-3">
                                            <label class="form-label">Tiêu đề</label>
                                            <input type="text" class="form-control" name="title" placeholder="Nhập tiêu đề tin nhắn..." required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Nội dung</label>
                                            <textarea class="form-control" name="content" rows="5" placeholder="Nhập nội dung cần gửi..." required></textarea>
                                        </div>

                                        <div class="d-flex justify-content-end gap-2">
                                            <button type="reset" class="btn btn-light">Làm mới</button>
                                            <button type="submit" class="btn btn-warning text-white fw-semibold">
                                                <i class="fa-regular fa-paper-plane me-1"></i> Gửi
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Message History -->
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title mb-3"><i class="fa-solid fa-inbox me-2"></i>Lịch sử tin nhắn đã gửi</h5>

                                    <c:if test="${empty messages}">
                                        <div class="text-muted">Chưa có tin nhắn nào.</div>
                                    </c:if>

                                    <c:forEach var="m" items="${messages}">
                                        <div class="border rounded p-3 mb-3">
                                            <strong>${m.title}</strong>
                                            <div class="small text-muted mb-2">
                                                <i class="fa-regular fa-clock me-1"></i>${m.createdAt}
                                                • Gửi bởi ${m.senderName}
                                            </div>
                                            <p class="mb-0">${m.content}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
