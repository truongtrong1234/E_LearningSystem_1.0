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

    <style>
        /* Tùy chỉnh riêng cho trang Report */
        .report-container {
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: 0 4px 8px var(--shadow);
            overflow: hidden;
        }

        .report-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s ease;
            cursor: pointer;
        }

        .report-item:hover {
            background-color: #fff4eb;
        }

        .report-info {
            flex-grow: 1;
            overflow: hidden;
        }

        .report-info strong {
            color: var(--main-orange);
        }

        .report-message {
            color: #555;
            margin-top: 4px;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 600px;
        }

        .report-date {
            color: #999;
            font-size: 13px;
            margin-right: 20px;
            white-space: nowrap;
        }

        .btn-delete {
            border: none;
            background: none;
            color: #dc3545;
            font-weight: 600;
            cursor: pointer;
            transition: color 0.2s;
        }

        .btn-delete:hover {
            color: #b52a35;
            text-decoration: underline;
        }

        .no-report {
            padding: 30px;
            text-align: center;
            color: #777;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex.jsp">Dashboard</a></li>
            <li><a href="viewUsers.jsp">Manage Accounts</a></li>
            <li><a href="viewCourses.jsp">Manage Courses</a></li>
            <li><a href="adminReport.jsp" class="active">User Reports</a></li>
        </ul>
        <div class="logout-btn">
            <a href="../logout.jsp">Logout</a>
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

    <script>
        // Xử lý xoá báo cáo
        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const id = this.dataset.id;
                if (confirm("Delete this report?")) {
                    fetch("deleteReport.jsp?id=" + id)
                        .then(() => location.reload());
                }
            });
        });
    </script>

</body>
</html>
