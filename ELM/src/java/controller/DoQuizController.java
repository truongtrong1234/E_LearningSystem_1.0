/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.QuestionDAO;
import dao.QuizDAO;
import dao.StudentAnswerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Question;
import model.Quiz;
import model.StudentAnswer;

/**
 *
 * @author Admin
 */
public class DoQuizController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoQuizController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoQuizController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int quizID = Integer.parseInt(request.getParameter("QuizID"));
        QuizDAO quizDAO = new QuizDAO();
        Quiz quiz = quizDAO.getQuizById(quizID);
        QuestionDAO qdao = new QuestionDAO();
        List<Question> questions = qdao.getQuestionsByQuizID(quizID);
        request.setAttribute("quiz", quiz);
        request.setAttribute("quizID", quizID);
        request.setAttribute("questions", questions);

        request.getRequestDispatcher("/Learner/doQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int quizID = Integer.parseInt(request.getParameter("quizID"));
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        StudentAnswerDAO myAnswer = new StudentAnswerDAO();
        QuestionDAO qdao = new QuestionDAO();
        List<Question> questions = qdao.getQuestionsByQuizID(quizID);
        myAnswer.deleteByQuiz(acc.getAccountId(), quizID); 
        for (Question q : questions) {
            String selected = request.getParameter("answer_" + q.getQuestionID());
            if (selected != null) {
                boolean isCorrect = selected.equalsIgnoreCase(q.getCorrectAnswer());
                myAnswer.saveAnswer(acc.getAccountId(), q.getQuestionID(), selected.charAt(0), isCorrect);
                
            }
        }
        response.sendRedirect("/ELM/Learner/quizResult?QuizID=" + quizID+"");
    }

}
