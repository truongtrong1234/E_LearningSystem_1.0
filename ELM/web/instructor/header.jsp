<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Header Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
    <div class="container-fluid">
        <div class="mx-auto">
            <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
        </div>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-muted nav-profile-text">
                <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse" 
                   style="color: #495057; text-decoration: none;">Learner</a>
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
