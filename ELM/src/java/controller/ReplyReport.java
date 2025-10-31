package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import dao.ReportReplyDAO;
import model.ReportReply;

public class ReplyReport extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reportId = Integer.parseInt(request.getParameter("reportId"));
        String message = request.getParameter("replyMessage");
        int adminId = 1; // Lấy từ session admin login thực tế

        ReportReply reply = new ReportReply();
        reply.setReportId(reportId);
        reply.setAdminId(adminId);
        reply.setReplyMessage(message);
        reply.setRepliedAt(LocalDateTime.now());

        ReportReplyDAO dao = new ReportReplyDAO();
        dao.insertReply(reply);

        response.sendRedirect("reportDetail?id=" + reportId);
    }
}
