<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <!-- thêm ?v=3 để phá cache -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css?v=3">
           <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerGuest.css?v=3">
              <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">

        <title> Guest</title>

        
        
    </head>
    <body>

        <!-- HEADER -->
        <jsp:include page="components/headerGuest.jsp"/>

        <!-- CATEGORY BAR -->
        <div class="category-wrap">
            <div class="category-bar">
                <c:forEach var="cat" items="${listOfCategories}">
                    <a href="${pageContext.request.contextPath}/searchCourse?cats=${cat.cate_id}">
                        ${cat.cate_name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- BANNER -->
        <section class="hero">
            <div class="hero-left">
                <div class="hero-card">
                    <h2>Welcome to ELearnEZ</h2>
                    <p>Learn coding, AI, and more with expert-led online courses. Join our learning community today!</p>
                    <div>
                        <a href="<%=ctx%>/login.jsp" class="btn-primary">Get started for free</a>
                    </div>
                </div>
            </div>
            <div class="hero-right">
                <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?q=80&w=1200&auto=format&fit=crop" alt="Learning">
            </div>
        </section>

        <!-- COURSES -->
        <section class="section">
            <h3>Popular Courses</h3>
            <div class="grid">
                <c:forEach var="c" items="${listCourse}">
                    <a class="course-card" href="${pageContext.request.contextPath}/courseDetail?id=${c.courseID}">
                        <div class="thumb">
                            <img src="${c.thumbnail}" alt="${c.title}">
                        </div>
                        <div class="body">
                            <div class="title">${c.title}</div>
                            <div class="meta">Instructor Name: ${c.instructorName}</div>
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
