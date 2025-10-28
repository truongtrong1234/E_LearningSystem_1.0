<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, model.Account" %>
<!-- <%
    List<Account> users = (List<Account>) request.getAttribute("users");
    if (users == null) users = new ArrayList<>();
%> -->

<h2>User Accounts</h2>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Email</th><th>Name</th><th>Role</th><th>Status</th><th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <% for (Account u : users) { %>
        <tr id="user-row-<%=u.getId()%>">
            <td><%=u.getId()%></td>
            <td><%=u.getEmail()%></td>
            <td><%=u.getName()==null?"":u.getName()%></td>
            <td><%=u.getRole()%></td>
            <td><%=u.getStatus()%></td>
            <td>
                <a href="<%=request.getContextPath()%>/admin?section=editAccount&id=<%=u.getId()%>">Edit</a>
                &nbsp;|&nbsp;
                <button class="btn-delete-account" data-id="<%=u.getId()%>">Delete</button>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
