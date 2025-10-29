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
import java.util.List;
import model.Course;


// @WebServlet("/searchCourse")
public class SearchCourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword"); 
        List<Course> courses = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            CourseDAO dao = new CourseDAO();
            courses = dao.searchCourses(keyword.trim());
            
        request.setAttribute("courses", courses);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("SearchResults.jsp").forward(request, response);
        }
      else {
    // Không thực hiện search
   
     request.getRequestDispatcher("Learner/homeLearnerCourse").forward(request, response);
}

    }
}

