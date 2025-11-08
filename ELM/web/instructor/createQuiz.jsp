<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy tổng số question hiện có từ attribute (do servlet set)
    Integer totalQuestions = (Integer) request.getAttribute("totalQuestions");
    if (totalQuestions == null) totalQuestions = 1;
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
    <form action="createQuiz" method="post">
        <div class="create-quiz-container">
            <!-- Quiz Title -->
            <div class="mb-3">
                <label class="form-label">Quiz Title *</label>
                <input type="text" name="titleQuiz" value="${quizTitle != null ? quizTitle : ''}" class="form-control" placeholder="Enter quiz title" required>
            </div>
            
            <!-- Hidden fields -->
            <input type="hidden" name="totalQuestions" value="${totalQuestions}">
            <input type="hidden" name="thisCourseID" value="${courseID}">
            <input type="hidden" name="thisChapterID" value="${thischapterID}">

            <!-- Questions -->
            <c:forEach var="q" items="${questions}" varStatus="status">
                <div class="border p-3 mt-3 rounded">
                    <h5>Question ${status.index + 1}</h5>
                    <input type="text" name="questionText${status.index + 1}" class="form-control mb-2"
                           placeholder="Question text" value="${q.questionText}" required>
                    <input type="text" name="optionA${status.index + 1}" class="form-control mb-2"
                           placeholder="Option A" value="${q.optionA}" required>
                    <input type="text" name="optionB${status.index + 1}" class="form-control mb-2"
                           placeholder="Option B" value="${q.optionB}" required>
                    <input type="text" name="optionC${status.index + 1}" class="form-control mb-2"
                           placeholder="Option C" value="${q.optionC}" required>
                    <input type="text" name="optionD${status.index + 1}" class="form-control mb-2"
                           placeholder="Option D" value="${q.optionD}" required>
                    <select name="correctAnswer${status.index + 1}" class="form-select" required>
                        <option value="">Select Correct Answer</option>
                        <option value="A" ${q.correctAnswer=='A' ? 'selected' : ''}>A</option>
                        <option value="B" ${q.correctAnswer=='B' ? 'selected' : ''}>B</option>
                        <option value="C" ${q.correctAnswer=='C' ? 'selected' : ''}>C</option>
                        <option value="D" ${q.correctAnswer=='D' ? 'selected' : ''}>D</option>
                    </select>
                    <button type="submit" name="deleteIndex" value="${status.index}" class="mt-3 btn btn-danger btn-sm">Delete Question</button>
                </div>
            </c:forEach>

            <!-- Button -->
            <div class="d-flex justify-content-between mt-5 gap-3">
                <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Cancel</a>
                <button type="submit" name="action" value="addQuestion" class="btn btn-primary">+ Add Question</button>
                <button type="submit" name="action" value="submitQuiz" class="btn btn-success">Create Quiz</button>
            </div>
        </div>
    </form>
</body>
</html>
