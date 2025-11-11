<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
.notification-wrapper {
  position: relative;
}

.icon-btn {
  background: none;
  border: none;
  cursor: pointer;
  position: relative;
  font-size: 20px;
}

.notif-badge {
  position: absolute;
  top: -5px;
  right: -2px;
  background: red;
  color: white;
  border-radius: 50%;
  font-size: 10px;
  padding: 2px 5px;
}

.notif-dropdown {
  display: none;
  position: absolute;
  right: 0;
  top: 35px;
  width: 320px;
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
  z-index: 1000;
}

.notif-dropdown.show {
  display: block;
}

.notif-header {
  font-weight: bold;
  padding: 10px;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: space-between;
}

.notif-list {
  max-height: 250px;
  overflow-y: auto;
}

.notif-item {
  padding: 10px;
  border-bottom: 1px solid #f2f2f2;
  cursor: pointer;
}

.notif-item.unread {
  background-color: #f8f9fa;
}

.notif-item:hover {
  background-color: #f1f1f1;
}

.notif-footer {
  padding: 10px;
  text-align: center;
  border-top: 1px solid #eee;
}

.mark-read {
  background: none;
  border: none;
  color: #007bff;
  cursor: pointer;
  margin-right: 10px;
}

.view-all {
  color: #007bff;
  text-decoration: none;
  font-weight: bold;
}
</style>

<header class="main-header">
  <div class="header-container">

    <a class="logo" href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">
      <span class="s">Secret</span><span class="c">Coder</span>
    </a>

    <div class="search-bar">
      <form action="${pageContext.request.contextPath}/searchCourse" method="get">
        <i class="fa fa-search search-icon"></i>
        <input type="text" name="keyword" placeholder="Search for anything" value="${param.keyword}">
        <button type="submit"><i class="bi bi-arrow-return-left"></i></button>
      </form>
    </div>

    <nav class="nav-links">
      <a href="${pageContext.request.contextPath}/instructorRequest">Instructor</a>
      <a href="${pageContext.request.contextPath}/myLearning">My Learning</a>
    </nav>

    <div class="header-icons">
      
           <!-- ===== Notification Button ===== -->
      <div class="notification-wrapper">
        <button class="icon-btn" id="notif-btn">
          <i class="bi bi-bell"></i>
          <span class="notif-badge">${fn:length(notifications)}</span>

        </button>

        <!-- ===== Notification Dropdown ===== -->
        <div class="notif-dropdown" id="notif-dropdown">
          <div class="notif-header">
            <span>Notifications</span>
            <span class="notif-badge">${fn:length(notifications)}</span>
          </div>

         <div class="notif-list">
  <c:forEach var="n" items="${notifications}">
    <div class="notif-item ${n.read ? 'read' : 'unread'}">
      <p><strong>${n.title}</strong></p>
      <p>${n.message}</p>
      <small>
        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
      </small>
    </div>
  </c:forEach>

  <c:if test="${empty notifications}">
    <div class="notif-item">
      <p>Không có thông báo mới.</p>
    </div>
  </c:if>
</div>

          </div>

          <div class="notif-footer">
            <button class="mark-read">Mark all as read</button>
            <a href="${pageContext.request.contextPath}/notifications" class="view-all">View all </a>
          </div>
        </div>
      </div>

      <a href="${pageContext.request.contextPath}/myProfile" class="avatar">
        <c:choose>
          <c:when test="${not empty sessionScope.account.picture}">
            <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img"/>
          </c:when>
          <c:otherwise>${fn:substring(sessionScope.account.name,0,1)}</c:otherwise>
        </c:choose>
      </a>
    </div>
  </div>
</header>
        
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



