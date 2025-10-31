package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.UUID;
import model.Account;
import model.Payment;
import dao.PaymentDAO;
import dao.EnrollmentDAO;

/////@WebServlet("/payment")
public class PaymentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        // 🔒 Nếu chưa đăng nhập
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int courseID = Integer.parseInt(request.getParameter("courseID"));
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String method = request.getParameter("method");

            // ✅ Giả lập thanh toán "FakeGateway"
            String transactionId = UUID.randomUUID().toString();
            String status = "Success";

            // ✅ Ghi payment vào DB
            Payment payment = new Payment();
            payment.setEnrollmentID(0); // sẽ update sau khi có enrollment
            payment.setAmount(amount);
            payment.setStatus(status);
            payment.setTransactionID(transactionId);

            PaymentDAO pdao = new PaymentDAO();
            pdao.insertPayment(payment);

            // ✅ Tạo enrollment (đăng ký khóa)
            EnrollmentDAO edao = new EnrollmentDAO();
            edao.insertEnrollment(acc.getAccountId(), courseID);

            // 🟢 Chuyển đến trang thành công
            request.setAttribute("courseId", courseID);
            RequestDispatcher rd = request.getRequestDispatcher("Learner/enrollSuccess.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
