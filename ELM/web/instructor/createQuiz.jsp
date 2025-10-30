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
        <h3>Create New Quiz</h3>
        <!-- Select Course -->
        <div class="mb-3">
            <label for="courseSelect" class="form-label fw-bold">Select Course *</label>
            <select id="courseSelect" name="courseId" class="form-select" required>
                <option value="">-- Choose Course --</option>
                <c:forEach var="course" items="${courses}">
                    <option value="${course.id}">${course.title}</option>
                </c:forEach>
            </select>
        </div>
        <!-- Select Chapter -->
        <div class="mb-3">
            <label for="chapterSelect" class="form-label fw-bold">Select Chapter *</label>
            <select id="chapterSelect" name="chapterId" class="form-select" required>
                <option value="">-- Choose Chapter --</option>
                <c:forEach var="chapter" items="${chapters}">
                    <option value="${chapter.id}">${chapter.title}</option>
                </c:forEach>
            </select>
        </div>
        <!-- Quiz Title -->
        <div class="mb-3">
            <label class="form-label">Quiz Title *</label>
            <input type="text" id="quizTitle" class="form-control" placeholder="Enter quiz title">
        </div>
        <!-- Question -->
        <div id="questionsContainer"></div>
        <div class="d-flex justify-content-between mt-4 gap-3">
            <button class="btn btn-cancel" id="cancelBtn">Cancel</button>
            <button class="btn btn-add" id="addQuestionBtn">+ Add Question</button>
            <button class="btn btn-save" id="saveQuizBtn">Create Quiz</button>
        </div>
    </div>
    </form>
    
    <script src="${pageContext.request.contextPath}/assets/js/createCQM.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
</body>
</html>
