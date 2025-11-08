<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/createCQM.css">
</head>
<body>
    <form action="${pageContext.request.contextPath}/instructor/createQuiz" method="post">
        <div class="create-quiz-container">
            <div class="create-quiz-container">
                <input type="hidden" name="courseId" value="${requestScope.currentCourseId}">
                <input type="hidden" name="chapterId" value="${requestScope.currentChapterId}">
                <p>Creating Quiz for Course ID: ${requestScope.currentCourseId} and Chapter ID: ${requestScope.currentChapterId}</p>
            </div>
            
            <!-- Quiz Title -->
            <div class="mb-3">
                <label class="form-label">Quiz Title *</label>
                <input type="text" id="quizTitle" name="quizTitle" class="form-control" placeholder="Enter quiz title" required>
            </div>

            <!-- Question Container -->
            <div id="questionsContainer"></div>

            <div class="d-flex justify-content-between mt-4 gap-3">
                <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Cancel</a>
                <button type="button" class="btn btn-warning" id="addQuestionBtn">+ Add Question</button>
                <button type="submit" class="btn btn-success" id="saveQuizBtn">Create Quiz</button>
            </div>
        </div>
    </form>
                
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/createQuiz.js"></script>
</body>
</html>
