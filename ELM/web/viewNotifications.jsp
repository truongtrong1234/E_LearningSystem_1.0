<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Tất cả thông báo</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
</head>
<body>
    <jsp:include page="/components/headerLearner.jsp" />

    <div class="container mt-4">
        <h3 class="mb-4"> Tất cả thông báo của bạn: </h3>

        <c:if test="${empty notifications}">
            <div class="alert alert-info">Không có thông báo nào.</div>
        </c:if>

        <c:forEach var="n" items="${notifications}">
            <div class="card mb-3 ${n.read ? 'border-secondary' : 'border-primary'}">
                <div class="card-body">
                    <h5 class="card-title">${n.title}</h5>
                    <p class="card-text">${n.message}</p>
                    <small class="text-muted">
                        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    </small>
                </div>
            </div>
        </c:forEach>

        <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse" class="btn btn-secondary mt-3">
            ← Quay lại trang chính
        </a>
    </div>
</body>
</html>
