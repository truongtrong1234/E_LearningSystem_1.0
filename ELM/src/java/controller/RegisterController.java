/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form đăng ký
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String workplace = request.getParameter("workplace");
        String phone = request.getParameter("phone");
        String dateOfBirth = request.getParameter("dateofbirth");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        // Kiểm tra xác nhận mật khẩu
        if (confirm == null || !password.equals(confirm)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        AccountDAO dao = new AccountDAO();

        // Kiểm tra email đã tồn tại hay chưa
        Account existing = dao.findByEmail(email);
        if (existing != null) {
            request.setAttribute("errorMessage", "Email này đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Account và gán đầy đủ dữ liệu
        Account account = new Account();
        account.setEmail(email);
        account.setPassword(password);
        account.setName(fullName);
        account.setPicture(null);     // Nếu chưa có ảnh đại diện
        account.setRole("learner");   // Mặc định vai trò là learner
        account.setWorkplace(workplace);
        account.setPhone(phone);
        account.setDateOfBirth(dateOfBirth);
        account.setGender(gender);
        account.setAddress(address);

        // Thêm tài khoản mới vào DB
        boolean success = dao.insert(account);

        if (success) {
            // Đăng ký thành công → chuyển về trang login
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Lỗi khi insert DB
            request.setAttribute("errorMessage", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
