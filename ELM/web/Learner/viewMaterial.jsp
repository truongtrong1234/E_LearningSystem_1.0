<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>View Materials</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v3">
    </head>
    <body >
                <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />
        
        <div  style=" margin: 20px 20px 50px 20px">
        <h4>Nếu không thấy được thì hãy F5(reload lại trang)</h4>
        <c:if test="${empty materials}">
            <div class="alert alert-info">No materials uploaded yet.</div>
        </c:if>
            <c:if test="${not empty materials}">
                <span><strong>Bấm vào đường link để có thể xem video</strong></span>
            ${materials}
        </c:if>
                
      </div>
                  <!-- FOOTER -->
        <jsp:include page="/components/footer.jsp" />
    </body>
</html>
