package controller;

import dao.ReportDAO;
import model.Report;
import model.Account; // giả sử bạn đã có model này
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SendReport extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin người gửi từ session
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String title = request.getParameter("subject");
        String message = request.getParameter("description");

        // Tạo đối tượng Report
        Report report = new Report();
        report.setAccountId(acc.getAccountId());
        report.setTitle(title);
        report.setMessage(message);
        report.setStatus("Pending"); // trạng thái mặc định

        // Gọi DAO để lưu vào DB
        ReportDAO dao = new ReportDAO();
        boolean success = dao.insertReport(report);

        // Gửi thông báo kết quả về lại JSP
        if (success) {
            request.setAttribute("message", "Report has been sent successfully!");
            request.setAttribute("status", "success");
        } else {
            request.setAttribute("message", "Failed to send report. Please try again.");
            request.setAttribute("status", "error");
        }

        // Quay lại trang sendReport.jsp
        request.getRequestDispatcher("/instructor/sendReport.jsp").forward(request, response);
    }
}
