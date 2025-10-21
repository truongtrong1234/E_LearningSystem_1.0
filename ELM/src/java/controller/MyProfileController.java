package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/myProfile")
public class MyProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Giả lập dữ liệu — sau này có thể lấy từ database
        request.setAttribute("name", "Eric Nguyen");
        request.setAttribute("email", "nguyen.quang.hoang.anh@fpt.edu.vn");
        request.setAttribute("course", "Web Development - Java Servlet & JSP");

        // Chuyển đến JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("myProfile.jsp");
        dispatcher.forward(request, response);
    }
}
