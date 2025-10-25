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
        <title>Create Course</title>
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
                <form id="courseForm"  action="createCourse" method="post" enctype="multipart/form-data"> <!-- STEP 1: BASIC INFO -->
                    <div class="step active" id="step-1">
                        <h5 class="mb-3">Basic Information</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="courseTitle" class="form-label" required="">Course Title *</label>
                                <input type="text" id="courseTitle" name="courseTitle" class="form-control" placeholder="Enter course title">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category *</label>
                                <select id="categorySelect" name="categoryID" class="form-select" required="">
                                    <option value="" disabled selected>-- Select Category --</option>
                                    <c:forEach var="c" items="${categoryList}">
                                        <option value="${c.cate_id}">${c.cate_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="3" placeholder="Short description about the course" required=""></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Class *</label>
                                <select id="class" name="class"  class="form-select" required="">
                                    <option value="">-- Select class --</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Price ($)</label>
                                <input type="number" id="price" name="price" class="form-control" placeholder="Enter price" required="">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Thumbnail</label>
                            <input type="file" id="thumbnail" name="thumbnail" class="form-control" required="">
                        </div>

                    </div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error:</strong> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-between mt-4">
                        <button id="prevBtn" class="btn btn-outline-secondary">Back</button>
                        <button type="submit" id="nextBtn"  class="btn btn-primary">Continue</button>
                    </div></form>

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

        <script src="${pageContext.request.contextPath}/assets/js/createCQM.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
    </body>
</html>
