package controller;

import dao.AccountDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Course;

public class MyProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account sessionAccount = (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy lại thông tin chi tiết
        AccountDAO dao = new AccountDAO();
        Account acc = dao.getAccountById(sessionAccount.getAccountId());

        // 1️⃣ Khóa học đã tạo (Instructor)
        CourseDAO courseDAO = new CourseDAO();
        List<Course> createdCourses = courseDAO.getCourseByInstructorID(acc.getAccountId());

        // 2️⃣ Khóa học đang học (Enrollments)
        EnrollmentDAO enrollDAO = new EnrollmentDAO();
        List<Course> enrolledCourses = enrollDAO.getCoursesByAccountId(acc.getAccountId());

        // Gửi dữ liệu sang JSP
        request.setAttribute("account", acc);
        request.setAttribute("createdCourses", createdCourses);
        request.setAttribute("enrolledCourses", enrolledCourses);

        RequestDispatcher dispatcher = request.getRequestDispatcher("myProfile.jsp");
        dispatcher.forward(request, response);
    }
}
