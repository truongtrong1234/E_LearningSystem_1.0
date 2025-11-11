<%@page import="java.util.List"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <option value="all" <%= "all".equalsIgnoreCase((String)request.getAttribute("selectedRole")) || request.getAttribute("selectedRole")==null ? "selected" : "" %>>All</option>
                    <option value="admin" <%= "admin".equalsIgnoreCase((String)request.getAttribute("selectedRole")) ? "selected" : "" %>>Admin</option>
                    <option value="instructor" <%= "instructor".equalsIgnoreCase((String)request.getAttribute("selectedRole")) ? "selected" : "" %>>Instructor</option>
                    <option value="learner" <%= "learner".equalsIgnoreCase((String)request.getAttribute("selectedRole")) ? "selected" : "" %>>Learner</option>
                </select>
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
                <%
                    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
                    if (accounts != null) {
                        for (Account acc : accounts) {
                %>
                <tr>
                    <td><%= acc.getAccountId() %></td>
                    <td><%= acc.getEmail() %></td>
                    <td><%= acc.getName() %></td>
                    <td><%= acc.getRole() %></td>
                    <td>
                        <a href="editAccount.jsp?id=<%= acc.getAccountId() %>" class="btn edit">Edit</a>
                        <a href="AdminAccountServlet?action=delete&id=<%= acc.getAccountId() %>" class="btn delete" onclick="return confirm('Delete this account?');">Delete</a>
                        <a href="AdminAccountServlet?action=removeRole&id=<%= acc.getAccountId() %>" class="btn role" onclick="return confirm('Remove role for this account?');">Remove Role</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
