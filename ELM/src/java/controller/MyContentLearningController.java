package controller;

import dao.ChapterDAO;
import dao.ChapterProgressDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import dao.LessonDAO;
import dao.LessonProgressDAO;
import dao.MaterialDAO;
import dao.QnADAO;
import dao.QuizDAO;
import dao.QuizProgressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Chapter;
import model.Course;
import model.Lesson;
import model.Material;
import model.QnAQuestion;
import model.QnAReply;
import model.Quiz;
import model.QuizProgress;

/**
 *
 * @author HPC
 */
///@WebServlet(name="MyLearningContentServlet", value="/Learner/myLearningContent")
public class MyContentLearningController extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private ChapterDAO chapterDAO = new ChapterDAO();
    private LessonDAO lessonDAO = new LessonDAO();
    private MaterialDAO materialDAO = new MaterialDAO();
    private QuizDAO quizDAO = new QuizDAO();
    private QuizProgressDAO quizProgressDAO = new QuizProgressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int courseID = Integer.parseInt(request.getParameter("CourseID"));
        int lessonID = 0;

        Course course = courseDAO.getCourseById(courseID);
        if (request.getParameter("LessonID") != null) {
            lessonID = Integer.parseInt(request.getParameter("LessonID"));
        }

        // 🟢 Lấy Enrollment
        int enrollmentID = enrollmentDAO.getEnrollmentID(account.getAccountId(), courseID);
        request.setAttribute("enrollmentID", enrollmentID);

        List<Chapter> chapterList = chapterDAO.getChaptersByCourseId(courseID);
        Map<Integer, List<Lesson>> chapterLessonMap = new LinkedHashMap<>();
        for (Chapter ch : chapterList) {
            List<Lesson> lessons = lessonDAO.getByChapterID(ch.getChapterID());
            chapterLessonMap.put(ch.getChapterID(), lessons);
        }
        Map<Integer, List<Quiz>> chapterQuizMap = new LinkedHashMap<>();
        for (Chapter ch : chapterList) {
            List<Quiz> quizzes = quizDAO.getQuizzesByChapter(ch.getChapterID());
            chapterQuizMap.put(ch.getChapterID(), quizzes);
        }
        List<Quiz> quizList = quizDAO.getQuizzesByCourseID(courseID);
        Map<String, BigDecimal> QuizMap = new LinkedHashMap<>();
        for (Quiz quiz : quizList) {
            QuizProgress progress = quizProgressDAO.getQuizProgressByAccountAndQuiz(account.getAccountId(), quiz.getQuizID());
            if (progress==null) {
                
            }
            BigDecimal totalscore = (progress != null) ? progress.getTotalScore() : null; 
            QuizMap.put(quiz.getTitle(),totalscore );
        }

        // 🟢 Lấy map tiến độ của lesson
        LessonProgressDAO lessonProgressDAO = new LessonProgressDAO();
        Map<Integer, Boolean> lessonCompletedMap = lessonProgressDAO.getLessonCompletionMap(account.getAccountId(), courseID);

        // 🟢 Chọn lesson hiển thị
        if (lessonID == 0) {
            outerLoop:
            for (Chapter ch : chapterList) {
                List<Lesson> lessons = chapterLessonMap.get(ch.getChapterID());
                for (Lesson l : lessons) {
                    if (!lessonCompletedMap.getOrDefault(l.getLessonID(), false)) {
                        lessonID = l.getLessonID(); // lesson chưa học đầu tiên
                        break outerLoop;
                    }
                }
            }
            // Nếu tất cả lesson đã học → chọn lesson cuối cùng
            if (lessonID == 0) {
                if (chapterList != null && !chapterList.isEmpty()) {
                    Chapter lastChapter = chapterList.get(chapterList.size() - 1);
                    List<Lesson> lastLessons = chapterLessonMap.get(lastChapter.getChapterID());

                    if (lastLessons != null && !lastLessons.isEmpty()) {
                        lessonID = lastLessons.get(lastLessons.size() - 1).getLessonID();
                    } else {
                        System.out.println("⚠️ lastLessons rỗng, không có bài học nào trong chương cuối cùng.");
                    }
                } else {
                    System.out.println("⚠️ chapterList rỗng, khóa học chưa có chương nào.");
                }
            }
        }

        //  Lấy materials của lesson được chọn
        List<Material> materials = materialDAO.getByLessonID(lessonID);

        // Gửi dữ liệu sang JSP
        request.setAttribute("account", account);
        request.setAttribute("chapterLessonMap", chapterLessonMap);
        request.setAttribute("chapterQuizMap", chapterQuizMap);
        request.setAttribute("materials", materials);
        request.setAttribute("selectedLessonID", lessonID);
        request.setAttribute("CourseID", courseID);
        request.setAttribute("lessonCompletedMap", lessonCompletedMap);
        request.setAttribute("course", course);
        request.setAttribute("chapterList", chapterList);
        request.setAttribute("QuizMap", QuizMap);

        // Nếu có chapterCompletedMap bạn vẫn có thể gửi sang JSP
        ChapterProgressDAO chapterProgressDAO = new ChapterProgressDAO();
        Map<Integer, Boolean> chapterCompletedMap = chapterProgressDAO.getChapterCompletionMap(account.getAccountId(), courseID);
        request.setAttribute("chapterCompletedMap", chapterCompletedMap);

        //hoi dap
        QnADAO qnaDAO = new QnADAO();
        List<QnAQuestion> qnaList = qnaDAO.getQuestionsByCourse(courseID);
        System.out.println("qnalist: " + qnaList.size());
        Map<Integer, List<QnAReply>> replyMap = new HashMap<>();

        for (QnAQuestion q : qnaList) {
            List<QnAReply> replies = qnaDAO.getRepliesByQnAID(q.getQnaID());
            replyMap.put(q.getQnaID(), replies);

            System.out.println("Replies for QnA " + q.getQnaID() + ": " + replies.size());

        }

        request.setAttribute("qnaList", qnaList);
        request.setAttribute("replyMap", replyMap);

        request.getRequestDispatcher("/Learner/mylearning_content.jsp").forward(request, response);
    }

}
