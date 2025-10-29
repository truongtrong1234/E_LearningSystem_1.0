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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;


// @WebServlet("/searchCourse")
public class SearchCourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword"); 
        String categoryIdParam = request.getParameter("cats"); // category filter
        List<Course> courses = null;

        CourseDAO dao = new CourseDAO();

  
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                // Lọc theo category
                System.out.println("c");
                int categoryId = Integer.parseInt(categoryIdParam);
                System.out.println("ca");
            try {
                courses = dao.getCoursesByCategory(categoryId);
            } catch (SQLException ex) {
                Logger.getLogger(SearchCourseController.class.getName()).log(Level.SEVERE, null, ex);
            }
                System.out.println("cat");
                

            } else if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm theo keyword
                courses = dao.searchCourses(keyword.trim());
            } else {
                // Không filter hay search => load tất cả
                courses = dao.getAllCourses();
            }

            request.setAttribute("courses", courses);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("SearchResults.jsp").forward(request, response);

       
        
    }
}

