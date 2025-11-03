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
import java.util.List;
import model.Account;
import model.Course;

public class CourseController extends HttpServlet {

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
//        HttpSession session = request.getSession(); 
//        Account account = (Account) session.getAttribute("account"); 
//        int accountID = account.getAccountId(); 
//        CourseDAO cdao = new  CourseDAO(); 
//        List<Course> courseList = cdao.getCourseByInstructorID(accountID); 
//        String action = request.getParameter("action"); 
//        if ("delete".equalsIgnoreCase(action)) {int courseID = Integer.parseInt(request.getParameter("id")); 
//            cdao.deleteCourse(courseID);
//        }
//        request.setAttribute("courseList", courseList);
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
        processRequest(request, response);
        HttpSession session = request.getSession(); 
        Account account = (Account) session.getAttribute("account"); 
        int accountID = account.getAccountId();
        CourseDAO cdao = new  CourseDAO(); 
        List<Course> courseList = cdao.getCourseByInstructorID(accountID); 
        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
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
        int action =Integer.parseInt(request.getParameter("action")) ;
        CourseDAO cdao = new  CourseDAO();
        cdao.deleteCourse(action); 
        response.sendRedirect("/ELM/instructor/dashboard");
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
