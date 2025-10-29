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
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex">Dashboard</a></li>
            <li><a href="manageAccount">Manage Accounts</a></li>
            <li><a href="manageCourse.jsp">Manage Courses</a></li>
            <li><a href="manageReport.jsp">User Reports</a></li>
        </ul>
        <div class="logout-btn">
            <a href="../logout" style="text-decoration: none">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Manage User Accounts</h1>
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
