<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                <a href="viewMaterial?url=${m.contentURL}" target="_blank" class="btn btn-outline-primary btn-sm">
                                    Xem tài liệu
                                </a>
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
