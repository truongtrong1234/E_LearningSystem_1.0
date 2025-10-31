package controller;

import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Report;

public class ReportDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ReportDAO dao = new ReportDAO();
        Report r = dao.getReportById(id);

        request.setAttribute("report", r);
        request.getRequestDispatcher("/admin/reportDetail.jsp").forward(request, response);
    }
}
