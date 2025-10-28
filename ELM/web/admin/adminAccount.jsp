<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        table {
            background: white;
            width: 100%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Admin Panel</h2>
    <ul class=>
        <li><a href="adminIndex.jsp">Dashboard</a></li>
        <li><a href="adminAccount">Manage Accounts</a></li>
        <li><a href="viewCourses.jsp">Manage Courses</a></li>
        <li><a href="adminReport.jsp">User Reports</a></li>
    </ul>
    <div class="logout-btn mt-4">
        <a href="../logout">Logout</a>
    </div>
</div>

<div class="main-content">
    <h1>User Accounts</h1>

    <table class="table table-striped">
        <thead class="table-dark">
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
            List<Account> list = (List<Account>) request.getAttribute("accounts");
            if (list != null) {
                for (Account a : list) {
        %>
        <tr>
            <td><%= a.getAccountId() %></td>
            <td><%= a.getEmail() %></td>
            <td><%= a.getName() %></td>
            <td><%= a.getRole() %></td>
            <td>
                <a href="editAccount?id=<%= a.getAccountId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="deleteAccount?id=<%= a.getAccountId() %>" class="btn btn-danger btn-sm">Delete</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="5">No accounts found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
