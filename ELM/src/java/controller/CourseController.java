package controller;

import dao.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Course;

public class CourseController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        HttpSession session = request.getSession(); 
        Account account = (Account) session.getAttribute("account"); 
        int accountID = account.getAccountId();
        CourseDAO cdao = new  CourseDAO(); 
        List<Course> courseList = cdao.getCourseByInstructorID(accountID); 
        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int action =Integer.parseInt(request.getParameter("action")) ;
        CourseDAO cdao = new  CourseDAO();
        cdao.deleteCourse(action); 
        response.sendRedirect("/ELM/instructor/dashboard");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
