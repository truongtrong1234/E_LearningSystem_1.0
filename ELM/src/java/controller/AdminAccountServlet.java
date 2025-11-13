/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.Course;

/**
 *
 * @author ADMIN
 */
public class AdminAccountServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAccountServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        if ("detail".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Account acc = dao.getAccountById(id);

            if (acc == null) {
                response.sendRedirect("manageAccount?error=notfound");
                return;
            }
// 1️⃣ Khóa học đã tạo (Instructor)
            CourseDAO courseDAO = new CourseDAO();
            List<Course> createdCourses = courseDAO.getCourseByInstructorID(acc.getAccountId());

            // 2️⃣ Khóa học đang học (Enrollments)
            EnrollmentDAO enrollDAO = new EnrollmentDAO();
            List<Course> enrolledCourses = enrollDAO.getCoursesByAccountId(acc.getAccountId());

            request.setAttribute("account", acc);
            request.setAttribute("createdCourses", createdCourses);
            request.setAttribute("enrolledCourses", enrolledCourses);

            request.getRequestDispatcher("/admin/accountDetail.jsp").forward(request, response);
            return;
        }

        // Các action khác như delete, removeRole, v.v...
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
