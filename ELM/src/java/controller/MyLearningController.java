package controller;

import dao.ChapterDAO;
import dao.CourseProgressDAO;
import dao.EnrollmentDAO;
import dao.QuizProgressDAO;
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
import model.QuizProgress;

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
        String myResult = request.getParameter("myResult");
        EnrollmentDAO edao = new EnrollmentDAO();
        ChapterDAO chDao = new ChapterDAO();
        CourseProgressDAO cpDao = new CourseProgressDAO();
        List<Course> myLearningCourse = edao.getCoursesByAccountId(accountID);
        Map<Integer, Integer> courseProgressMap = new HashMap<>();

        for (Course c : myLearningCourse) {
            int enrollmentID = edao.getEnrollmentID(accountID, c.getCourseID());

            if (enrollmentID != -1) {

                CourseProgress cp = cpDao.getByEnrollmentID(enrollmentID);
                if (cp == null) {
                    cpDao.insertCourseProgress(enrollmentID, 0);
                    cp = new CourseProgress(0, enrollmentID, BigDecimal.ZERO);
                }
                int totalLessons = chDao.countLessonsByCourse(c.getCourseID());
                int completedLessons = chDao.countCompletedLessons(accountID, c.getCourseID());
                int progress = 0;
                if (totalLessons > 0) {
                    progress = (int) ((completedLessons * 100.0) / totalLessons);
                }
                System.out.println("CourseID: " + c.getCourseID()
                        + ", TotalLessons: " + totalLessons
                        + ", CompletedLessons: " + completedLessons
                        + ", Progress: " + progress);
                cpDao.updateCourseProgress(enrollmentID, progress);
                courseProgressMap.put(c.getCourseID(), progress);
            }
        }
        request.setAttribute("myLearningCourse", myLearningCourse);
        request.setAttribute("courseProgressMap", courseProgressMap);
        QuizProgressDAO quizproDAO = new QuizProgressDAO(); 
        List<QuizProgress> listResult = quizproDAO.getQuizProgressByAccount(accountID); 
        request.setAttribute("myResults", myResult);
        request.setAttribute("listResult", listResult);
        request.getRequestDispatcher("Learner/mylearning.jsp").forward(request, response);
    }

}
