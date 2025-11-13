package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Account;
import dao.AccountDAO;
import util.CloudinaryUtil;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)

public class EditProfileController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Account sessionAccount = (Account) session.getAttribute("account");

        if (sessionAccount == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int accountId = sessionAccount.getAccountId();
        AccountDAO dao = new AccountDAO();
        Account account = dao.getAccountById(accountId);

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ======= LẤY DỮ LIỆU TỪ FORM =======
        String newName = request.getParameter("name");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String workplace = request.getParameter("workplace");

        // ======= CẬP NHẬT GIÁ TRỊ =======
        if (newName != null && !newName.trim().isEmpty()) {
            account.setName(newName.trim());
        }
        if (gender != null) {
            account.setGender(gender);
        }
        if (dateOfBirth != null && !dateOfBirth.trim().isEmpty()) {
            account.setDateOfBirth(dateOfBirth);
        }
        if (phone != null && !phone.trim().isEmpty()) {
            account.setPhone(phone.trim());
        }
        if (address != null && !address.trim().isEmpty()) {
            account.setAddress(address.trim());
        }
        if (workplace != null && !workplace.trim().isEmpty()) {
            account.setWorkplace(workplace.trim());
        }

        // ======= XỬ LÝ ẢNH ĐẠI DIỆN (NẾU CÓ) =======
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String avatarUrl = CloudinaryUtil.uploadImage(filePart);
                account.setPicture(avatarUrl);
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Lỗi upload ảnh lên Cloudinary: " + e.getMessage());
            }
        }

        // ======= CẬP NHẬT DATABASE =======
        try {
            dao.update(account);
            session.setAttribute("account", account); // Cập nhật lại session
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi update thông tin Account vào DB: " + e.getMessage());
        }

        // ======= CHUYỂN HƯỚNG VỀ TRANG PROFILE =======
        response.sendRedirect(request.getContextPath() + "/myProfile");
    }
}
