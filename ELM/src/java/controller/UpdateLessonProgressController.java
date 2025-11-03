package controller;

import dao.LessonProgressDAO;
import dao.ChapterProgressDAO;
import dao.EnrollmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Account;

////@WebServlet("/updateLessonProgress")
public class UpdateLessonProgressController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        try {
            int accountID = account.getAccountId();
            System.out.println("Raw params: lessonID=" + request.getParameter("lessonID")
    + ", courseID=" + request.getParameter("courseID")
    + ", isCompleted=" + request.getParameter("isCompleted"));

            int lessonID = Integer.parseInt(request.getParameter("lessonID"));
            int courseID = Integer.parseInt(request.getParameter("courseID"));
            boolean isCompleted = Boolean.parseBoolean(request.getParameter("isCompleted"));

            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
            LessonProgressDAO lessonDAO = new LessonProgressDAO();
            ChapterProgressDAO chapterDAO = new ChapterProgressDAO();

            int enrollmentID = enrollmentDAO.getEnrollmentID(accountID, courseID);

            // Cập nhật trạng thái bài học
            lessonDAO.updateLessonCompletion(enrollmentID, lessonID, isCompleted);

            // Kiểm tra và cập nhật chương nếu cần
            chapterDAO.updateChapterCompletionIfNeeded(enrollmentID, lessonID);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("success");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }
}
