/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.GoogleLogin;
import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author Admin
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String email = safe(request.getParameter("email"));
        String password = safe(request.getParameter("password"));

        AccountDAO dao = new AccountDAO();

        //  Tìm tài khoản theo email
        Account account = dao.findByEmail(email);

        if (account == null) {
            // Email không tồn tại
            request.setAttribute("error", "Email không tồn tại!");
            // Không giữ lại email để tránh lỗi người dùng
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (account.getPassword() == null) {
            // Tài khoản Google (password NULL)
            request.setAttribute("error", "Tài khoản này đăng ký bằng Google. Vui lòng đăng nhập bằng Google.");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        Account validAccount = dao.login(email, password);
        if (validAccount != null) {
            //  Thành công
            HttpSession session = request.getSession();
            session.setAttribute("account", validAccount);
            session.setMaxInactiveInterval(60 * 60 * 2); // 2 giờ
            if ("admin@elearn.com".equalsIgnoreCase(validAccount.getEmail())
                    && "123456".equals(validAccount.getPassword())) {
                response.sendRedirect(request.getContextPath() + "/admin/adminIndex");
            } else {
                response.sendRedirect(request.getContextPath() + "/Learner/homeLearnerCourse");
            }
        } else {
            // Sai mật khẩu → giữ lại email
            request.setAttribute("error", "Sai mật khẩu!");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }
}
