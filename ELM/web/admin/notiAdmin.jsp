<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thông báo | Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        .notification-container {
            margin-left: 260px;
            padding: 30px;
            background-color: #f8f9fa;
            min-height: 100vh;
        }

        .notification-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            transition: all 0.2s ease-in-out;
        }

        .notification-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .notification-card.unread {
            border-left: 5px solid #007bff;
            background-color: #eef6ff;
        }

        .notification-title {
            font-weight: 600;
            color: #333;
        }

        .notification-time {
            color: #777;
            font-size: 0.9rem;
        }

        .view-detail {
            text-decoration: none;
            color: #007bff;
            font-weight: 500;
        }

        .view-detail:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/panelAdmin.jsp"/>

    <div class="notification-container">
        <h2 class="mb-4"> Danh sách thông báo</h2>

        <c:if test="${empty notifications}">
            <div class="alert alert-info">Hiện chưa có thông báo nào.</div>
        </c:if>

        <c:forEach var="n" items="${notifications}">
            <div class="notification-card ${n.read ? '' : 'unread'}">
                <div class="d-flex justify-content-between">
                    <span class="notification-title">${n.title}</span>
                    <small class="notification-time">
                        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </small>
                </div>
                <p class="mt-2 mb-2">${n.message}</p>
                <a href="${pageContext.request.contextPath}/notiDetail?id=${n.notificationID}" 
                   class="view-detail">Xem chi tiết</a>
            </div>
        </c:forEach>
    </div>
</body>
</html>
