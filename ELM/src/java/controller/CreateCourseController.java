/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Date;
import model.Account;
import model.Course;

public class CreateCourseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("instructor/createCourse.jsp").forward(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         request.setCharacterEncoding("UTF-8");
            CourseDAO cdao = new CourseDAO(); 

            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("account");

            if (account == null) {
                // Nếu chưa đăng nhập thì chuyển hướng đến trang login
                response.sendRedirect("login.jsp");
                return;
            }
            
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int instructorID = account.getAccountId();
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String thumbnail = request.getParameter("thumbnail");

            Course course = new Course();
            course.setTitle(title);
            course.setDescription(description);
            course.setInstructorID(instructorID);
            course.setPrice(price);
            course.setCreatedAt(new Date());
            course.setCategoryID(categoryID);
            course.setThumbnail(thumbnail);

            boolean success = cdao.insertCourse(course);

            if (success) {
                request.setAttribute("message", "✅ Tạo khóa học thành công!");
            } else {
                request.setAttribute("message", "❌ Tạo khóa học thất bại!");
            }

            request.getRequestDispatcher("create_course.jsp").forward(request, response);
    }
}
