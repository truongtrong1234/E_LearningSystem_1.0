<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="context.DBContext" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex.jsp">Dashboard</a></li>
            <li><a href="adminAccount">Manage Accounts</a></li>
            <li><a href="viewCourses.jsp">Manage Courses</a></li>
            <li><a href="adminReport.jsp">User Reports</a></li>
        </ul>
        <div class="logout-btn">
            <a href="../home_Guest">Logout</a>
        </div>
    </div>


    <div class="main-content">
        <h1>Admin Dashboard</h1>
        <div class="dashboard-cards">
            <%
                int userCount = 0, courseCount = 0, feedbackCount = 0;
                try {
                    DBContext db = new DBContext();
                    Connection conn = db.getConnection();
                    Statement st = conn.createStatement();

                    // Đếm user
                    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM Users");
                    if (rs1.next()) userCount = rs1.getInt(1);
                    rs1.close();

                    // Đếm course
                    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM Courses");
                    if (rs2.next()) courseCount = rs2.getInt(1);
                    rs2.close();

                    // Đếm feedback
                    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM Feedback");
                    if (rs3.next()) feedbackCount = rs3.getInt(1);
                    rs3.close();

                    st.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            <div class="card orange">
                <h3>User Accounts</h3>
                <p><%= userCount %></p>
            </div>

            <div class="card orange">
                <h3>Courses</h3>
                <p><%= courseCount %></p>
            </div>

            <div class="card orange">
                <h3>Feedback</h3>
                <p><%= feedbackCount %></p>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
