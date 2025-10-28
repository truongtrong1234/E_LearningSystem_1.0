<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Course" %>
<%
    Course c = (Course) request.getAttribute("course");
%>

<h2>Edit Course</h2>
<form method="post" action="<%=request.getContextPath()%>/admin">
    <input type="hidden" name="action" value="updateCourse"/>
    <input type="hidden" name="id" value="<%=c.getId()%>"/>
    <div><label>Title</label><input type="text" name="title" value="<%=c.getTitle()%>" required/></div>
    <div><label>Category</label><input type="text" name="category" value="<%=c.getCategory()%>"/></div>
    <div><label>Level</label><input type="text" name="level" value="<%=c.getLevel()%>"/></div>
    <div><label>Language</label><input type="text" name="language" value="<%=c.getLanguage()%>"/></div>
    <div><label>Price</label><input type="number" step="0.01" name="price" value="<%=c.getPrice()%>"/></div>
    <div><label>Description</label><textarea name="description"><%=c.getDescription()%></textarea></div>
    <div style="margin-top:10px;">
        <button type="submit">Save</button>
        <a href="<%=request.getContextPath()%>/admin?section=courses">Cancel</a>
    </div>
</form>
