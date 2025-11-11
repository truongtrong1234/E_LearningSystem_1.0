<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Reports | Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    </head>
    <body>
     <jsp:include page="/components/panelAdmin.jsp"/>

        <div class="main-content">
            <h1>User Reports</h1>

            <c:choose>
                <c:when test="${empty listReports}">
                    <div class="alert alert-warning">No reports found.</div>
                </c:when>
                <c:otherwise>
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Sender Name</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${listReports}">
                                <tr>
                                    <td>${r.reportId}</td>
                                    <td>${r.title}</td>
                                    <td>${r.senderName}</td>
                                    <td>${r.senderEmail}</td>
                                    <td>${r.status}</td>
                                    <td>${r.createdAt}</td>
                                    <td>
                                        <a href="reportDetail?id=${r.reportId}" class="btn btn-primary btn-sm">View</a>
                                        <a href="manageReport?action=delete&id=${r.reportId}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Delete this report?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
