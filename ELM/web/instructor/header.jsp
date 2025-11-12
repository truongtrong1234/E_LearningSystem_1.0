<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
      <!-- Link trở lại Learner home -->
      <span class="me-3 text-muted nav-profile-text">
        <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse"
           style="color: #495057; text-decoration: none;">Learner</a>
      </span>

      <!-- ===== Notification Dropdown ===== -->
      <div class="dropdown me-3">
        <button class="btn btn-light position-relative" id="notif-btn" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-bell fs-5"></i>
          <c:if test="${unreadCount>0}">
          <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
            ${unreadCount}
          </span>
          </c:if>
        </button>

        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="notif-btn" style="width: 300px;">
          <li class="dropdown-header d-flex justify-content-between align-items-center">
            <span><strong>Thông báo</strong></span>
            <a href="${pageContext.request.contextPath}/viewNotifications" class="text-primary small">Xem tất cả</a>
          </li>
          <li><hr class="dropdown-divider"></li>

          <c:forEach var="n" items="${notifications}">
            <li>
              <a href="${pageContext.request.contextPath}/notiDetail?id=${n.notificationID}"
                 class="dropdown-item ${n.read ? 'text-muted' : 'fw-bold'}">
                <div>${n.title}</div>
                <small class="text-secondary d-block text-truncate" style="max-width: 250px;">
                  ${n.message}
                </small>
                <small class="text-muted">
                  <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                </small>
              </a>
            </li>
          </c:forEach>

          <c:if test="${empty notifications}">
            <li><p class="dropdown-item text-center text-muted mb-0">Không có thông báo mới</p></li>
          </c:if>
        </ul>
      </div>

      <!-- Nút Profile -->
      <a href="${pageContext.request.contextPath}/myProfile.jsp" class="btn btn-light">
        <i class="fa-solid fa-user-circle fa-2x text-secondary"></i>
      </a>
    </div>
  </div>
</nav>

                <!-- ===== JS: Toggle Notification Dropdown ===== -->
<script>
document.getElementById('notif-btn').addEventListener('click', function() {
  document.getElementById('notif-dropdown').classList.toggle('show');
});

window.addEventListener('click', function(e) {
  if (!document.getElementById('notif-btn').contains(e.target)) {
    document.getElementById('notif-dropdown').classList.remove('show');
  }
});
</script>
