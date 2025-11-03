<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%-->
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quiz Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/veCQ.css">
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-orange">Quiz Information</h2>
            <button id="editToggleBtn" class="btn btn-warning text-white fw-semibold px-4">
                <i class="bi bi-pencil-square me-1"></i> Edit
            </button>
        </div>

        <!-- ========================= Quiz Info ========================= -->
        <form id="quizForm" action="updateQuiz" method="post">
            <input type="hidden" name="quizID" value="${quiz.quizID}">
            <div class="card mb-4 p-4 shadow-sm border-0">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Course</label>
                        <input type="text" class="form-control" value="${quiz.courseTitle}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Chapter</label>
                        <input type="text" class="form-control" value="${quiz.chapterTitle}" readonly>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Quiz Title</label>
                        <input type="text" class="form-control editable-field" name="title"
                               value="${quiz.title}" readonly>
                    </div>
                </div>
                <div class="text-end mt-4">
                    <button type="submit" id="saveBtn" class="btn btn-success fw-semibold d-none">
                        Save
                    </button>
                </div>
            </div>
        </form>

        <!-- ========================= Questions ========================= -->
        <h4 class="fw-bold mb-3 text-orange">Question List</h4>
        <c:choose>
            <c:when test="${not empty quiz.questions}">
                <div class="accordion" id="questionAccordion">
                    <c:forEach var="question" items="${quiz.questions}">
                        <div class="accordion-item mb-3 shadow-sm rounded-3">
                            <h2 class="accordion-header" id="heading${question.questionID}">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapse${question.questionID}" aria-expanded="false">
                                    <strong>${question.content}</strong>
                                </button>
                            </h2>
                            <div id="collapse${question.questionID}" class="accordion-collapse collapse"
                                 data-bs-parent="#questionAccordion">
                                <div class="accordion-body">
                                    <ul class="list-group mb-3">
                                        <c:forEach var="answer" items="${question.answers}">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <span>
                                                    <input type="radio" name="correct_${question.questionID}"
                                                           ${answer.correct ? "checked" : ""} disabled>
                                                    ${answer.content}
                                                </span>
                                                <div>
                                                    <a href="editAnswer?id=${answer.answerID}" 
                                                       class="btn btn-sm btn-outline-secondary me-2">Edit</a>
                                                    <a href="deleteAnswer?id=${answer.answerID}" 
                                                       class="btn btn-sm btn-outline-danger">Delete</a>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <a href="createAnswer?questionID=${question.questionID}" 
                                       class="btn btn-sm btn-success">+ Add Answer</a>
                                    <a href="editQuestion?id=${question.questionID}" 
                                       class="btn btn-sm btn-outline-primary ms-2">Edit</a>
                                    <a href="deleteQuestion?id=${question.questionID}" 
                                       class="btn btn-sm btn-outline-danger ms-2">Delete</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">This Quiz has no questions yet.</div>
            </c:otherwise>
        </c:choose>

        <div class="text-end mt-3">
            <a href="addQuestion?quizID=${quiz.quizID}" class="btn btn-orange fw-semibold">
                + Add Question
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/veCQ.js"></script>
</body>
</html>
