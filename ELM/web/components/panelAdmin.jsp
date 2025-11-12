
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.notif-link {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #fff;
  text-decoration: none;
  padding: 8px 16px;
}

.notif-badge {
  background-color: #e74c3c;
  color: #fff;
  font-size: 12px;
  border-radius: 50%;
  padding: 4px 8px;
}
</style>

        <div class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
                <li><a href="/ELM/admin/adminIndex">Dashboard</a></li>
                <li><a href="/ELM/admin/manageAccount">Manage Accounts</a></li>
                <li><a href="/ELM/admin/manageCourse">Manage Courses</a></li>
                <li><a href="/ELM/admin/manageReport">User Reports</a></li>
                <li> <a href="/ELM/admin/manageRequest">Instructor Requests</a></li>

                   <!--  Notifications -->
        <li>
            <a href="${pageContext.request.contextPath}/viewNotifications" class="d-flex justify-content-between align-items-center">
                <span>Notifications</span>
                <c:if test="${unreadCount>0}">
                <span class="badge bg-danger rounded-pill">
                    ${unreadCount}
          </span>
          </c:if>
            </a>
        </li>
                <div class="logout-btn mt-4">
                    <a href="/ELM/logout" style="text-decoration: none;">Logout</a>
                </div>
            </ul>      
        </div>
