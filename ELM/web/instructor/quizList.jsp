<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang tổng quan</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css">
</head>
<body>
    <div id="quiz-content" class="tab-content-block ${activeTab != 'quiz-content' ? 'd-none' : ''}">
        <!-- Quiz List -->
        <div class="row mt-4 quiz-list">
            <c:choose>
                <c:when test="${not empty quizList}">
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Questions</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="quiz" items="${quizList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${quiz.title}</td>
                                    <td>
                                        <c:set var="questionCount" value="0"/>
                                        <c:forEach var="q" items="${quiz.questions}">
                                            <c:set var="questionCount" value="${questionCount + 1}"/>
                                        </c:forEach>
                                        ${questionCount}
                                    </td>
                                    <td>
                                        <a href="viewQuiz?id=${quiz.quizID}" class="btn btn-info btn-sm">Xem</a>
                                        <a href="editQuiz?id=${quiz.quizID}" class="btn btn-warning btn-sm">Sửa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                     <div class="col-12">
                        <div class="alert alert-info text-center" role="alert">
                            Chưa có tài liệu nào. Hãy tạo khoá học mới trước để bắt đầu!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
