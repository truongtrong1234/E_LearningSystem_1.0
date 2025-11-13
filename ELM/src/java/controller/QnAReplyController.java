package controller;

import dao.QnADAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

///@WebServlet("/qnaReply")
public class QnAReplyController extends HttpServlet {
    private QnADAO dao = new QnADAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        int qnaID = Integer.parseInt(request.getParameter("qnaID"));
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        String replyMessage = request.getParameter("replyMessage");
        String redirectURL = request.getParameter("redirectURL");

        dao.addReply(qnaID, acc.getAccountId(), replyMessage);
        // Nếu không có redirectURL, quay về trang học mặc định
        if (redirectURL == null || redirectURL.isEmpty()) {
            redirectURL = "myContent?CourseID=" + courseID;
        }
        response.sendRedirect(redirectURL);
    }
}
