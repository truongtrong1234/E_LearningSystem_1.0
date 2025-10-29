package controller;

import dao.QuizDAO;
import model.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuizServlet", urlPatterns = {"/instructor/quiz"})
public class QuizController extends HttpServlet {

    private QuizDAO quizDAO;

    @Override
    public void init() {
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "delete":
                deleteQuiz(request, response);
                break;
            case "edit":
                // (phần edit để sau)
                break;
            default:
                listQuiz(request, response);
                break;
        }
    }

    private void listQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Quiz> quizList = quizDAO.getAllQuizzes();
        request.setAttribute("quizList", quizList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/instructor/dashboard.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteQuiz(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int quizId = Integer.parseInt(request.getParameter("id"));
        quizDAO.deleteQuiz(quizId);
        response.sendRedirect(request.getContextPath() + "/instructor/quiz");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận dữ liệu từ createQuiz.jsp
        String title = request.getParameter("quizTitle");
        String chapterIdStr = request.getParameter("chapterId");

        if (title == null || chapterIdStr == null || title.isEmpty() || chapterIdStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/instructor/createQuiz.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int chapterId = Integer.parseInt(chapterIdStr);
        Quiz newQuiz = new Quiz();
        newQuiz.setTitle(title);
        newQuiz.setChapterID(chapterId);

        boolean inserted = quizDAO.insertQuiz(newQuiz);

        if (inserted) {
            // Sau khi tạo xong quay về dashboard hiển thị danh sách mới
            response.sendRedirect(request.getContextPath() + "/instructor/quiz");
        } else {
            request.setAttribute("error", "Không thể tạo quiz, vui lòng thử lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/instructor/createQuiz.jsp");
            dispatcher.forward(request, response);
        }
    }
}
