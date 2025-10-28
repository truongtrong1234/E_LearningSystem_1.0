<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Account" %>
<%
    Account user = (Account) request.getAttribute("user");
%>

<h2>Edit Account</h2>
<form method="post" action="<%=request.getContextPath()%>/admin">
    <input type="hidden" name="action" value="updateAccount"/>
    <input type="hidden" name="id" value="<%=user.getId()%>"/>
    <div>
        <label>Email</label>
        <input type="email" name="email" value="<%=user.getEmail()%>" required/>
    </div>
    <div>
        <label>Password</label>
        <input type="text" name="password" value="<%=user.getPassword()%>" required/>
    </div>
    <div>
        <label>Name</label>
        <input type="text" name="name" value="<%=user.getName()%>"/>
    </div>
    <div>
        <label>Role</label>
        <select name="role">
            <option <%= "Admin".equals(user.getRole()) ? "selected":"" %>>Admin</option>
            <option <%= "Instructor".equals(user.getRole()) ? "selected":"" %>>Instructor</option>
            <option <%= "Learner".equals(user.getRole()) ? "selected":"" %>>Learner</option>
        </select>
    </div>
    <div style="margin-top:10px;">
        <button type="submit">Save</button>
        <a href="<%=request.getContextPath()%>/admin?section=accounts">Cancel</a>
    </div>
</form>
