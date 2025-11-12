package controller;

import dao.QuestionDAO;
import dao.QuizDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Question;
import model.Quiz;

public class QuizDetailAdmin extends HttpServlet {
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

        int quizID = Integer.parseInt(request.getParameter("QuizID"));

        QuizDAO quizDao = new QuizDAO();
        QuestionDAO questionDao = new QuestionDAO();

        Quiz quiz = quizDao.getQuizById(quizID);
        List<Question> questionList = questionDao.getQuestionsByQuizID(quizID);

        request.setAttribute("quiz", quiz);
        request.setAttribute("questionList", questionList);

        request.getRequestDispatcher("/admin/quizDetail.jsp").forward(request, response);
    }
}
