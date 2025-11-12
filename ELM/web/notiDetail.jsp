<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title>${noti.title}</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="/components/headerLearner.jsp" />

  <div class="container mt-5">
    <div class="card shadow-sm">
      <div class="card-body">
        <h3>${noti.title}</h3>
        <p class="text-muted mb-2">
          <fmt:formatDate value="${noti.createdAt}" pattern="dd/MM/yyyy HH:mm" />
        </p>
        <hr>
        <p>${noti.message}</p>
        <a href="${pageContext.request.contextPath}/viewNotifications" class="btn btn-secondary mt-3">← Quay lại danh sách</a>
      </div>
    </div>
  </div>
</body>
</html>
