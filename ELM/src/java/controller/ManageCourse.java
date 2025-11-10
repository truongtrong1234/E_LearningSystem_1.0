/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.CourseDAO;
import dao.InstructorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Course;
import model.Instructor;

/**
 *
 * @author ADMIN
 */
public class ManageCourse extends HttpServlet {

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
            out.println("<title>Servlet ManageCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCourse at " + request.getContextPath() + "</h1>");
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

        CategoryDAO categoryDAO = new CategoryDAO();
        CourseDAO courseDAO = new CourseDAO();
        InstructorDAO instructorDAO = new InstructorDAO();

        // Lấy danh sách category và instructor
        List<Category> listCategories = categoryDAO.getAllCat();
        List<Instructor> listInstructors = instructorDAO.getAllInstructors();

        request.setAttribute("listOfCategories", listCategories);
        request.setAttribute("listOfInstructors", listInstructors);

        // Lấy tham số lọc
        String cateID_raw = request.getParameter("cats");
        String instructor_raw = request.getParameter("instructor");
        String keyword = request.getParameter("search");

        Integer cateID = null;
        Integer instructorID = null;

        try {
            if (cateID_raw != null && !cateID_raw.isEmpty()) {
                cateID = Integer.parseInt(cateID_raw);
            }
            if (instructor_raw != null && !instructor_raw.isEmpty()) {
                instructorID = Integer.parseInt(instructor_raw);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Gọi DAO để lọc khóa học
        List<Course> listCourses = courseDAO.searchCourses(keyword, cateID, instructorID);
        request.setAttribute("listCourse", listCourses);

        // Forward về JSP
        request.getRequestDispatcher("/admin/manageCourse.jsp").forward(request, response);
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
