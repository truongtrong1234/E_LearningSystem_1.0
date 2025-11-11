package controller;

import dao.InstructorRequestDAO;
import model.InstructorRequest;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/////@WebServlet("/admin/managerRequest")
public class ManageRequestController extends HttpServlet {
    InstructorRequestDAO dao = new InstructorRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

        List<InstructorRequest> list = dao.getAllRequests();
        request.setAttribute("requests", list);
        request.getRequestDispatcher("/admin/manageRequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int requestID = Integer.parseInt(request.getParameter("requestID"));
InstructorRequest req = new InstructorRequest();
      req=  dao.getRequestByID(requestID);
        System.out.println("request is:"+req);
        if ("approve".equals(action)) {
            dao.updateRequestStatus(requestID, "Approved");
            
              dao.updateAccountRole(req.getAccountID(), "instructor");
        } else if ("reject".equals(action)) {
            dao.updateRequestStatus(requestID, "Rejected");
        }

        response.sendRedirect(request.getContextPath() + "/admin/manageRequest");

    }
}
