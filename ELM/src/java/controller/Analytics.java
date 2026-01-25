/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import model.Enrollment;
import model.StudentProgress;

public class Analytics extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Analytics</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Analytics at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = (Account) request.getSession().getAttribute("account");
        int instructorID = acc.getAccountId();
        Course course = new Course(); 
        CourseDAO cdao = new CourseDAO(); 
        List<Course> listCourse = cdao.getCourseByInstructorID(instructorID);
        int totalCourses= listCourse.size(); 
        EnrollmentDAO enrollmentDAO = new EnrollmentDAO(); 
        
        List<StudentProgress> studentList = enrollmentDAO.getStudentProgress(instructorID);
        int totalLearners = enrollmentDAO.getTotalLearners(instructorID); 
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalLearners", totalLearners);
        request.setAttribute("studentList", studentList);

        request.getRequestDispatcher("/instructor/analytics.jsp")
                .forward(request, response);
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
