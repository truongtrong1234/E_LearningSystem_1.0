package controller;

import dao.CategoryDAO;
import dao.CourseDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Category;
import model.Course;


public class HomeLearnerCourse extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Load Categories
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> listCategories = categoryDAO.getAllCat();
        request.setAttribute("listOfCategories", listCategories);

        // Load Courses
        CourseDAO courseDAO = new CourseDAO();
        List<Course> listCourses = courseDAO.getTop5MostEnrolledCourses();
        request.setAttribute("listCourse", listCourses);
        
//        //noti
//              NotificationDAO notifDAO = new NotificationDAO();
//        List<Notification> notifications = notifDAO.getNotificationByAccountID(acc.getAccountId());
//
//        request.setAttribute("notifications", notifications);

        // Forward tới JSP
        request.getRequestDispatcher("/Learner/home_learner.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "HomeController loads both categories and courses";
    }
}
