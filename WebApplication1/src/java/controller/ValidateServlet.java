package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;

public class ValidateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String id = request.getParameter("id");
        String email = request.getParameter("email");

        request.setAttribute("email", email);
        request.setAttribute("fullname", fullname);
        request.setAttribute("id", id);

        boolean hasError = false;

        // Email
        if (!email.contains("@"))
        {
            request.setAttribute("emailError", "Email phải có ký tự '@'.");
            hasError = true;
        }
        else if (!email.matches(".*\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("emailError", "Email phải có phần domain (ví dụ .com hoặc .vn).");
            hasError = true;
        }

        // Password
        if (password.length() < 12)
        {
            request.setAttribute("passwordError", "Mật khẩu phải có ít nhất 12 ký tự.");
            hasError = true;
        }
        else if (!password.matches(".*[A-Z].*")) {
            request.setAttribute("passwordError", "Mật khẩu phải chứa ít nhất một chữ hoa.");
            hasError = true;
        }
        else if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            request.setAttribute("passwordError", "Mật khẩu phải có ký tự đặc biệt.");
            hasError = true;
        }
        else if (!password.matches(".*[0-9].*")) {
            request.setAttribute("passwordError", "Mật khẩu phải chứa ít nhất một chữ số.");
            hasError = true;
        }

        // Full Name
        if (!fullname.matches("^[a-zA-Z\\sÀ-ỹ]+$")) {
            request.setAttribute("fullnameError", "Tên không được chứa số hoặc ký tự đặc biệt.");
            hasError = true;
        }
        else if (fullname.length() < 2 || fullname.length() > 50) {
            request.setAttribute("fullnameError", "Tên phải từ 2 đến 50 ký tự.");
            hasError = true;
        }

        // ID
        if (!id.matches("^[A-Z]{2}.*")) {
            request.setAttribute("idError", "ID phải bắt đầu bằng 2 chữ cái.");
            hasError = true;
        }
        else if (id.length() < 6 || id.length() > 9) {
            request.setAttribute("idError", "ID phải có độ dài từ 6 đến 9 ký tự.");
            hasError = true;
        }
        else if (id.contains(" ") || id.matches(".*[^A-Za-z0-9].*")) {
            request.setAttribute("idError", "ID không được chứa ký tự đặc biệt hoặc dấu cách.");
            hasError = true;
        }

        // Nếu không có lỗi
        if (!hasError) {
            request.setAttribute("emailError", "✅ Tất cả hợp lệ!");
        }

        // Quay lại form
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
    