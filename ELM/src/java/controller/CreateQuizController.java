package controller;

import dao.QuizDAO;
import model.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/createQuiz")
public class CreateQuizController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form tạo quiz (nếu có trang createQuiz.jsp)
        request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String chapterIdStr = request.getParameter("chapterID");

            if (title == null || title.trim().isEmpty() || chapterIdStr == null || chapterIdStr.isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin Quiz!");
                request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
                return;
            }

            int chapterID = Integer.parseInt(chapterIdStr);

            // Tạo đối tượng Quiz
            Quiz quiz = new Quiz();
            quiz.setTitle(title);
            quiz.setChapterID(chapterID);

            // Gọi DAO để lưu vào DB
            QuizDAO dao = new QuizDAO();
            boolean success = dao.insertQuiz(quiz);

            if (success) {
                // Sau khi thêm thành công -> chuyển hướng đến danh sách quiz
                response.sendRedirect("listQuiz?chapterID=" + chapterID);
            } else {
                request.setAttribute("error", "Thêm quiz thất bại. Vui lòng thử lại!");
                request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm quiz: " + e.getMessage());
            request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
        }
    }
}
