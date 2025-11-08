package controller;

import dao.QuestionDAO;
import dao.QuizDAO;
import model.Quiz;
import model.Question;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CreateQuizController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseID = parseIntSafe(request.getParameter("courseID"));
        int chapterID = parseIntSafe(request.getParameter("ChapterID"));

        Object courseAttr = request.getAttribute("courseID");
        Object chapterAttr = request.getAttribute("thisChapterID");
        if (courseAttr != null) courseID = parseIntSafe(courseAttr.toString());
        if (chapterAttr != null) chapterID = parseIntSafe(chapterAttr.toString());

        request.setAttribute("courseID", courseID);
        request.setAttribute("thisChapterID", chapterID);

        // Lần đầu mở form, tạo 1 question trống
        List<Question> questions = (List<Question>) request.getAttribute("questions");
        if (questions == null) {
            questions = new ArrayList<>();
            questions.add(new Question());
        }

        request.setAttribute("questions", questions);
        request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        int courseID = parseIntSafe(request.getParameter("thisCourseID"));
        int chapterID = parseIntSafe(request.getParameter("thisChapterID"));
        String quizTitle = request.getParameter("quizTitle");

        // Lấy danh sách question từ request
        List<Question> questions = new ArrayList<>();
        int totalQuestions = parseIntSafe(request.getParameter("totalQuestions"), 1);
        for (int i = 1; i <= totalQuestions; i++) {
            Question q = new Question();
            q.setQuestionText(request.getParameter("questionText" + i));
            q.setOptionA(request.getParameter("optionA" + i));
            q.setOptionB(request.getParameter("optionB" + i));
            q.setOptionC(request.getParameter("optionC" + i));
            q.setOptionD(request.getParameter("optionD" + i));
            q.setCorrectAnswer(request.getParameter("correctAnswer" + i));
            questions.add(q);
        }

        if ("cancel".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/instructor/dashboard?courseID=" + courseID + "&chapterID=" + chapterID);
            return;
        }

        if ("addQuestion".equals(action)) {
            // Thêm 1 question trống
            questions.add(new Question());
            request.setAttribute("questions", questions);
            request.setAttribute("courseID", courseID);
            request.setAttribute("thisChapterID", chapterID);
            request.setAttribute("quizTitle", quizTitle);
            request.setAttribute("totalQuestions", questions.size());
            request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
            return;
        }

        if ("submitQuiz".equals(action)) {
            if (quizTitle == null || quizTitle.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập tiêu đề Quiz!");
                request.setAttribute("questions", questions);
                request.setAttribute("courseID", courseID);
                request.setAttribute("thisChapterID", chapterID);
                request.setAttribute("totalQuestions", questions.size());
                request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
                return;
            }

            try {
                Quiz quiz = new Quiz();
                quiz.setTitle(quizTitle);
                quiz.setCourseID(courseID);
                quiz.setChapterID(chapterID);

                QuizDAO quizDAO = new QuizDAO();
                int quizID = quizDAO.insertQuizReturnId(quiz);

                if (quizID > 0) {
                    QuestionDAO questionDAO = new QuestionDAO();
                    for (Question q : questions) {
                        if (q.getQuestionText() != null && !q.getQuestionText().trim().isEmpty() &&
                                q.getCorrectAnswer() != null && !q.getCorrectAnswer().isEmpty()) {
                            q.setQuizID(quizID);
                            questionDAO.insertQuestion(q);
                        }
                    }
                }

                response.sendRedirect(request.getContextPath() + "/instructor/dashboard?courseID=" + courseID + "&chapterID=" + chapterID);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                request.setAttribute("questions", questions);
                request.setAttribute("courseID", courseID);
                request.setAttribute("thisChapterID", chapterID);
                request.setAttribute("quizTitle", quizTitle);
                request.setAttribute("totalQuestions", questions.size());
                request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
            }
        }
    }

    private int parseIntSafe(String s) {
        return parseIntSafe(s, 0);
    }

    private int parseIntSafe(String s, int defaultValue) {
        try {
            if (s != null && !s.trim().isEmpty()) return Integer.parseInt(s.trim());
        } catch (NumberFormatException e) { }
        return defaultValue;
    }
}
