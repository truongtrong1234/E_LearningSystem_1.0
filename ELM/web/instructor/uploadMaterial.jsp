<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class="container mt-5">
            <div class="row">
                <!-- Cột trái: Form Upload -->
                <div class="col-md-6">
                    <h2 class="mb-4 fw-bold text-center text-primary">Upload Material</h2>
                    <form action="uploadMaterial" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="thisLessonID" value="${thisLessonID}">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Title *</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Material Type</label>
                            <select class="form-select" name="type" required>
                                <option value="" disabled selected>Select type</option>
                                <option value="Video">Video</option>
                                <option value="PDF">PDF</option>
                                <option value="Other">Khác</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Upload File</label>
                            <input type="file" class="form-control" name="PartFile" required>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Cancel</a>
                            <button type="button" onclick="history.back();" class="btn btn-secondary">
                                Go Back
                            </button>
                            <button type="submit" class="btn btn-primary">Upload</button>
                        </div>
                    </form>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger mt-3">${errorMessage}</div>
                    </c:if>
                </div>

                <!-- Cột phải: Danh sách Material -->
                <div class="col-md-6">
                    <h4 class="fw-bold mb-3 text-secondary">Uploaded Materials</h4>

                    <c:if test="${empty material}">
                        <p class="text-muted">Chưa có tài liệu nào được tải lên.</p>
                    </c:if>

                    <c:forEach var="m" items="${material}">
                        <div class="card mb-3 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">${m.title}</h5>
                                <p class="card-text">
                                    Ngày đăng: ${m.createdAt}
                                </p>
                                <c:choose>
                                    <c:when test="${m.materialType eq 'image'}">
                                        <img src="${m.contentURL}" alt="${m.title}" class="img-fluid rounded">
                                    </c:when>
                                    <c:when test="${m.materialType eq 'video'}">
                                        <video controls class="w-100 rounded">
                                            <source src="${m.contentURL}" type="video/mp4">
                                        </video>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/ELM/viewMaterial?LessonID=${thisLessonID}&url=${m.contentURL}" target="_blank" class="btn btn-outline-primary btn-sm">
                                            Xem tài liệu
                                        </a>

                                        <form action="uploadMaterial" method="post" enctype="multipart/form-data">
                                            <input type="hidden" name="thisLessonID" value="${thisLessonID}">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="materialID" value="${m.materialID}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                Delete material ${m.materialID}
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>
