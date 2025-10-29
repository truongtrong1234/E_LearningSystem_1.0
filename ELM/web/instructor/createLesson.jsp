<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
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
                        <div class="circle active">1</div>
                        <div class="label">Basic</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">2</div>
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

                <form action="createLesson" method="post" class="d-flex mb-4">
                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Enter new chapter title..." required>
                    <button type="submit" class="btn btn-primary">+ Add Lesson ${thischapterID}</button>
                </form>

                <!-- Danh sách chương -->
                <div id="chapterList">
                    <c:if test="${empty Lessons}">
                        <p class="text-muted">No Lessons yet. Create one above!</p>
                    </c:if>

                    <c:forEach var="ch" items="${Lessons}">
                        <div class="card mb-3">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <span><strong>${ch.title}</strong></span>
                                <div>
                                    <a href="uploadMaterial?LessonID=${ch.lessonID}" class="btn btn-outline-success btn-sm me-2">Create Lesson</a>
                                    <button type="submit" value="delete" class="btn btn-primary">Delete </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/createCQM.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
    </body>
</html>
