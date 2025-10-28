package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Account;
import dao.AccountDAO;
import util.CloudinaryUtil;

import java.io.IOException;

@MultipartConfig
// @WebServlet("/edit_profile") đã có wedxml
public class EditProfileController extends HttpServlet {

    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account sessionAccount = (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer accountId = sessionAccount.getAccountId();
        AccountDAO dao = new AccountDAO();
        Account account = dao.getAccountById(accountId);

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Cập nhật tên nếu có thay đổi
        String newName = request.getParameter("name");
        if (newName != null && !newName.trim().isEmpty()) {
            account.setName(newName.trim());
        }

        // Xử lý avatar với Cloudinary
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String avatarUrl = CloudinaryUtil.uploadImage(filePart);
                account.setPicture(avatarUrl);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Cập nhật DB
        dao.update(account);

        // Cập nhật lại session để hiển thị dữ liệu mới
        session.setAttribute("account", account);

        // Redirect về myProfile
        response.sendRedirect(request.getContextPath() + "/myProfile");
    }
}
