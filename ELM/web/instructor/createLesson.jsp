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
        <title>Tạo bài giảng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
                        <div class="label">chương</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle active">3</div>
                        <div class="label">Bài giảng</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">4</div>
                        <div class="label">Kiểm tra</div>
                    </div>
                </div>

                <form action="createLesson" method="post" class="d-flex mb-4">
                    <input type="hidden" name="thisCourseID" value="${courseID}">
                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Nhập tiêu đề bài giảng..." required>
                    <button type="submit" class="btn btn-primary">+ Thêm bài giảng</button>
                </form>

                <div id="lessonList">
                    <c:if test="${empty Lessons}">
                        <p class="text-muted">Chưa có bài giảng nào. Hãy tạo một cái ở trên!</p>
                    </c:if>

                    <c:forEach var="ch" items="${Lessons}">
                        <div class="card mb-3">

                            <div class="card-body d-flex justify-content-between align-items-center">
                                <!-- Tiêu đề -->
                                <span><strong>${ch.title}</strong></span>
                                <div>
                                    <!-- Upload material -->
                                    <a href="uploadMaterial?CourseID=${courseID}&ChapterID=${thischapterID}&LessonID=${ch.lessonID}" class="btn btn-outline-success btn-sm me-2">
                                        Tải tài liệu
                                    </a>

                                    <!-- Delete lesson -->
                                    <form action="createLesson" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="thisCourseID" value="${courseID}">
                                        <input type="hidden" name="lessonID" value="${ch.lessonID}">
                                        <input type="hidden" name="thischapterID" value="${thischapterID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Xoá bài giảng</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Form edit lesson -->
                            <div class="card-body border-top">
                                <form action="createLesson" method="post" class="d-flex gap-2 align-items-center">
                                    <input type="text" name="title" placeholder="Bạn có thể nhập lại nếu muốn" class="form-control" required>
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="thisCourseID" value="${courseID}">
                                    <input type="hidden" name="lessonID" value="${ch.lessonID}">
                                    <input type="hidden" name="thischapterID" value="${thischapterID}">
                                    <button type="submit" class="btn btn-success btn-sm">Lưu</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Button -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark"><i class="fas fa-home"></i></a>
                    <a href="${pageContext.request.contextPath}/instructor/createChapter?courseID=${courseID}" class="btn btn-secondary">Quay lại</a>
                </div> 
            </div>
        </div>
    </body>
</html>
