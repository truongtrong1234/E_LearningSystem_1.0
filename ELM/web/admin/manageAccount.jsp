<%@page import="java.util.List"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Manage Accounts</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    </head>
    <body>
        <!-- Sidebar -->

        <jsp:include page="/components/panelAdmin.jsp"/>

        <!-- Main Content -->
        <div class="main-content">
            <h1 class="mb-0">Manage User Accounts</h1>

            <!-- Bộ lọc role -->
            <form method="get" action="manageAccount" class="d-flex align-items-center gap-2">
                <label for="role" class="fw-semibold me-2" style="min-width: 110px; text-align: right;">
                    Filter by Role:
                </label>
                <select name="role" id="role" class="form-select form-select-sm" style="width: 160px;"
                        onchange="this.form.submit()">
                    <option value="all" ${selectedRole == 'all' || selectedRole == null ? 'selected' : ''}>All</option>
                    <option value="admin" ${selectedRole == 'admin' ? 'selected' : ''}>Admin</option>
                    <option value="instructor" ${selectedRole == 'instructor' ? 'selected' : ''}>Instructor</option>
                    <option value="learner" ${selectedRole == 'learner' ? 'selected' : ''}>Learner</option>
                </select>
                <input type="text" name="keyword" class="form-control form-control-sm"
                       placeholder="Search by name or email"
                       value="${keyword != null ? keyword : ''}" style="width: 220px;"/>

                <button type="submit" class="btn btn-sm btn-primary">Search</button>
            </form>
        </form>
        <table class="table data-table table-bordered align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="acc" items="${accounts}">
                    <tr>
                        <td>${acc.accountId}</td>
                        <td>${acc.email}</td>
                        <td>${acc.name}</td>
                        <td>${acc.role}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/adminAccountServlet?action=detail&id=${acc.accountId}" class="btn edit">View</a>
                            <a href="${pageContext.request.contextPath}/admin/adminAccountServlet?action=delete&id=${acc.accountId}"
                               class="btn delete"
                               onclick="return confirm('Delete this account?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
