package controller;

import dao.NotificationDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Notification;

////@WebServlet("/notiDetail")
public class NotiDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("viewNoti");
            return;
        }

        int id = Integer.parseInt(idParam);
        NotificationDAO dao = new NotificationDAO();
        Notification noti = dao.getNotificationByID(id);

        if (noti != null) {
            dao.updateNotificationIsRead(id, true); //  Đánh dấu là đã đọc khi xem
            request.setAttribute("noti", noti);
            request.getRequestDispatcher("/notiDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("/viewNotifications");
        }
    }
}

