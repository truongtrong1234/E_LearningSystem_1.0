
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

        int chapterID = Integer.parseInt(request.getParameter("ChapterID"));
        QuizDAO quizDao = new QuizDAO();
        List<Quiz> quizList = quizDao.getQuizzesByChapter(chapterID);
        request.setAttribute("ChapterID", chapterID);
        request.setAttribute("QuizList", quizList);
        request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int chapterID = Integer.parseInt(request.getParameter("thisChapterID"));
        String action = request.getParameter("action");
        String quizTitle = request.getParameter("quizTitle");
        String quizIdParam = request.getParameter("quizID");
        Integer quizID = null;
        if (quizIdParam != null && !quizIdParam.isEmpty()) {
            quizID = Integer.parseInt(quizIdParam);
        }
        QuizDAO qdao = new QuizDAO();
        Quiz quiz = new Quiz();
        quiz.setChapterID(chapterID);
        quiz.setTitle(quizTitle);
        boolean isInserted = qdao.insertQuiz(quiz);
        if (isInserted == false) {
            request.setAttribute("errorMessage", "nope ");
        }
        if ("delete".equalsIgnoreCase(action)) {
            qdao.deleteQuiz(quizID);
            response.sendRedirect("createQuiz?ChapterID=" + chapterID);
        } else {
            response.sendRedirect("createQuiz?ChapterID=" + chapterID);
        }
    }
}
