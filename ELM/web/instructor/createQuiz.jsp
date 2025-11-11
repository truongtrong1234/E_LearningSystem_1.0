
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    </head>

    <body class="bg-light">
        <div class="container-fluid py-4">
            <div class="row g-4">
                <!-- LEFT: FORM CREATE / EDIT -->
                <div class="col-md-6">
                    <div class="card border-warning">
                        <div class="card-header bg-warning text-white fw-bold">
                            Create New Quiz
                        </div>

                        <div class="card-body">
                            <form action="createQuiz" method="post">
                                <input type="hidden" name="thisChapterID" value="${ChapterID}">
                                <!-- Quiz Title -->
                                <div class="mb-3">
                                    <label class="form-label">Quiz Title *</label>
                                    <input type="text" name="quizTitle" class="form-control"
                                           placeholder="Enter quiz title"
                                           required>
                                </div>
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark">
                                        <i class="fas fa-home"></i>
                                    </a>
                                    <button type="submit" 
                                            class="btn btn-warning text-white fw-bold">
                                        Create Quiz
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: QUIZ LIST -->
                <div class="col-md-6">
                    <div class="card border-warning">
                        <div class="card-header bg-warning text-white fw-bold">Your Created Quizzes</div>
                        <div class="card-body">
                            <c:if test="${empty QuizList}">
                                <div class="text-center text-muted py-3">No quiz created yet.</div>
                            </c:if>

                            <c:forEach var="quiz" items="${QuizList}">
                                <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                    <div>
                                        <strong>${quiz.title}</strong><br>
                                    </div>
                                    <div>
                                        <a href="editQuizDetail?ChapterID=${ChapterID}&quizID=${quiz.quizID}"class="btn btn-sm btn-outline-warning">Edit</a>
                                        <form action="createQuiz" method="post">
                                            <input type="hidden" name="thisChapterID" value="${ChapterID}">
                                            <input type="hidden" name="quizID" value="${quiz.quizID}">
                                            <button type="submit" name="action" value="delete" class="btn btn-sm btn-outline-danger">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
