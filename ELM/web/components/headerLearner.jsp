<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
/* ===== Notification Wrapper ===== */
.notification-wrapper {
    position: relative;
    display: inline-block;
}

.icon-btn {
    background: none;
    border: none;
    cursor: pointer;
    position: relative;
    font-size: 18px;
    color: #495057;
}

.notif-badge {
    position: absolute;
    top: -6px;
    right: -6px;
    background-color: #ff6600;
    color: #fff;
    font-size: 12px;
    font-weight: 600;
    padding: 2px 6px;
    border-radius: 50%;
}

/* ===== Notification Dropdown ===== */
.notif-dropdown {
    display: none;
    position: absolute;
    right: 0;
    width: 320px;
    max-height: 400px;
    overflow-y: auto;
    background-color: #fff;
    border: 1px solid #eee;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 100;
}

.notif-dropdown.show {
    display: block;
}

.notif-header {
    display: flex;
    justify-content: space-between;
    padding: 12px 16px;
    font-weight: 600;
    border-bottom: 1px solid #eee;
    background-color: #f9f9f9;
}

.notif-list {
    max-height: 280px;
    overflow-y: auto;
}

.notif-item {
    display: block;
    padding: 10px 16px;
    border-bottom: 1px solid #eee;
    text-decoration: none;
    color: #333;
    transition: background 0.2s ease;
}

.notif-item:hover {
    background-color: #fff4eb;
}

/* Chưa đọc */
.notif-item.unread {
    background-color: #fff9f3;
    border-left: 4px solid #ff6600;
    font-weight: 600;
}

/* Đã đọc */
.notif-item.read {
    background-color: #f8f8f8;
    opacity: 0.8;
    font-weight: 400;
}

/* ===== Footer: View all + Mark all ===== */
.notif-footer {
    padding: 10px 16px;
    border-top: 1px solid #eee;
    background-color: #f9f9f9;
}

.notif-footer .view-all-link,
.notif-footer .mark-all-link {
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.2s ease;
}

.notif-footer .view-all-link:hover,
.notif-footer .mark-all-link:hover {
    color: #e85500;
}

/* ===== Scrollbar (tùy chọn) ===== */
.notif-list::-webkit-scrollbar {
    width: 6px;
}

.notif-list::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.notif-list::-webkit-scrollbar-thumb {
    background: #ccc;
    border-radius: 10px;
}

.notif-list::-webkit-scrollbar-thumb:hover {
    background: #999;
}

/* ===== Responsive ===== */
@media (max-width: 768px) {
    .notif-dropdown {
        width: 280px;
        right: -10px;
    }
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
              <c:if test="${unreadCount > 0}">
        <span class="notif-badge">${unreadCount}</span>
    </c:if>

        </button>

        <!-- ===== Notification Dropdown ===== -->
        <div class="notif-dropdown" id="notif-dropdown">
          <div class="notif-header">
            <span>Notifications</span>
             </div>

<div class="notif-list">
  <c:forEach var="n" items="${notifications}">
    <a href="${pageContext.request.contextPath}/notiDetail?id=${n.notificationID}"
       class="notif-item ${n.read ? 'read' : 'unread'}">
      <p><strong>${n.title}</strong></p>
      <p>${n.message}</p>
      <small>
        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
      </small>
    </a>
  </c:forEach>

  <c:if test="${empty notifications}">
    <div class="notif-item">
      <p>Không có thông báo mới.</p>
    </div>
  </c:if>
</div>

<!--  Nút xem tất cả -->
<div class="notif-footer text-center">
  <a href="${pageContext.request.contextPath}/viewNotifications" class="view-all-link">
    Xem tất cả 
  </a>
      <a href="${pageContext.request.contextPath}/markAllRead" 
     class="mark-all-link" style="margin-left: 15px; color: #ff6600; text-decoration: none;">
     Đánh dấu tất cả đã đọc
  </a>
</div>
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



