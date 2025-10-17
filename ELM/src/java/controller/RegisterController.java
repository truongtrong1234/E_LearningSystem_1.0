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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        AccountDAO adao = new AccountDAO();
        Account account = new Account(email, password, fullName);
        boolean isInserted = adao.insert(account);
        if (isInserted) {
            response.sendRedirect("home");
        } else {
            request.setAttribute("errorMessage", "Đăng ký không thành công! Vui lòng thử lại.");
             request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    /*    // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("account", acc);
            // Đăng nhập thành công → về home
            response.sendRedirect("home.jsp");
        } else {
            // Sai thông tin → gửi lỗi lại login.jsp
            request.setAttribute("error", "Email hoặc mật khẩu sai!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
