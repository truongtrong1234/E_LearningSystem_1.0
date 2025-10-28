<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>SecretCoder | Guest</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css">
</head>
<body>

    <!-- HEADER -->
    <header class="header">
        <a class="logo" href="${pageContext.request.contextPath}/home_Guest">
            <span class="s">Secret</span><span class="c">Coder</span>
        </a>

        <div class="search-bar">
            <i class="bi bi-search"></i>
            <input type="text" placeholder="Search for anything">
            <button title="Search"><i class="bi bi-arrow-return-left"></i></button>
        </div>

        <nav class="nav-links">
            <a href="<%=ctx%>/login.jsp">Login</a>
            <a href="<%=ctx%>/register.jsp">Register</a>
            
        </nav>
    </header>

    <!-- CATEGORY BAR -->
    <div class="category-wrap">
        <div class="category-bar">
            <c:forEach var="cat" items="${listOfCategories}">
                <a href="${pageContext.request.contextPath}/load?cats=${cat.cate_id}">
                    ${cat.cate_name}
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- BANNER -->
    <section class="hero">
        <div class="hero-left">
            <div class="hero-card">
                <h2>Welcome to SecretCoder</h2>
                <p>Learn coding, AI, and more with expert-led online courses. Join our learning community today!</p>
                <div>
                    <a href="<%=ctx%>/register.jsp" class="btn-primary">Get started for free</a>
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

    <footer>© 2025 SecretCoder. All rights reserved.</footer>
</body>
</html>
