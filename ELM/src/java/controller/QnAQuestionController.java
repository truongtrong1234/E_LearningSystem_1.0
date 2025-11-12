package controller;

import dao.QnADAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

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
        String redirectURL = request.getParameter("redirectURL");

        dao.addQuestion(courseID, acc.getAccountId(), question);

        // Nếu không có redirectURL, quay về trang học mặc định
        if (redirectURL == null || redirectURL.isEmpty()) {
            redirectURL = "myContent?CourseID=" + courseID;
        }

        response.sendRedirect(redirectURL);
    }
}
