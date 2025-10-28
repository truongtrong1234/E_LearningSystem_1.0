package controller;

import dao.CategoryDAO;
import dao.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Course;

public class HomeLearnerCourse extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        // Load Categories
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> listCategories = categoryDAO.getAllCat();
        request.setAttribute("listOfCategories", listCategories);

        // Load Courses
        CourseDAO courseDAO = new CourseDAO();
        List<Course> listCourses = courseDAO.getAllCourses();
        request.setAttribute("listCourse", listCourses);

        // Forward tới JSP
        request.getRequestDispatcher("/Learner/home_learner.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "HomeController loads both categories and courses";
    }
}
