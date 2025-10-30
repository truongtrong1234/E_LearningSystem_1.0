<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="vi">
 <head>
     <meta charset="UTF-8">
        <title>SecretCoder | Learner</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerGuest.css?v=3">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
        <style>

        </style>
</head>
        
        <body>       
        <!-- header -->
       <c:choose>
        <%-- Nếu người dùng đã đăng nhập --%>
        <c:when test="${not empty sessionScope.account}">
            <jsp:include page="components/headerLearner.jsp"/>
        </c:when>

        <%-- Nếu là khách chưa đăng nhập --%>
        <c:otherwise>
            <jsp:include page="components/headerGuest.jsp"/>
        </c:otherwise>
    </c:choose>
                        
<c:if test="${empty courses}">
    <p>Không tìm thấy khóa học nào.</p>
</c:if>

<c:forEach var="course" items="${courses}">
    <div class="course-item">
        <img src="${course.thumbnail}" alt="${course.title}" width="120"/>
        <h3>${course.title}</h3>
        <p>${course.description}</p>
        <p>Price: ${course.price}</p>
    </div>
</c:forEach>
    
</body> 
    </html>
