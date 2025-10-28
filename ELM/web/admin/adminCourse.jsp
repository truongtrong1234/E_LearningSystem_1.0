<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, model.Course" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = new ArrayList<>();
%>

<h2>Courses</h2>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Title</th><th>Category</th><th>Level</th><th>Price</th><th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <% for (Course c : courses) { %>
        <tr id="course-row-<%=c.getId()%>">
            <td><%=c.getId()%></td>
            <td><%=c.getTitle()%></td>
            <td><%=c.getCategory()%></td>
            <td><%=c.getLevel()%></td>
            <td><%=c.getPrice()%></td>
            <td>
                <a href="<%=request.getContextPath()%>/admin?section=editCourse&id=<%=c.getId()%>">Edit</a>
                &nbsp;|&nbsp;
                <button class="btn-delete-course" data-id="<%=c.getId()%>">Delete</button>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
