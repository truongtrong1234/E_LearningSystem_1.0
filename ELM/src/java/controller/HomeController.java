package controller;

import dao.CategoryDAO;
import dao.CourseDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Course;

//homeGuestControler
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1️⃣ Tạo DAO
        CourseDAO courseDAO = new CourseDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // 2️⃣ Lấy danh sách khoá học & danh mục
        List<Course> listCourse = courseDAO.getAllCourses();
        List<Category> listOfCategories = categoryDAO.getAllCat();

        // 3️⃣ Gửi sang JSP
        request.setAttribute("listCourse", listCourse);
        request.setAttribute("listOfCategories", listOfCategories);

        // 4️⃣ Forward tới home_guest.jsp
        request.getRequestDispatcher("home_Guest.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Home page for guest users";
    }
}
