package controller;

import dao.QuestionDAO;
import model.Question;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddQuestionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int quizID = Integer.parseInt(request.getParameter("quizID"));
        String questionText = request.getParameter("questionText");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");

        Question q = new Question(0, quizID, questionText, optionA, optionB, optionC, optionD, correctAnswer);

        QuestionDAO dao = new QuestionDAO();
        dao.insertQuestion(q);

        // Quay lại trang quiz detail
        response.sendRedirect("veCourse.jsp?quizID=" + quizID);
    }
}
