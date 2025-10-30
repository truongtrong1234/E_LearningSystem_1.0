package controller;

import dao.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;

//@WebServlet("/searchCourse")
public class SearchCourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("cats");

        CourseDAO dao = new CourseDAO();
        List<Course> listCourse = null; // ✅ Đổi tên để khớp với JSP

        try {
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                // 🔹 Lọc theo category
                int categoryId = Integer.parseInt(categoryIdParam);
                listCourse = dao.getCoursesByCategory(categoryId);

            } else if (keyword != null && !keyword.trim().isEmpty()) {
                // 🔹 Tìm theo keyword
                listCourse = dao.searchCourses(keyword.trim());

            } else {
                // 🔹 Không có điều kiện => lấy tất cả
                listCourse = dao.getAllCourses();
            }

        } catch (SQLException ex) {
            Logger.getLogger(SearchCourseController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // ✅ Gửi dữ liệu cho JSP
        request.setAttribute("listCourse", listCourse); // khớp với <c:forEach items="${listCourse}">
        request.setAttribute("keyword", keyword);

        // ✅ Forward đến trang kết quả
        request.getRequestDispatcher("SearchResults.jsp").forward(request, response);
    }
}
