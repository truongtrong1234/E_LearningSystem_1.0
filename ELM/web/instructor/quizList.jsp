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
            <c:choose>
                <c:when test="${not empty quizList}">
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
                                            <a href="${pageContext.request.contextPath}/instructor/editQuizDetail?ChapterID=${q.chapterID}&quizID=${q.quizID}" 
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
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info text-center" role="alert">
                        Chưa có bài kiểm tra nào được tạo. Hãy ấn
                        <a href="createCourse" style="text-decoration: none; font-weight: bold">"Tạo khoá học mới"</a>
                        để bắt đầu!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>