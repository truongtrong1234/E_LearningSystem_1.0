package controller;

import dao.AccountDAO;
import dao.CategoryDAO;
import dao.CourseDAO;
import dao.ChapterDAO;
import dao.EnrollmentDAO;
import dao.LessonDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.Account;
import model.Category;
import model.Course;
import model.Chapter;
import model.Lesson;


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

    // 2️⃣ Gọi DAO để lấy dữ liệu
    CourseDAO cDao = new CourseDAO();
    ChapterDAO chDao = new ChapterDAO();
    LessonDAO lDao = new LessonDAO();
CategoryDAO catDao=new CategoryDAO();
AccountDAO aDao = new AccountDAO(); 
EnrollmentDAO eDao = new EnrollmentDAO(); // 👈 thêm dòng này
    
    Course course = cDao.getCourseById(courseID);
    Account instructor = aDao.getAccountById(course.getInstructorID());
    if (course == null) {
        response.sendRedirect("home");
        return;
    }

      // 🔹 Lấy Category tương ứng với khóa học
Category category = catDao.getCategoryById(course.getCategoryID());
    // thêm dòng này
    // Lấy danh sách chương (chapter)
    List<Chapter> chapters = chDao.getAllChap();
    chapters.removeIf(ch -> ch.getCourseID() != courseID);

    // Map: mỗi chapterID -> danh sách bài học
    Map<Integer, List<Lesson>> lessonsMap = new HashMap<>();
    for (Chapter ch : chapters) {
        List<Lesson> lessons = lDao.getByChapterID(ch.getChapterID());
        lessonsMap.put(ch.getChapterID(), lessons);
    }

    // Xác định người dùng hiện tại là khách hay học viên
    HttpSession session = request.getSession(false);
    String homePage;
    boolean isEnrolled = false; // 👈 thêm biến này
    if (session != null && session.getAttribute("account") != null) {
        homePage = "Learner/home_learner";
    } else {
        homePage = "home_Guest";
    }

    // Gửi dữ liệu sang JSP
    request.setAttribute("course", course);
    request.setAttribute("category", category);
    request.setAttribute("chapters", chapters);
    request.setAttribute("lessons", lessonsMap);
    request.setAttribute("homePage", homePage);
       request.setAttribute("isEnrolled", isEnrolled); // 👈 thêm dòng này
       request.setAttribute("instructor", instructor);


    // Chuyển tiếp tới trang chi tiết khóa học
    request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
}

}
