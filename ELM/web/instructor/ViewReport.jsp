<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <title>Report Detail</title>
        <link rel="stylesheet" href="../css/instructor.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css"></head>
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
                        <a href="${pageContext.request.contextPath}/instructor/analytics.jsp" class="nav-link text-white sidebar-link">
                            <i class="fas fa-chart-bar me-2"></i> Analytics
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/instructor/sendReport" class="nav-link text-white sidebar-link active">
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
                <div class="send-report-container card border-0 shadow-sm rounded-4 p-5">
                    <h2 class="fw-bold text-center mb-4" style="color: var(--primary-dark);">Report Detail</h2>

                    <div class="card shadow-sm p-4">
                        <p><strong>Title:</strong> ${report.title}</p>
                        <p><strong>Status:</strong> ${report.status}</p>
                        <p><strong>Created At:</strong> ${report.createdAt}</p>
                        <hr>
                        <p><strong>Description:</strong></p>
                        <p>${report.message}</p>
                    </div>
                    <c:choose>
                        <c:when test="${empty replies}">
                            <div class="alert alert-secondary">No replies yet from Admin.</div>
                        </c:when>
                        <c:otherwise>
                            <div class="list-group">
                                <c:forEach var="rep" items="${replies}">
                                    <div class="list-group-item">
                                        <p><strong>Admin ${rep.adminId}</strong> 
                                            <span class="text-muted">(${rep.repliedAt})</span></p>
                                        <p>${rep.replyMessage}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="mt-4">
                        <a href="sendReport" class="btn btn-secondary">← Back to History</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
