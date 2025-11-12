/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.QuizProgressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author Admin
 */
public class QuizResultController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int quizID = Integer.parseInt(request.getParameter("QuizID"));
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        int accountID =acc.getAccountId(); 
        QuizProgressDAO dao = new QuizProgressDAO();
        dao.deleteQuizProgress(accountID, quizID); 
        int correctCount = dao.countCorrectAnswers(accountID, quizID);
        int totalQuestions = dao.totalQuestions(quizID);
        double totalScore = (double) correctCount / totalQuestions * 10;
        dao.saveProgress(accountID, quizID, correctCount, totalScore);
        request.setAttribute("correctCount", correctCount);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("totalScore", totalScore);
        request.getRequestDispatcher("quizResult.jsp").forward(request, response);
    }
}
