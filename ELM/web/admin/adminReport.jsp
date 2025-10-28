<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, model.Feedback" %>
<%
    List<Feedback> reports = (List<Feedback>) request.getAttribute("reports");
    if (reports == null) reports = new ArrayList<>();
%>

<h2>User Reports / Feedback</h2>
<table>
    <thead>
        <tr>
            <th>ID</th><th>Sender ID</th><th>Message</th><th>Created At</th><th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <% for (Feedback f : reports) { %>
        <tr id="report-row-<%=f.getId()%>">
            <td><%=f.getId()%></td>
            <td><%=f.getSenderId()==null?"-":f.getSenderId()%></td>
            <td style="max-width:400px;"><pre style="white-space:pre-wrap;"><%=f.getMessage()%></pre></td>
            <td><%=f.getCreatedAt()%></td>
            <td>
                <button class="btn-delete-report" data-id="<%=f.getId()%>">Delete</button>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
