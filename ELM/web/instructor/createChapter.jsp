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
                 <div class="step" id="step-2">
                                <h5 class="mb-3">Chapters</h5>
                                <div id="chapterList"></div>
                                <button id="addChapterBtn" class="btn btn-outline-primary mb-3">+ Add New Chapter</button>
                            </div><div class="d-flex justify-content-between mt-4">
                        <button id="prevBtn" class="btn btn-outline-secondary">Back</button>
                        <button type="submit" id="nextBtn"  class="btn btn-primary">Continue</button>
                    </div>
            </div>
        </div>
        
         <script src="${pageContext.request.contextPath}/assets/js/createCQM.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
    </body>
</html>
