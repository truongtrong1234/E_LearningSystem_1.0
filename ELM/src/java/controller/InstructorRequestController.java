package controller;

import dao.InstructorRequestDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import model.Account;
import model.InstructorRequest;
import util.CloudinaryUtil;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 50,       // 50MB
    maxRequestSize = 1024 * 1024 * 100    // 100MB
)
public class InstructorRequestController extends HttpServlet {

    private InstructorRequestDAO dao = new InstructorRequestDAO();

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");


    Account acc = (Account) request.getSession().getAttribute("account");
    if (acc == null) {
        response.sendRedirect("login");
        return;
    }

    if (!"learner".equals(acc.getRole())) {
        response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
        return;
    }

    // Kiểm tra xem user đã gửi đơn chưa
    InstructorRequest existingRequest = dao.getRequestByAccountID(acc.getAccountId());

    if (existingRequest != null) {
        request.setAttribute("request", existingRequest);
        request.getRequestDispatcher("/Learner/RequestSuccess.jsp").forward(request, response);
    } else {
        request.getRequestDispatcher("/Learner/becomeInstructor.jsp").forward(request, response);
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }
//         if ("learner".equals(acc.getRole())) {
//         
//               response.sendRedirect(request.getContextPath() + "/Learner/becomeInstructor.jsp");
//        } else {
//            //response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
//               request.getRequestDispatcher("/instructor/dashboard").forward(request, response);
//        }

 // Nếu không phải learner → redirect ra dashboard và dừng method
    if (!"learner".equals(acc.getRole())) {
        response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
        return;
    }
        // Lấy dữ liệu từ form (người dùng nhập)
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String title = request.getParameter("title");
    String experience = request.getParameter("experience");
    String skills = request.getParameter("skills");
    String bio = request.getParameter("bio");

        // Upload file CV lên Cloudinary
        Part cvPart = request.getPart("cvFile");
        String cvUrl = null;
        try {
            if (cvPart != null && cvPart.getSize() > 0) {
                cvUrl = CloudinaryUtil.uploadFile(cvPart, "raw");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        InstructorRequest reqObj = new InstructorRequest();
        reqObj.setAccountID(acc.getAccountId());
        reqObj.setFullName(fullName);
        reqObj.setEmail(email);
        reqObj.setPhone(phone);
        reqObj.setTitle(title);
        reqObj.setExperience(experience);
        reqObj.setSkills(skills);
        reqObj.setBio(bio);
        reqObj.setCvFile(cvUrl);

      boolean success = dao.insertRequest(reqObj);
      System.out.println("FullName: " + fullName);


if (success) {
    // Chuyển sang trang success, kèm thông tin vừa submit
    request.setAttribute("request", reqObj);
    request.getRequestDispatcher("/Learner/RequestSuccess.jsp").forward(request, response);
} else {
    // Nếu thất bại → quay lại form và hiển thị msg
    request.setAttribute("msg", " Gửi yêu cầu thất bại. Vui lòng thử lại sau.");
    request.getRequestDispatcher("/Learner/becomeInstructor.jsp").forward(request, response);
}

    }
    
    
}
