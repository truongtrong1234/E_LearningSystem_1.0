package filter;

import dao.AccountDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

// Áp dụng filter cho cả /admin/* và /Learner/*
@WebFilter({"/admin/*", "/Learner/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        // 🔒 Chặn cache trên mọi trang sau khi login
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // 🚫 Nếu chưa đăng nhập, chuyển hướng về login.jsp
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Account acc = (Account) session.getAttribute("account");

        // 🧠 Tải lại role từ DB để kiểm tra trạng thái mới nhất
        AccountDAO dao = new AccountDAO();
        String latestRole = dao.getRoleById(acc.getAccountId());

        // 🚨 Nếu bị banned → xóa session + chuyển về login với thông báo
        if ("banned".equalsIgnoreCase(latestRole)) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=banned");
            return;
        }

        // ✅ Cho phép truy cập nếu đã đăng nhập
        chain.doFilter(req, res);
    }
}
