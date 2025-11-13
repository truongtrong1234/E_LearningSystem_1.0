package controller;

import dao.ChapterDAO;
import dao.CourseProgressDAO;
import dao.EnrollmentDAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import model.Account;
import model.Course;
import model.CourseProgress;

public class MyLearningController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int accountID = acc.getAccountId();

        EnrollmentDAO edao = new EnrollmentDAO();
        ChapterDAO chDao = new ChapterDAO();
        CourseProgressDAO cpDao = new CourseProgressDAO();

        // 
        List<Course> myLearningCourse = edao.getCoursesByAccountId(accountID);

        // 
        Map<Integer, Integer> courseProgressMap = new HashMap<>();

        for (Course c : myLearningCourse) {
            int enrollmentID = edao.getEnrollmentID(accountID, c.getCourseID());

            if (enrollmentID != -1) {

                // Kiểm tra CourseProgress đã có chưa
                CourseProgress cp = cpDao.getByEnrollmentID(enrollmentID);
                if (cp == null) {
                    // Chưa có → insert mới với 0%
                    cpDao.insertCourseProgress(enrollmentID, 0);
cp = new CourseProgress(0, enrollmentID, BigDecimal.ZERO);
                }

                // Tính progress dựa trên lesson
                int totalLessons = chDao.countLessonsByCourse(c.getCourseID());
                int completedLessons = chDao.countCompletedLessons(accountID, c.getCourseID());
                int progress = 0;
                if (totalLessons > 0) {
                    progress = (int) ((completedLessons * 100.0) / totalLessons);
                    
                }

                // In ra console để debug
System.out.println("CourseID: " + c.getCourseID() 
    + ", TotalLessons: " + totalLessons 
    + ", CompletedLessons: " + completedLessons 
    + ", Progress: " + progress);
                // Cập nhật vào DB
                cpDao.updateCourseProgress(enrollmentID, progress);

                // Lưu vào map để JSP hiển thị
                courseProgressMap.put(c.getCourseID(), progress);
            }
        }

        // 3️⃣ Gửi dữ liệu sang JSP
        request.setAttribute("myLearningCourse", myLearningCourse);
        request.setAttribute("courseProgressMap", courseProgressMap);

        request.getRequestDispatcher("Learner/mylearning.jsp").forward(request, response);
    }

}
