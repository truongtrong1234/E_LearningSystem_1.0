package controller;

import dao.QuizDAO;
import model.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

public class CreateQuizController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseParam = request.getParameter("courseID");
        String chapterParam = request.getParameter("ChapterID");

        int courseID = 0;
        int chapterID = 0;

        try {
            if (courseParam != null && chapterParam != null) {
                courseID = Integer.parseInt(courseParam);
                chapterID = Integer.parseInt(chapterParam);
            } else {
                // Nếu không có trong URL thì thử lấy từ attribute (khi forward lại)
                Object courseAttr = request.getAttribute("courseID");
                Object chapterAttr = request.getAttribute("thisChapterID");
                if (courseAttr != null) courseID = Integer.parseInt(courseAttr.toString());
                if (chapterAttr != null) chapterID = Integer.parseInt(chapterAttr.toString());
            }
        } catch (NumberFormatException e) {
            courseID = 0;
            chapterID = 0;
        }

        // Gửi sang JSP
        request.setAttribute("courseID", courseID);
        request.setAttribute("thisChapterID", chapterID);

        // Hiển thị form
        request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String courseParam = request.getParameter("thisCourseID");
        String chapterParam = request.getParameter("thisChapterID");
        String title = request.getParameter("quizTitle");

        int courseID = 0;
        int chapterID = 0;

        try {
            courseID = Integer.parseInt(courseParam);
            chapterID = Integer.parseInt(chapterParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Không tìm thấy Course ID hoặc Chapter ID hợp lệ.");
            request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra hợp lệ
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập tiêu đề Quiz!");
                request.setAttribute("courseID", courseID);
                request.setAttribute("thisChapterID", chapterID);
                request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Quiz
            Quiz quiz = new Quiz();
            quiz.setTitle(title);
            quiz.setChapterID(chapterID);
            quiz.setCourseID(courseID);

            // Gọi DAO thêm mới
            QuizDAO dao = new QuizDAO();
            boolean success = dao.insertQuiz(quiz);

            if (success) {
                response.sendRedirect("createQuiz?courseID=" + courseID + "&ChapterID=" + chapterID);
            } else {
                request.setAttribute("error", "Thêm quiz thất bại. Vui lòng thử lại!");
                request.setAttribute("courseID", courseID);
                request.setAttribute("thisChapterID", chapterID);
                request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống khi thêm quiz: " + e.getMessage());
            request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
        }
    }
}
