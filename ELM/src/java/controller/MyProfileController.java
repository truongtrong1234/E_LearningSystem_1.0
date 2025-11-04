package controller;

import dao.AccountDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Account;

public class MyProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account sessionAccount = (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Gọi DAO
        AccountDAO dao = new AccountDAO();
        Account acc = dao.getAccountById(sessionAccount.getAccountId());

        if (acc != null) {
            request.setAttribute("name", acc.getName());
            request.setAttribute("email", acc.getEmail());
            request.setAttribute("avatarUrl", acc.getPicture());
            request.setAttribute("course", "Web Development. tạm hardcode "); // tạm hardcode
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("myProfile.jsp");
        dispatcher.forward(request, response);
    }
}
