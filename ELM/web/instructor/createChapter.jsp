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
        <title>Tạo chương</title>
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
                        <div class="circle active">2</div>
                        <div class="label">Chương</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">3</div>
                        <div class="label">Bài giảng</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">4</div>
                        <div class="label">Kiểm tra</div>
                    </div>
                </div>
                <!-- Add Chapter -->
                <form action="createChapter" method="post" class="d-flex mb-4">
                    <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                    <input type="text" name="chapterTitle" class="form-control me-2" placeholder="Nhập tiêu đề chương..." required>
                    <button type="submit" class="btn btn-primary">+ Thêm chương </button>                  
                </form>
                <!-- Danh sách chương -->
                <div id="chapterList">
                    <c:if test="${empty chapters}">
                        <p class="text-muted">Chưa có chương nào. Hãy tạo một cái ở trên!</p>
                    </c:if>

                    <c:forEach var="ch" items="${chapters}">
                        <div class="card mb-3">
                            <!-- Dòng hiển thị tiêu đề và nút chức năng -->
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <!-- Tiêu đề -->
                                <span><strong>${ch.title}</strong></span>

                                <div>
                                    <a href="createLesson?courseID=${thisCourseID}&ChapterID=${ch.chapterID}" class="btn btn-outline-success btn-sm me-2">Tạo bài giảng</a>
                                    <a href="createQuiz?ChapterID=${ch.chapterID}" class="btn btn-outline-warning btn-sm me-2">Tạo bài kiểm tra</a>

                                    <form action="createChapter" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="chapterID" value="${ch.chapterID}">
                                        <input type="hidden" name="thisCourseID" value="${thisCourseID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Xoá chương</button>
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
                                    <button type="submit" class="btn btn-success btn-sm">Lưu</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Button -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark"><i class="fas fa-home"></i></a>
                    <a href="${pageContext.request.contextPath}/instructor/editCourse?id=${thisCourseID}" class="btn btn-secondary">Quay lại</a>
                </div> 
            </div>
        </div>
    </body>
</html>
