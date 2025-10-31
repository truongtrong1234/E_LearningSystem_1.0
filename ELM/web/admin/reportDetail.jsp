<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Detail | Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        .main-content {
            margin-left: 15px;
            padding: 30px;
            flex: 1;
            background-color: var(--light-bg);
            
        }
        .report-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .reply-box {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }
        .reply-history {
            margin-top: 25px;
        }
        .reply-item {
            background: #eef3ff;
            border-radius: 8px;
            padding: 10px 15px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <ul>
            <li><a href="adminIndex">Dashboard</a></li>
            <li><a href="manageAccount">Manage Accounts</a></li>
            <li><a href="manageCourse.jsp">Manage Courses</a></li>
            <li><a href="manageReport">User Reports</a></li>
        </ul>
        <div class="logout-btn mt-4">
            <a href="../logout" style="text-decoration: none;">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>📩 Report Detail</h2>

        <c:choose>
            <c:when test="${not empty report}">
                <div class="report-card">
                    <p><strong>ID:</strong> ${report.reportId}</p>
                    <p><strong>Sender:</strong> ${report.senderName} (${report.senderEmail})</p>
                    <p><strong>Title:</strong> ${report.title}</p>
                    <p><strong>Message:</strong></p>
                    <div class="border p-2 rounded">${report.message}</div>
                    <p class="mt-3"><strong>Status:</strong> ${report.status}</p>
                    <p><strong>Created At:</strong> ${report.createdAt}</p>
                </div>

                <!-- Reply history -->
                <c:if test="${not empty replies}">
                    <div class="reply-history">
                        <h4>💬 Previous Replies</h4>
                        <c:forEach var="rep" items="${replies}">
                            <div class="reply-item">
                                <p><strong>Admin #${rep.adminId}</strong> at ${rep.repliedAt}</p>
                                <p>${rep.replyMessage}</p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Reply form -->
                <div class="reply-box">
                    <h5>✏️ Reply to User</h5>
                    <form action="replyReport" method="post">
                        <input type="hidden" name="reportId" value="${report.reportId}">
                        <div class="mb-3">
                            <textarea name="replyMessage" class="form-control" rows="4"
                                      placeholder="Type your reply here..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Reply</button>
                        <a href="manageReport" class="btn btn-secondary">← Back</a>
                    </form>
                </div>
            </c:when>

            <c:otherwise>
                <div class="alert alert-danger mt-4">
                    ⚠️ Report not found or was deleted.
                </div>
                <a href="manageReport" class="btn btn-secondary mt-3">← Back</a>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
