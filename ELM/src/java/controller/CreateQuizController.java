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
        
        // 1. Nhận Course ID và Chapter ID từ URL
        String courseId = request.getParameter("courseId");
        String chapterId = request.getParameter("chapterId"); 

        // 2. Lưu ID vào Request Scope để sử dụng trong createQuiz.jsp
        request.setAttribute("currentCourseId", courseId);
        request.setAttribute("currentChapterId", chapterId);

        // 3. Điều hướng đến form tạo quiz
        request.getRequestDispatcher("/createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy các ID đã được gửi từ trường ẩn (hidden fields) của createQuiz.jsp
        String courseIdStr = request.getParameter("courseId"); 
        String chapterIdStr = request.getParameter("chapterId");
        String title = request.getParameter("quizTitle"); // Tên input trong form là quizTitle

        try {
            if (title == null || title.trim().isEmpty() || chapterIdStr == null || chapterIdStr.isEmpty() || courseIdStr == null || courseIdStr.isEmpty()) {
                // Nếu lỗi, set lại các ID để forward lại trang JSP
                request.setAttribute("currentCourseId", courseIdStr);
                request.setAttribute("currentChapterId", chapterIdStr);
                
                request.setAttribute("error", "Vui lòng nhập đầy đủ Tiêu đề Quiz và các ID không được thiếu!");
                request.getRequestDispatcher("/createQuiz.jsp").forward(request, response);
                return;
            }

            int chapterID = Integer.parseInt(chapterIdStr);
            int courseID = Integer.parseInt(courseIdStr);

            // Tạo đối tượng Quiz và SET Course ID
            Quiz quiz = new Quiz();
            quiz.setTitle(title);
            quiz.setChapterID(chapterID);
            quiz.setCourseID(courseID); // <--- SET COURSE ID ĐƯỢC THÊM

            // Gọi DAO để lưu vào DB
            QuizDAO dao = new QuizDAO();
            boolean success = dao.insertQuiz(quiz); 

            if (success) {
                // Chuyển hướng đến danh sách quiz
                response.sendRedirect(request.getContextPath() + "/instructor/listQuiz?chapterId=" + chapterID + "&courseId=" + courseID);
            } else {
                // Nếu lỗi, set lại các ID trước khi forward
                request.setAttribute("currentCourseId", courseIdStr);
                request.setAttribute("currentChapterId", chapterIdStr);
                
                request.setAttribute("error", "Thêm quiz thất bại. Vui lòng thử lại!");
                request.getRequestDispatcher("/createQuiz.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng ID Chương hoặc ID Khóa học.");
            request.getRequestDispatcher("/createQuiz.jsp").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống khi thêm quiz: " + e.getMessage());
            request.getRequestDispatcher("/createQuiz.jsp").forward(request, response);
        }
    }
}