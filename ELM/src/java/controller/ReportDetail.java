package controller;

import dao.ReportDAO;
import dao.ReportReplyDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Report;
import model.ReportReply;

public class ReportDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ReportDAO dao = new ReportDAO();
        Report r = dao.getReportById(id);

        ReportReplyDAO replyDao = new ReportReplyDAO();
        List<ReportReply> replies = replyDao.getRepliesByReportId(id);
        
        request.setAttribute("report", r);
        request.setAttribute("replies", replies);
        request.getRequestDispatcher("/admin/reportDetail.jsp").forward(request, response);
    }
}
