<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) username = "Learner";
    String ctx = request.getContextPath();
%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("/ELM/login");
        return;
    }
    
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>SecretCoder | My Learning</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="assets/css/mylearning.css">


    </head>
    <body>
        <!-- HEADER -->
        <header class="header">
            <a class="logo" href="<%=ctx%>/home_learner.jsp">
                <span class="s">Secret</span><span class="c">Coder</span>
            </a>

            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search for anything">
                <button title="Search"><i class="bi bi-arrow-return-left"></i></button>
            </div>

            <nav class="nav-links">
                <a href="<%=ctx%>/course">Instructor</a>
            </nav>

            <div class="header-icons">
                <button class="icon-btn" title="Wishlist"><i class="bi bi-heart"></i></button>
                <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
                <button class="icon-btn" title="Notifications"><i class="bi bi-bell"></i></button>
                <a href="<%=ctx%>/myProfile.jsp" class="avatar" title="Profile">U</a>
            </div>
        </header>



        <main class="learning-container">
            <h1>Chapter</h1>
            <!-- Danh sách course -->
            <c:forEach var="course" items="${chapterList}">
                <div class="course-card" onclick="toggleChapters()" style="cursor:pointer;">
                    <a href="myLesson?ChapterID=${course.chapterID}">
                        <div class="course-info">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <h2>${course.title}</h2>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </main>

        <footer>© 2025 SecretCoder. All rights reserved.</footer>
    </body>
</html>
