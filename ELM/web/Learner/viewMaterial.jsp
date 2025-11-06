<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>View Materials</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-4">
        <h4>Nếu không thấy được thì hãy F5(reload lại trang)</h4>
        <c:if test="${empty materials}">
            <div class="alert alert-info">No materials uploaded yet.</div>
        </c:if>
            <c:if test="${not empty materials}">
                <span><strong>Bấm vào đường link để có thể xem video</strong></span>
            ${materials}
        </c:if>
    </body>
</html>
