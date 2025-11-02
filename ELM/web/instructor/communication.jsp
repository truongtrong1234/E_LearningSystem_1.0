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
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                        </a>
                    </li>
                    <li>
                        <!-- Active ở Communication -->
                        <a href="${pageContext.request.contextPath}/instructor/communication.jsp" class="nav-link text-white sidebar-link active">
                            <i class="fas fa-comments me-2"></i> Communication
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-chart-bar me-2"></i> Analytics
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/sendReport.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-question-circle me-2"></i> Helps
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
                                <a href="${pageContext.request.contextPath}/Learner/home_learner" style="color:#495057;text-decoration:none;">Learner</a>
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

                <!-- Content -->
                <div class="container-fluid p-4">
                    <!-- Compose Box -->
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title mb-3"><i class="fa-solid fa-paper-plane me-2"></i>Gửi thông báo/tin nhắn</h5>

                                    <!-- Thay action đúng servlet/controller -->
                                    <form action="${pageContext.request.contextPath}/instructor/communication/send" method="post" enctype="multipart/form-data">
                                        <!-- Chọn phạm vi gửi -->
                                        <div class="mb-3">
                                            <label class="form-label">Gửi đến</label>
                                            <div class="row g-2">
                                                <div class="col-md-4">
                                                    <select class="form-select" name="targetType" required>
                                                        <option value="ALL">Tất cả học viên</option>
                                                        <option value="COURSE">Theo khóa học</option>
                                                        <option value="STUDENT">Một học viên</option>
                                                    </select>
                                                </div>

                                                <!-- Course (hiện khi targetType=COURSE bằng JS) -->
                                                <div class="col-md-5">
                                                    <select class="form-select" name="courseId">
                                                        <option value="">-- Chọn khóa học --</option>
                                                        <c:forEach var="c" items="${courses}">
                                                            <option value="${c.id}">${c.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <!-- Email/SID học viên (khi targetType=STUDENT) -->
                                                <div class="col-md-3">
                                                    <input type="text" class="form-control" name="studentIdentifier" placeholder="Email/SID học viên">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tiêu đề -->
                                        <div class="mb-3">
                                            <label class="form-label">Tiêu đề</label>
                                            <input type="text" class="form-control" name="title" maxlength="200" required>
                                        </div>

                                        <!-- Nội dung -->
                                        <div class="mb-3">
                                            <label class="form-label">Nội dung</label>
                                            <textarea class="form-control" name="content" rows="5" placeholder="Nhập nội dung cần gửi..." required></textarea>
                                        </div>

                                        <!-- File đính kèm -->
                                        <div class="mb-3">
                                            <label class="form-label">Đính kèm (tùy chọn)</label>
                                            <input type="file" class="form-control" name="attachment">
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
                        </div>

                        <!-- Filters (tuỳ chọn) -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm mb-3">
                                <div class="card-body">
                                    <h6 class="card-title mb-3"><i class="fa-solid fa-filter me-2"></i>Bộ lọc tin nhắn</h6>
                                    <form action="${pageContext.request.contextPath}/instructor/communication" method="get" class="row g-2">
                                        <div class="col-12">
                                            <input type="text" class="form-control" name="q" placeholder="Tìm theo tiêu đề/nội dung...">
                                        </div>
                                        <div class="col-6">
                                            <select class="form-select" name="filterTarget">
                                                <option value="">Tất cả</option>
                                                <option value="ALL">Tất cả học viên</option>
                                                <option value="COURSE">Theo khóa học</option>
                                                <option value="STUDENT">Một học viên</option>
                                            </select>
                                        </div>
                                        <div class="col-6">
                                            <select class="form-select" name="courseFilter">
                                                <option value="">Khoá học</option>
                                                <c:forEach var="c" items="${courses}">
                                                    <option value="${c.id}">${c.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-12 d-flex justify-content-end">
                                            <button class="btn btn-outline-secondary">Lọc</button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Tips -->
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h6 class="card-title mb-2"><i class="fa-solid fa-lightbulb me-2"></i>Mẹo</h6>
                                    <ul class="small mb-0">
                                        <li>Dùng <b>COURSE</b> để gửi thông báo theo từng lớp.</li>
                                        <li>Đính kèm PDF/Tài liệu nếu cần.</li>
                                        <li>Giữ tiêu đề ngắn gọn, rõ mục đích.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Messages list -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title mb-3"><i class="fa-solid fa-inbox me-2"></i>Lịch sử tin đã gửi</h5>

                                    <c:if test="${empty messages}">
                                        <div class="text-muted">Chưa có tin nhắn nào.</div>
                                    </c:if>

                                    <c:forEach var="m" items="${messages}">
                                        <div class="border rounded p-3 mb-3">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <strong class="d-block">${m.title}</strong>
                                                    <small class="text-muted">
                                                        Gửi bởi ${m.senderName}
                                                        • <i class="fa-regular fa-clock me-1"></i>${m.createdAt}
                                                        • <i class="fa-solid fa-tag me-1"></i>${m.targetType}
                                                        <c:if test="${m.targetType == 'COURSE'}"> • Khóa: ${m.courseName}</c:if>
                                                        <c:if test="${m.targetType == 'STUDENT'}"> • Học viên: ${m.studentEmail}</c:if>
                                                        </small>
                                                    </div>
                                                    <div>
                                                    <c:if test="${not empty m.attachmentName}">
                                                        <a class="btn btn-sm btn-outline-primary"
                                                           href="${pageContext.request.contextPath}/instructor/communication/download?messageId=${m.id}">
                                                            <i class="fa-solid fa-paperclip me-1"></i>${m.attachmentName}
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <p class="mt-2 mb-0">${m.content}</p>
                                        </div>
                                    </c:forEach>

                                    <!-- Phân trang -->
                                    <c:if test="${not empty pagination}">
                                        <nav class="mt-3">
                                            <ul class="pagination pagination-sm">
                                                <li class="page-item <c:if test='${!pagination.hasPrev}'>disabled</c:if>'">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/instructor/communication?page=${pagination.prev}">&laquo;</a>
                                                </li>
                                                <c:forEach var="p" begin="1" end="${pagination.total}">
                                                    <li class="page-item <c:if test='${p == pagination.current}'>active</c:if>'">
                                                        <a class="page-link" href="${pageContext.request.contextPath}/instructor/communication?page=${p}">${p}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item <c:if test='${!pagination.hasNext}'>disabled</c:if>'">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/instructor/communication?page=${pagination.next}">&raquo;</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- /container -->
            </div>
        </div>
    </body>
</html>
