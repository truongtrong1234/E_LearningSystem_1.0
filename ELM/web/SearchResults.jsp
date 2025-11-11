<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="vi">
 <head>
     <meta charset="UTF-8">
        <title>SecretCoder | Learner</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css?v3">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerGuest.css?v=3">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
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
                        
<c:if test="${empty listCourse}">
    <p>Không tìm thấy khóa học nào.</p>
</c:if>

<section class="section"  style="min-height: 500px;">
            
            <div class="grid">
                <c:forEach var="c" items="${listCourse}">
                    <a class="course-card" href="${pageContext.request.contextPath}/courseDetail?id=${c.courseID}">
                        <div class="thumb">
                            <img src="${c.thumbnail}" alt="${c.title}">
                        </div>
                        <div class="body">
                            <div class="title">${c.title}</div>
                            <div class="meta">Instructor ID: ${c.instructorID}</div>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${c.price == 0}">
                                        Miễn phí
                                    </c:when>
                                    <c:otherwise>
                                        ${c.price}đ
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>
    <!-- FOOTER -->
        <jsp:include page="components/footer.jsp"/>
</body> 
    </html>
