<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%-- Quiz Tab Content --%>
<div id="quiz-content" class="tab-content-block ${activeTab != 'quiz-content' ? 'd-none' : ''}">
    <!-- Create Quiz Box -->
    <div class="create-cqm-box p-4 rounded shadow-sm border mb-4 d-flex justify-content-between align-items-center">
        <span class="fs-5 text-muted">Ấn tạo khoá học mới ở bên phải</span>
        <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href = 'quizList?actionQuiz=selectCourse'">Tạo bài kiểm tra mới</button>
    </div>
    <div class="row mt-4">
        <div class="col-12">
            <form action="${pageContext.request.contextPath}/instructor/quizList" method="get" id="quizFilterForm" class="mb-3">
                <input type="hidden" name="activeTab" value="quiz-content">
                <div class="d-flex align-items-center">
                    <label for="CourseFilter" class="form-label me-3 mb-0 fw-bold">Lọc theo Khóa học:</label>
                    <select class="form-select w-auto" id="quizCourseFilter" name="courseID" 
                            onchange="document.getElementById('quizFilterForm').submit()">
                        <option value="0">Tất cả Khóa học</option>
                        <c:forEach var="course" items="${courseList}">
                            <option value="${course.courseID}" 
                                    ${param.courseID == course.courseID || selectedCourseID == course.courseID ? 'selected' : ''}>
                                ${course.title}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </form>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Tiêu đề</th>
                            <th>Khóa học</th>
                            <th>Chương</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${quizList}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/instructor/quizList?action=edit&quizID=${q.quizID}" 
                                       class="text-decoration-none fw-semibold text-dark">
                                        ${q.title}
                                    </a>
                                </td>
                                <td>${q.courseName}</td>
                                <td>${q.chapterName}</td>
                                <td class="text-center">
                                    <a href="/ELM/instructor/quizList?actionQuiz=editDetail&ChapterID=${q.chapterID}&quizID=${q.quizID}" 
                                       class="btn btn-view btn-sm btn-outline-warning me-2">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <button type="button" class="btn btn-delete btn-sm btn-outline-danger" 
                                            onclick="confirmDeleteQuiz(${q.quizID})">
                                        <i class="fas fa-trash-alt"></i> Xoá
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:choose>
                <c:when test="${actionQuizs eq 'selectCourse'}">
                    <select class="form-select form-select-lg w-auto" id="quizCourseFilter" name="courseID"
                            onchange="window.location.href = '/ELM/instructor/quizList?actionQuiz=selectChapter&courseID=' + this.value">
                        <option value="0">Tất cả Khóa học</option>
                        <c:forEach var="course" items="${courseList}">
                            <option value="${course.courseID}">
                                ${course.title}
                            </option>
                        </c:forEach>
                    </select>
                </c:when>
                <c:when test="${actionQuizs eq 'selectChapter'}">
                    <select class="form-select form-select-lg w-auto" id="quizCourseFilter" name="courseID"
                            onchange="window.location.href = '/ELM/instructor/quizList?actionQuiz=createQuiz&ChapterID=' + this.value">
                        <option value="0">Tất cả Khóa học</option>
                        <c:forEach var="ch" items="${chapterList}">
                            <option value="${ch.chapterID}">
                                ${ch.title}
                            </option>
                        </c:forEach>
                    </select>
                </c:when>
                <c:when test="${actionQuizs eq 'createQuiz'}">
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
                                            <input type="hidden" name="thisChapterID" value="${thisChapterID}">
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
                                                    <a href="/ELM/instructor/quizList?actionQuiz=editDetail&ChapterID=${thisChapterID}&quizID=${quiz.quizID}"class="btn btn-sm btn-outline-warning">Edit</a>
                                                    <form action="createQuiz" method="post">
                                                        <input type="hidden" name="thisChapterID" value="${thisChapterID}">
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
                </c:when>
                <c:when test="${actionQuizs eq 'editDetail'}">
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
                                                <textarea id="questionText" name="questionText" class="form-control" rows="6" placeholder="" required></textarea>
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
                </c:when>
            </c:choose>
        </div>
    </div>
</div>