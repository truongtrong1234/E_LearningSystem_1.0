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
        <title>Tạo bài học</title>
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
                        <div class="label">Cơ bản</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">2</div>
                        <div class="label">Thêm chương</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle active">3</div>
                        <div class="label">Bài học</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">4</div>
                        <div class="label">Kiểm tra</div>
                    </div>
                </div>

                <form action="createLesson" method="post" class="d-flex mb-4">
                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Enter new lesson title..." required>
                    <button type="submit" class="btn btn-primary">+ Thêm bài học</button>
                </form>

                <!-- Danh sách chương -->
                <div id="chapterList">
                    <c:if test="${empty Lessons}">
                        <p class="text-muted">Chưa bài học nào được tạo!</p>
                    </c:if>
                    <c:forEach var="ch" items="${Lessons}">
                        <div class="card mb-3">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <span><strong>${ch.title}</strong></span>
                                <div>
                                    <a href="uploadMaterial?LessonID=${ch.lessonID}" class="btn btn-outline-success btn-sm me-2">Tải tài liệu</a>
                                    <form action="createLesson" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="lessonID" value="${ch.lessonID}">
                                        <input type="hidden" name="thischapterID" value="${thischapterID}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            Xoá bài học
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Button -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Huỷ</a>
                    <!-- <button type="submit" id="nextBtn"  class="btn btn-primary">Continue</button> -->
                </div> 
            </div>
        </div>
    </body>
</html>
