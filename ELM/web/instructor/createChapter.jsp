<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("/ELM/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/createCQM.css">
    </head>
    <body>
        <div class="container my-5">
            <div class="card shadow-sm p-4">
                <!-- STEP HEADER -->
                <div class="step-header mb-4">
                    <div class="text-center">
                        <div class="circle">1</div>
                        <div class="label">Basic</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle active">2</div>
                        <div class="label">Chapters</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">3</div>
                        <div class="label">Lessons</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">4</div>
                        <div class="label">Review</div>
                    </div>
                </div>
                <!-- Add Chapter -->
                <form action="createChapter" method="post" class="d-flex mb-4">
                    <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Enter new chapter title..." required>
                    <button type="submit" class="btn btn-primary">+ Add Chapter </button>                  
                </form>
                <!-- Danh sách chương -->
                <div id="chapterList">
                    <c:if test="${empty chapters}">
                        <p class="text-muted">No chapters yet. Create one above!</p>
                    </c:if>

                    <c:forEach var="ch" items="${chapters}">
                        <div class="card mb-3">
                            <!-- Dòng hiển thị tiêu đề và nút chức năng -->
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <!-- Tiêu đề -->
                                <span><strong>${ch.title}</strong></span>

                                <div>
                                    <a href="createLesson?ChapterID=${ch.chapterID}" class="btn btn-outline-success btn-sm me-2">Create Lesson</a>
                                    <a href="createQuiz?ChapterID=${ch.chapterID}" class="btn btn-outline-warning btn-sm me-2">Create Quiz</a>

                                    <form action="createChapter" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="chapterID" value="${ch.chapterID}">
                                        <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Delete Chapter</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Form edit nằm riêng bên dưới -->
                            <div class="card-body border-top">
                                <form action="createChapter" method="post" class="d-flex gap-2 align-items-center">
                                    <input type="text" name="title" placeholder="Bạn có thể nhập lại nếu muốn" class="form-control" required>
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="chapterID" value="${ch.chapterID}">
                                    <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                    <button type="submit" class="btn btn-success btn-sm">Save</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Button -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Cancel</a>
                    <a href="${pageContext.request.contextPath}/instructor/editCourse?id=${thisCourseID}" class="btn btn-secondary">Go Back</a>
                </div> 
            </div>
        </div>
    </body>
</html>
