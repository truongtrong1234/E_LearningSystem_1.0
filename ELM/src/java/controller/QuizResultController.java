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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuizResultController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizResultController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int quizID = Integer.parseInt(request.getParameter("QuizID"));
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        int accountID =acc.getAccountId(); 
        QuizProgressDAO dao = new QuizProgressDAO();
        int correctCount = dao.countCorrectAnswers(accountID, quizID);
        int totalQuestions = dao.totalQuestions(quizID);
        double totalScore = (double) correctCount / totalQuestions * 10; // điểm max = 10
        dao.saveProgress(accountID, quizID, correctCount, totalScore);
        request.setAttribute("correctCount", correctCount);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("totalScore", totalScore);
        request.getRequestDispatcher("quizResult.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
