<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="context.DBContext" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Reports | Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex.jsp">Dashboard</a></li>
            <li><a href="manageAccount.jsp">Manage Accounts</a></li>
            <li><a href="manageCourse.jsp">Manage Courses</a></li>
            <li><a href="manageReport.jsp" class="active">User Reports</a></li>
        </ul>
        <div class="logout-btn">
            <a href="../home_Guest">Logout</a>
        </div>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <h1>User Reports</h1>

        <div class="report-container">
            <%
                try {
                    DBContext db = new DBContext();
                    Connection conn = db.getConnection();
                    String sql = "SELECT f.FeedbackID, f.SenderID, u.FullName, f.Message, f.CreatedAt " +
                                 "FROM Feedback f LEFT JOIN Users u ON f.SenderID = u.UserID " +
                                 "ORDER BY f.CreatedAt DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                        int id = rs.getInt("FeedbackID");
                        String sender = rs.getString("FullName");
                        if (sender == null || sender.trim().isEmpty()) sender = "(Unknown)";
                        String message = rs.getString("Message");
                        Timestamp createdAt = rs.getTimestamp("CreatedAt");
            %>

            <div class="report-item" id="report-<%=id%>">
                <div class="report-info">
                    <strong>ID: <%=id%></strong> — 
                    <span>User: <%=sender%></span>
                    <div class="report-message"><%=message%></div>
                </div>
                <div class="report-date"><%=createdAt%></div>
                <button class="btn-delete" data-id="<%=id%>">🗑 Delete</button>
            </div>

            <%
                    }
                    if (!hasData) {
            %>
                <div class="no-report">No reports found.</div>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <div class="alert alert-danger">Error loading reports!</div>
            <%
                }
            %>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
