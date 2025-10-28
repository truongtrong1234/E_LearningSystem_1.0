<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<html>
<head>
    <title>Admin Dashboard | E-Learning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <a href="index.jsp">🏠 Dashboard</a>
        <a href="admin.jsp#accounts">👤 Accounts</a>
        <a href="admin.jsp#courses">📚 Courses</a>
        <a href="admin.jsp#feedback">💬 Feedback</a>
    </div>

    <div class="content">
        <h1>Welcome, Admin!</h1>
        <p>Quản lý hệ thống e-learning của bạn từ một nơi duy nhất.</p>

        <div class="dashboard-cards">
            <%
                int userCount = 0, courseCount = 0, feedbackCount = 0;
                try (Connection conn = DBConnection.getConnection()) {
                    Statement st = conn.createStatement();

                    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users");
                    if (rs1.next()) userCount = rs1.getInt(1);

                    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM courses");
                    if (rs2.next()) courseCount = rs2.getInt(1);

                    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM feedback");
                    if (rs3.next()) feedbackCount = rs3.getInt(1);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            <div class="card">
                <h3>👥 Users</h3>
                <p><%= userCount %></p>
                <a href="admin.jsp#accounts">Manage</a>
            </div>

            <div class="card">
                <h3>📘 Courses</h3>
                <p><%= courseCount %></p>
                <a href="admin.jsp#courses">Manage</a>
            </div>

            <div class="card">
                <h3>💬 Feedback</h3>
                <p><%= feedbackCount %></p>
                <a href="admin.jsp#feedback">Manage</a>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>            
</body>
</html>
