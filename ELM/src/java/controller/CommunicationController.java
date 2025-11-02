/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */

public class CommunicationController extends HttpServlet {
   
    
    private static final long serialVersionUID = 1L;

    // Bộ nhớ tạm để lưu tin nhắn trong session
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String message = request.getParameter("message");
        if (message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "Message cannot be empty!");
        }

        // Giả lập danh sách tin nhắn
        List<String> messages = (List<String>) request.getSession().getAttribute("messages");
        if (messages == null) {
            messages = new ArrayList<>();
        }

        // Thêm tin nhắn mới
        if (message != null && !message.trim().isEmpty()) {
            messages.add(message.trim());
        }

        // Lưu lại trong session
        request.getSession().setAttribute("messages", messages);

        // Trả về JSP
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/communication.jsp").forward(request, response);
    }

    // Khi load GET (truy cập lần đầu)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> messages = (List<String>) request.getSession().getAttribute("messages");
        if (messages == null) {
            messages = new ArrayList<>();
        }
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/communication.jsp").forward(request, response);
    }
}