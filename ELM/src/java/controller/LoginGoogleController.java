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
import model.GoogleAccount;

public class LoginGoogleController extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String token = gg.getToken(code);
        GoogleAccount access = gg.getUserInfo(token);
        AccountDAO adao = new AccountDAO(); 
        Account account = adao.insertOrUpdateFromGoogle(access); 
        if (account != null && "banned".equalsIgnoreCase(account.getRole())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa, vui lòng liên hệ quản trị viên!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("account", account);
        request.getRequestDispatcher("loginSuccess.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
