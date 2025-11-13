<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Quiz</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <div class="container-fluid py-4">
            <div class="row g-4">
                <!-- LEFT: ADD NEW QUESTION -->
                <div class="col-md-6">
                    <div class="card border-warning">
                        <div class="card-header bg-warning text-white fw-bold">
                            Add New Question
                        </div>
                        <div class="card-body">
                            <form action="editQuizDetail" method="post">
                                <input type="hidden" name="thisquizID" value="${thisquizID}">
                                <input type="hidden" name="action" value="addQuestion">
                                <input type="hidden" name="thisChapterID" value="${thisChapterID}">

                                <div class="mb-3">
                                    <label class="form-label">Question Text *</label>
                                    <input type="text" name="questionText" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Option A</label>
                                    <input type="text" name="optionA" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Option B</label>
                                    <input type="text" name="optionB" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Option C</label>
                                    <input type="text" name="optionC" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Option D</label>
                                    <input type="text" name="optionD" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Correct Answer</label>
                                    <select name="correctAnswer" class="form-select" required>
                                        <option value="">Select...</option>
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="C">C</option>
                                        <option value="D">D</option>
                                    </select>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-warning text-white fw-bold">Add Question</button>
                                </div>
                            </form>
                            <div class="d-flex justify-content-center">
                                <c:set var="returnURL" value="#" /> 
                                <c:set var="chapterID" value="${param.ChapterID}" />
                                <c:set var="source" value="${param.source}" />
                                <c:choose>
                                    <c:when test="${source eq 'list'}">
                                        <c:set var="returnURL" value="${pageContext.request.contextPath}/instructor/quizList?activeTab=quiz-content" />
                                    </c:when>
                                    <c:when test="${source eq 'create'}">
                                        <c:set var="returnURL" value="${pageContext.request.contextPath}/instructor/createQuiz?ChapterID=${chapterID}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="returnURL" value="${pageContext.request.contextPath}/instructor/dashboard" /> 
                                    </c:otherwise>
                                </c:choose>
                                <a href="${returnURL}" class="btn btn-secondary fw-bold">
                                    Go Back
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: EDIT QUIZ TITLE + QUESTIONS -->
                <div class="col-md-6">
                    <div class="card border-warning">
                        <div class="card-header bg-warning text-white fw-bold">
                            Edit Quiz & Questions
                        </div>
                        <div class="card-body">
                            <!-- Edit Quiz Title -->
                            <form action="editQuizDetail" method="post" class="mb-4">
                                <input type="hidden" name="thisChapterID" value="${thisChapterID}">
                                <input type="hidden" name="thisquizID" value="${thisquizID}">
                                <input type="hidden" name="action" value="updateTitle">
                                <div class="mb-3">
                                    <label class="form-label">Quiz Title</label>
                                    <input type="text" name="quizTitle" class="form-control" value="${quiz.title}" required>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-outline-warning">Update Title </button>
                                </div>
                            </form>
                            <c:if test="${empty questions}">
                                <div class="text-center text-muted py-3">No questions yet.</div>
                            </c:if>

                            <c:forEach var="q" items="${questions}" varStatus="status">
                                <form action="editQuizDetail" method="post" class="border-bottom pb-3 mb-3">
                                    <input type="hidden" name="thisquizID" value="${thisquizID}">
                                    <input type="hidden" name="questionID" value="${q.questionID}">
                                    <input type="hidden" name="action" value="updateQuestion">
                                    <input type="hidden" name="thisChapterID" value="${thisChapterID}">

                                    <div class="mb-2">
                                        <label class="form-label">Question ${status.index + 1}</label>
                                        <input type="text" name="questionText" value="${q.questionText}" class="form-control" required>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-2">
                                            <label class="form-label">Option A</label>
                                            <input type="text" name="optionA" value="${q.optionA}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <label class="form-label">Option B</label>
                                            <input type="text" name="optionB" value="${q.optionB}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <label class="form-label">Option C</label>
                                            <input type="text" name="optionC" value="${q.optionC}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <label class="form-label">Option D</label>
                                            <input type="text" name="optionD" value="${q.optionD}" class="form-control" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Correct Answer</label>
                                        <select name="correctAnswer" class="form-select" required>
                                            <option value="A" ${q.correctAnswer == 'A' ? 'selected' : ''}>A</option>
                                            <option value="B" ${q.correctAnswer == 'B' ? 'selected' : ''}>B</option>
                                            <option value="C" ${q.correctAnswer == 'C' ? 'selected' : ''}>C</option>
                                            <option value="D" ${q.correctAnswer == 'D' ? 'selected' : ''}>D</option>
                                        </select>
                                    </div>
                                    <div class="d-flex justify-content-end gap-2">
                                        <button type="submit" class="btn btn-sm btn-outline-warning">Save</button></div>
                                </form>
                                <div class="d-flex justify-content-end gap-2">

                                    <form action="editQuizDetail" method="post" class="m-0">
                                        <input type="hidden" name="thisquizID" value="${thisquizID}">
                                        <input type="hidden" name="questionID" value="${q.questionID}">
                                        <input type="hidden" name="action" value="deleteQuestion">
                                        <input type="hidden" name="thisChapterID" value="${thisChapterID}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">Delete </button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
