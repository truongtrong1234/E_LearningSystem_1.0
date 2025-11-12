package controller;

import dao.ReportDAO;
import dao.ReportReplyDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import model.Report;
import model.ReportReply;

public class ReportDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID report từ query (?id=...)
        String id_raw = request.getParameter("id");
        if (id_raw == null || id_raw.isEmpty()) {
            response.sendRedirect("manageReport");
            return;
        }

        int id = Integer.parseInt(id_raw);

        // Lấy thông tin report
        ReportDAO dao = new ReportDAO();
        Report report = dao.getReportById(id);

        // Lấy danh sách reply
        ReportReplyDAO replyDao = new ReportReplyDAO();
        List<ReportReply> replies = replyDao.getRepliesByReportId(id);

        // Gửi dữ liệu sang JSP
        request.setAttribute("report", report);
        request.setAttribute("replies", replies);
        request.getRequestDispatcher("/admin/reportDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        ReportReplyDAO replyDao = new ReportReplyDAO();

        if ("reply".equals(action)) {
            // Gửi phản hồi mới
            int reportId = Integer.parseInt(request.getParameter("reportId"));
            String message = request.getParameter("replyMessage");
            int adminId = 1; // Lấy từ session khi có login admin

            ReportReply reply = new ReportReply();
            reply.setReportId(reportId);
            reply.setAdminId(adminId);
            reply.setReplyMessage(message);
            reply.setRepliedAt(LocalDateTime.now());

            replyDao.insertReply(reply);
            response.sendRedirect("reportDetail?id=" + reportId);

        } else if ("deleteReply".equals(action)) {
            // Xóa phản hồi
            int replyId = Integer.parseInt(request.getParameter("replyId"));
            int reportId = Integer.parseInt(request.getParameter("reportId"));

            replyDao.deleteReply(replyId);
            response.sendRedirect("reportDetail?id=" + reportId);
        } else if ("updateStatus".equals(action)) {
            int reportId = Integer.parseInt(request.getParameter("reportId"));
            String newStatus = request.getParameter("status");

            ReportDAO dao = new ReportDAO();
            dao.updateStatus(reportId, newStatus);

            response.sendRedirect("reportDetail?id=" + reportId);
        }

    }
}
