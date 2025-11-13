<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) username = "Learner";
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title> Learner</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css?v3">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v3">
        <style>

        </style>
    </head>
    <body>

        <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />

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
                    <h2>Master tomorrow's skills today</h2>
                    <p>Power up your AI, career, and life skills with the most up-to-date, expert-led learning.</p>
                    <div>
                        <a href="<%=ctx%>/register.jsp" class="btn-primary">Get started</a>
                    </div>
                </div>
            </div>
            <div class="hero-right">
                <!-- thay ảnh minh hoạ của bạn tại đây -->
                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=1200&auto=format&fit=crop" alt="Hero">
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
                            <div class="title">${c.title} ${count}</div>
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
        <jsp:include page="/components/footer.jsp" />

    </body>
</html>
