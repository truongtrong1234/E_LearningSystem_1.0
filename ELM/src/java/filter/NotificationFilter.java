package filter;

import dao.NotificationDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Notification;

@WebFilter("/*") // Áp dụng cho tất cả các trang
public class NotificationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        if (session != null) {
            Account acc = (Account) session.getAttribute("account");
            if (acc != null) {
                // Chỉ thêm khi request chưa có notifications
                if (req.getAttribute("notifications") == null) {
                    NotificationDAO notifDAO = new NotificationDAO();
                    List<Notification> notifications = notifDAO.getNotificationByAccountID(acc.getAccountId());
                    req.setAttribute("notifications", notifications);
                    int unreadCount = notifDAO.countUnread(acc.getAccountId());
request.setAttribute("unreadCount", unreadCount);

                }
                
            }
        }

        chain.doFilter(request, response);
    }
}
