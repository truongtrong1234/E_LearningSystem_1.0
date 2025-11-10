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
        <title>Tạo khoá học</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/createCQM.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor.css">
    </head>
    <body>
        <div class="container my-5">
            <div class="card shadow-sm p-4">
                <!-- STEP HEADER -->
                <div class="step-header mb-4">
                    <div class="text-center">
                        <div class="circle active">1</div>
                        <div class="label">Cơ bản</div>
                    </div>
                    <div class="step-indicator"></div>
                    <div class="text-center">
                        <div class="circle">2</div>
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
                <form id="courseForm"  action="createCourse" method="post" enctype="multipart/form-data"> <!-- STEP 1: BASIC INFO -->
                    <div class="step active" id="step-1">
                        <h5 class="mb-3">Thông tin cơ bản</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="courseTitle" class="form-label" required="">Tiêu đề khoá học *</label>
                                <input type="text" id="courseTitle" name="courseTitle" class="form-control" placeholder="Enter course title">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Danh mục (Môn học) *</label>
                                <select id="categorySelect" name="categoryID" class="form-select" required="">
                                    <option value="" disabled selected>-- Select Category --</option>
                                    <c:forEach var="c" items="${categoryList}">
                                        <option value="${c.cate_id}">${c.cate_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea id="description" name="description" class="form-control" rows="3" placeholder="Mô tả ngắn gọn về khóa học"></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Khối *</label>
                                <select id="class" name="class"  class="form-select" required="">
                                    <option value="">-- Chọn khối --</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Giá(đ) * (ít nhất 10000 VND)</label>
                                <input type="number" id="price" name="price" class="form-control" placeholder="Enter price" required="" step="1000" min="10000">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Ảnh bìa</label>
                            <input type="file" id="thumbnail" name="thumbnail" class="form-control" >
                        </div>

                    </div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Lỗi:</strong> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-primary">Trang tổng quan</a>
                        <button type="submit" class="btn btn-primary">Tiếp theo</button>
                    </div>
                </form>
                <!--             STEP 2: CHAPTER CREATION 
                            <div class="step" id="step-2">
                                <h5 class="mb-3">Chapters</h5>
                                <div id="chapterList"></div>
                                <button id="addChapterBtn" class="btn btn-outline-primary mb-3">+ Add New Chapter</button>
                            </div>
                
                             STEP 3: LESSON CREATION 
                            <div class="step" id="step-3">
                                <h5 class="mb-3">Lessons</h5>
                                <p class="text-muted">Add lessons to the selected chapter.</p>
                                <div id="lessonContainer"></div>
                                <button id="addLessonBtn" class="btn btn-outline-primary">+ Add Lesson</button>
                            </div>
                
                             STEP 4: REVIEW 
                            <div class="step" id="step-4">
                                <h5 class="mb-3">Review & Submit</h5>
                                <p>Check all your course details before publishing.</p>
                                <button class="btn btn-success">Submit Course</button>
                            </div>-->
            </div>
        </div>
    </body>
</html>
