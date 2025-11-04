package controller;

import dao.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.*;

public class CourseDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Lấy courseID từ URL
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("home");
            return;
        }

        int courseID;
        try {
            courseID = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
            return;
        }

        // 2️⃣ Gọi DAO
        CourseDAO cDao = new CourseDAO();
        ChapterDAO chDao = new ChapterDAO();
        LessonDAO lDao = new LessonDAO();
        CategoryDAO catDao = new CategoryDAO();
        AccountDAO aDao = new AccountDAO();
        EnrollmentDAO eDao = new EnrollmentDAO();

        Course course = cDao.getCourseById(courseID);
        if (course == null) {
            response.sendRedirect("home");
            return;
        }

        Account instructor = aDao.getAccountById(course.getInstructorID());
        Category category = catDao.getCategoryById(course.getCategoryID());

        // 3️⃣ Lấy danh sách chương và bài học
        List<Chapter> chapters = chDao.getAllChap();
        chapters.removeIf(ch -> ch.getCourseID() != courseID);

        Map<Integer, List<Lesson>> lessonsMap = new HashMap<>();
        int count=0;
        for (Chapter ch : chapters) {
            count++;
            List<Lesson> lessons = lDao.getByChapterID(ch.getChapterID());
            lessonsMap.put(ch.getChapterID(), lessons);
        }

        // 4️⃣ Kiểm tra đăng ký
        HttpSession session = request.getSession(false);
        String homePage;
        boolean isEnrolled = false;

        if (session != null && session.getAttribute("account") != null) {
            homePage = "Learner/home_learner";

            Account acc = (Account) session.getAttribute("account");
            isEnrolled = eDao.existsEnrollment(acc.getAccountId(), courseID);

        } else {
            homePage = "home_Guest";
        }

        // 5️⃣ Gửi dữ liệu sang JSP
                request.setAttribute("count", count);

        request.setAttribute("course", course);
        request.setAttribute("category", category);
        request.setAttribute("chapters", chapters);
        request.setAttribute("lessons", lessonsMap);
        request.setAttribute("homePage", homePage);
        request.setAttribute("isEnrolled", isEnrolled);
        request.setAttribute("instructor", instructor);

        // 6️⃣ Forward sang JSP
        request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
    }
}
