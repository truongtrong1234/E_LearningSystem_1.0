package controller;

import dao.QnADAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

//@WebServlet("/qnaQuestion")
public class QnAQuestionController extends HttpServlet {
    private QnADAO dao = new QnADAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        int courseID = Integer.parseInt(request.getParameter("courseID"));
        String question = request.getParameter("question");

        dao.addQuestion(courseID, acc.getAccountId(), question);
        response.sendRedirect("myContent?CourseID=" + courseID);
    }
}
