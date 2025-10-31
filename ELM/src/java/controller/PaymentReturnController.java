package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import dao.EnrollmentDAO;
import dao.PaymentDAO;
import java.io.PrintWriter;
import java.math.BigDecimal;
import model.Account;
import model.Payment;
import util.ConfigVnPay;

public class PaymentReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer courseID = Integer.parseInt(request.getParameter("vnp_OrderInfo"));
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Integer accountID = account.getAccountId();

        EnrollmentDAO enrollment = new EnrollmentDAO();
        enrollment.insertEnrollment(accountID, courseID);;

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_BankTranNo = request.getParameter("vnp_BankTranNo");
        String vnp_CardType = request.getParameter("vnp_CardType");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        if ("00".equals(vnp_ResponseCode) && courseID != null && accountID != null) {
            long amount = Long.parseLong(vnp_Amount) / 100;
            PaymentDAO paymentDAO = new PaymentDAO();
            Payment p = new Payment();
            BigDecimal CourseAmount = new BigDecimal(vnp_Amount);
            p.setAmount(CourseAmount);
            p.setTransactionID(vnp_TransactionNo);
            p.setStatus("Success");
            paymentDAO.insertPayment(p);
            request.setAttribute("status", "success");
        } else {
            PaymentDAO paymentDAO = new PaymentDAO();
            Payment p = new Payment();
            BigDecimal CourseAmount = new BigDecimal(vnp_Amount);
            p.setAmount(CourseAmount);
            p.setTransactionID(vnp_TransactionNo);
            p.setStatus("Failed");
            paymentDAO.insertPayment(p);
            request.setAttribute("status", "fail");
        }
        request.getRequestDispatcher("Learner/payment_result.jsp").forward(request, response);
    }
}
