package controller;

import dao.NotificationDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Notification;

//@WebServlet("/viewNotifications")
public class ViewNotificationsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        // Nếu chưa đăng nhập
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy danh sách thông báo theo tài khoản
        NotificationDAO dao = new NotificationDAO();
        List<Notification> list = dao.getNotificationByAccountID(acc.getAccountId());
        request.setAttribute("notifications", list);

        // Điều hướng theo vai trò tài khoản
        String role = acc.getRole();

        if (role != null && role.equalsIgnoreCase("Admin")) {
            // Admin → notiAdmin.jsp
            request.getRequestDispatcher("/admin/notiAdmin.jsp").forward(request, response);
        } else {
            // Learner hoặc Instructor → viewNotifications.jsp
            request.getRequestDispatcher("/viewNotifications.jsp").forward(request, response);
        }
    }
}
