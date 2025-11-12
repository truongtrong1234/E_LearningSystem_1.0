<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết khóa học - ${course.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-4 mb-5">
        <h1 class="text-center text-primary fw-bold mb-4">Nội dung khóa học: ${course.title}</h1>

        <c:forEach var="chapter" items="${chapterList}">
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-primary text-white fw-bold">
                    Chương ${chapter.chapterID}: ${chapter.title}
                </div>
                <div class="card-body">
                    <!-- Danh sách bài học -->
                    <h5 class="text-success">Bài học</h5>
                    <c:choose>
                        <c:when test="${not empty chapterLessonMap[chapter.chapterID]}">
                            <ul class="list-group mb-3">
                                <c:forEach var="lesson" items="${chapterLessonMap[chapter.chapterID]}">
                                    <li class="list-group-item">
                                        <i class="bi bi-play-circle"></i> ${lesson.title}
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Chưa có bài học nào trong chương này.</p>
                        </c:otherwise>
                    </c:choose>

                    <!-- Danh sách Quiz -->
                    <h5 class="text-warning mt-3">Bài kiểm tra</h5>
                    <c:choose>
                        <c:when test="${not empty chapterQuizMap[chapter.chapterID]}">
                            <ul class="list-group">
                                <c:forEach var="quiz" items="${chapterQuizMap[chapter.chapterID]}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <span>${quiz.title}</span>
                                        <a href="${pageContext.request.contextPath}/admin/quizDetail?QuizID=${quiz.quizID}" 
                                           class="btn btn-outline-primary btn-sm">
                                           Xem chi tiết Quiz
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Chưa có bài kiểm tra nào trong chương này.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>

        <div class="text-center mt-5">
            <a href="${pageContext.request.contextPath}/admin/courseList" class="btn btn-secondary">
                ← Quay lại danh sách khóa học
            </a>
        </div>
    </div>

</body>
</html>
