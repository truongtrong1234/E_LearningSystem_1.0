<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
    <title>Quản lý yêu cầu Instructor</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css?v3">

</head>
<body>
    <jsp:include page="/components/panelAdmin.jsp"/>

<div class="admin-container">
    <h1>Danh sách yêu cầu trở thành Instructor</h1>

    <table class="request-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Chức danh</th>
            <th>Kinh nghiệm</th>
            <th>Kỹ năng</th>
            <th>CV</th>
            <th>Trạng thái</th>
            <th>Ngày gửi</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="r" items="${requests}">
            <tr>
                <td>${r.requestID}</td>
                <td>${r.fullName}</td>
                <td>${r.email}</td>
                <td>${r.title}</td>
                <td>${r.experience}</td>
                
                <td>${r.skills}</td>
                <td> <a href="${pageContext.request.contextPath}/viewMaterial?url=${r.cvFile}" target="_blank">
                                Xem CV
                            </a></td>
                <td>
                    <c:choose>
                        <c:when test="${r.status eq 'Approved'}">
                            <span class="status approved">Đã duyệt</span>
                        </c:when>
                        <c:when test="${r.status eq 'Rejected'}">
                            <span class="status rejected">Đã hủy</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status pending">Chờ duyệt</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                <c:if test="${not empty r.createdAt}">
    <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm" />
</c:if></td>

                <td>
                    <c:if test="${r.status eq 'Pending'}">
                        <form method="post" action="manageRequest" style="display:inline;">
                            <input type="hidden" name="requestID" value="${r.requestID}">
                            <button type="submit" name="action" value="approve" class="btn-approve" style="margin-bottom: 7px">Duyệt</button>
                        </form>
                        <form method="post" action="manageRequest" style="display:inline;">
                            <input type="hidden" name="requestID" value="${r.requestID}">
                            <button type="submit" name="action" value="reject" class="btn-reject">Hủy</button>
                        </form>
                    </c:if>
                    
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
