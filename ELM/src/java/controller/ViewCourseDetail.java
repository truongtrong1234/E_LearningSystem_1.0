package controller;

import dao.CourseDAO;
import dao.LessonDAO;
import dao.ChapterDAO;
import dao.QuizDAO;
import dao.QuestionDAO;
import dao.InstructorDAO;
import model.Course;
import model.Lesson;
import model.Quiz;
import model.Question;
import model.Instructor;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Chapter;
import model.Question;

public class ViewCourseDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        // Kiểm tra quyền admin
        if (acc == null || !"admin".equals(acc.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int courseID = Integer.parseInt(request.getParameter("CourseID"));

        CourseDAO courseDao = new CourseDAO();
        ChapterDAO chapterDao = new ChapterDAO();
        LessonDAO lessonDao = new LessonDAO();
        QuizDAO quizDao = new QuizDAO();

        // Lấy thông tin khóa học
        Course course = courseDao.getCourseById(courseID);

        // Lấy danh sách chương
        List<Chapter> chapterList = chapterDao.getChaptersByCourseId(courseID);

        // Map chương → danh sách bài học
        Map<Integer, List<Lesson>> chapterLessonMap = new HashMap<>();

        // Map chương → danh sách quiz
        Map<Integer, List<Quiz>> chapterQuizMap = new HashMap<>();

        for (Chapter c : chapterList) {
            List<Lesson> lessons = lessonDao.getByChapterID(c.getChapterID());
            chapterLessonMap.put(c.getChapterID(), lessons);

            List<Quiz> quizzes = quizDao.getQuizzesByChapter(c.getChapterID());
            chapterQuizMap.put(c.getChapterID(), quizzes);
        }

        // Set attribute cho JSP
        request.setAttribute("course", course);
        request.setAttribute("chapterList", chapterList);
        request.setAttribute("chapterLessonMap", chapterLessonMap);
        request.setAttribute("chapterQuizMap", chapterQuizMap);

        request.getRequestDispatcher("/admin/viewCourseDetail.jsp").forward(request, response);
    }
}
