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
import model.Chapter;
import model.Question;

public class ViewCourseDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id_raw = request.getParameter("id");
        if (id_raw == null || id_raw.isEmpty()) {
            response.sendRedirect("manageCourse");
            return;
        }

        int courseID = Integer.parseInt(id_raw);

        CourseDAO courseDAO = new CourseDAO();
        LessonDAO lessonDAO = new LessonDAO();
        QuizDAO quizDAO = new QuizDAO();
        ChapterDAO chapterDAO = new ChapterDAO();
        QuestionDAO questionDAO = new QuestionDAO();
        InstructorDAO instructorDAO = new InstructorDAO();
        
//
//        // Lấy thông tin khóa học
//        Course course = courseDAO.getCourseById(courseID);
//
//        // Lấy danh sách bài học
//        List<Lesson> lessons = lessonDAO.getByCourseID(courseID);
//
//        // Lấy danh sách quiz & đáp án
//        List<Quiz> quizzes = quizDAO.getQuizzesByCourseID(courseID);
//
//        request.setAttribute("course", course);
//        request.setAttribute("lessons", lessons);
//        request.setAttribute("quizzes", quizzes);
//
//        request.getRequestDispatcher("/admin/ViewCourseDetail.jsp").forward(request, response);
// 1. Lấy course
Course course = courseDAO.getCourseById(courseID);

Instructor instructor = instructorDAO.getInstructorByCourseID(courseID);

// 2. Lấy chapters
List<Chapter> chapters = chapterDAO.getChaptersByCourseId(courseID);
course.setChapters(chapters);

// 3. Lấy quizzes & questions
Map<Integer, List<Quiz>> quizzesMap = new HashMap<>();
Map<Integer, List<Question>> questionsMap = new HashMap<>();

for (Chapter ch : chapters) {
    List<Quiz> quizzes = quizDAO.getQuizzesByChapter(ch.getChapterID());
    quizzesMap.put(ch.getChapterID(), quizzes);

    for (Quiz qz : quizzes) {
        List<Question> questions = questionDAO.getQuestionsByQuizID(qz.getQuizID());
        questionsMap.put(qz.getQuizID(), questions);
    }
}
request.setAttribute("instructor", course);
request.setAttribute("course", course);
request.setAttribute("quizzesMap", quizzesMap);
request.setAttribute("questionsMap", questionsMap);

request.getRequestDispatcher("/admin/ViewCourseDetail.jsp").forward(request, response);

    }
}
