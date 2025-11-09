package controller;

import dao.CourseDAO;
import dao.ChapterDAO;
import dao.QuestionDAO;
import dao.QuizDAO;
import model.Course; // Cần import Course model
import model.Chapter; // Cần import Chapter model
import model.Quiz;
import model.Question;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// Đảm bảo Servlet mapping đúng
@WebServlet(name = "CreateQuizController", urlPatterns = {"/instructor/createQuiz"})
public class CreateQuizController extends HttpServlet {
    
    // Giả định bạn có thể lấy InstructorID từ Session hoặc nơi khác
    // Tôi đặt tạm là 1
    private final int instructorID = 1; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ********* THÊM: TẢI DANH SÁCH COURSE KHI TẢI TRANG LẦN ĐẦU *********
        try {
            int instructorID = 10;
            List<Course> coursesList = new CourseDAO().getCourseByInstructorID(instructorID);
            request.setAttribute("coursesList", coursesList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách Khóa học.");
        }
        
        // Logic để giữ lại trạng thái ID nếu có lỗi
        // Các ID này được truyền từ request/attribute nếu có lỗi, không cần thiết cho lần đầu.
        
        // Lần đầu mở form, tạo 1 question trống
        List<Question> questions = (List<Question>) request.getAttribute("questions");
        if (questions == null) {
            questions = new ArrayList<>();
            questions.add(new Question());
        }

        request.setAttribute("questions", questions);
        request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        // Lấy ID đã chọn/đã lưu (CourseID là trường bắt buộc)
        int selectedCourseID = parseIntSafe(request.getParameter("courseID")); // Từ select box
        int selectedChapterID = parseIntSafe(request.getParameter("chapterID")); // Từ select box
        
        // Lấy các giá trị cũ (được lưu trong hidden fields nếu có)
        int thisCourseID = parseIntSafe(request.getParameter("thisCourseID"));
        int thisChapterID = parseIntSafe(request.getParameter("thisChapterID"));
        
        // Quyết định ID nào đang được sử dụng
        // Nếu selectedCourseID > 0, ưu tiên ID mới nhất từ select box (submit onchange)
        int courseID = selectedCourseID > 0 ? selectedCourseID : thisCourseID;
        int chapterID = selectedChapterID > 0 ? selectedChapterID : thisChapterID;
        
        String quizTitle = request.getParameter("titleQuiz"); // Sửa tên tham số
        
        // Lấy danh sách question hiện tại
        List<Question> questions = new ArrayList<>();
        int totalQuestions = parseIntSafe(request.getParameter("totalQuestions"), 1);
        for (int i = 1; i <= totalQuestions; i++) {
            Question q = new Question();
            q.setQuestionText(request.getParameter("questionText" + i));
            q.setOptionA(request.getParameter("optionA" + i));
            q.setOptionB(request.getParameter("optionB" + i));
            q.setOptionC(request.getParameter("optionC" + i));
            q.setOptionD(request.getParameter("optionD" + i));
            q.setCorrectAnswer(request.getParameter("correctAnswer" + i));
            questions.add(q);
        }
        
        // ********* ĐIỀU CHỈNH LOGIC SUBMIT (onchange, addQuestion, submitQuiz) *********
        
        // Hành động 1: SUBMIT CUỐI CÙNG (tạo Quiz)
        if ("submitQuiz".equals(action)) {
             // Logic tạo Quiz (giữ nguyên logic bạn đã có, nhưng dùng courseID/chapterID mới)
            if (quizTitle == null || quizTitle.trim().isEmpty() || courseID <= 0 || chapterID <= 0) {
                 // Xử lý lỗi validation (thiếu tiêu đề/ID)
                request.setAttribute("error", "Vui lòng chọn Course, Chapter và nhập Tiêu đề Quiz!");
                
                // Cần forward, nên phải tải lại danh sách Course/Chapter
                handleStateAndForward(request, response, courseID, chapterID, questions, quizTitle);
                return;
            }

            try {
                Quiz quiz = new Quiz();
                quiz.setTitle(quizTitle);
                quiz.setCourseID(courseID);
                quiz.setChapterID(chapterID);
                
                QuizDAO quizDAO = new QuizDAO();
                int quizID = quizDAO.insertQuizReturnId(quiz);

                if (quizID > 0) {
                    QuestionDAO questionDAO = new QuestionDAO();
                    // Lưu các câu hỏi
                    // ... (logic lưu questions giữ nguyên) ...
                }

                // Chuyển hướng thành công
                response.sendRedirect(request.getContextPath() + "/instructor/dashboard?tab=quiz"); 
                return;
            } catch (Exception e) {
                 // Xử lý lỗi hệ thống
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống khi tạo Quiz: " + e.getMessage());
                handleStateAndForward(request, response, courseID, chapterID, questions, quizTitle);
                return;
            }
        }
        
        // Hành động 2: THÊM CÂU HỎI (addQuestion) hoặc XÓA CÂU HỎI (deleteIndex)
        // (Logic xử lý add/delete giữ nguyên)
        if ("addQuestion".equals(action) || request.getParameter("deleteIndex") != null) {
            
            if ("addQuestion".equals(action)) {
                questions.add(new Question());
            } else if (request.getParameter("deleteIndex") != null) {
                // ... (Logic xóa câu hỏi, cần kiểm tra deleteIndex) ...
            }
            
            // Cần forward để hiển thị form mới
            handleStateAndForward(request, response, courseID, chapterID, questions, quizTitle);
            return;
        }
        
        // Hành động 3 (MẶC ĐỊNH): SUBMIT TỰ ĐỘNG KHI CHỌN COURSE (onchange)
        // Nếu không phải submitQuiz, addQuestion, hay deleteIndex VÀ courseID được gửi lên, 
        // đây là hành động chọn Course (tải Chapter).
        if (selectedCourseID > 0) {
            // Tải Chapter và forward
            handleStateAndForward(request, response, courseID, chapterID, questions, quizTitle);
            return;
        }
        
        // Nếu không có hành động nào được xác định rõ ràng, forward lại.
        handleStateAndForward(request, response, courseID, chapterID, questions, quizTitle);
    }
    
    // ********* PHƯƠNG THỨC HỖ TRỢ ĐỂ TẢI TRẠNG THÁI VÀ CHUYỂN TIẾP *********
    private void handleStateAndForward(HttpServletRequest request, HttpServletResponse response, 
                                       int courseID, int chapterID, List<Question> questions, 
                                       String quizTitle) throws ServletException, IOException {
        try {
            // 1. Tải lại danh sách Course (luôn cần)
            List<Course> coursesList = new CourseDAO().getCourseByInstructorID(instructorID);
            request.setAttribute("coursesList", coursesList);
            
            // 2. Tải lại danh sách Chapter nếu Course đã được chọn
            if (courseID > 0) {
                List<Chapter> chaptersList = new ChapterDAO().getChaptersByCourseId(courseID);
                request.setAttribute("chaptersList", chaptersList);
            }
        } catch (Exception e) {
             // Xử lý lỗi DAO
            request.setAttribute("error", "Lỗi tải dữ liệu Course/Chapter: " + e.getMessage());
        }

        // 3. Đặt lại trạng thái đã chọn và dữ liệu hiện tại
        request.setAttribute("selectedCourseID", courseID);
        request.setAttribute("selectedChapterID", chapterID);
        request.setAttribute("questions", questions);
        request.setAttribute("quizTitle", quizTitle);
        request.setAttribute("totalQuestions", questions.size());

        request.getRequestDispatcher("/instructor/createQuiz.jsp").forward(request, response);
    }

    private int parseIntSafe(String s) {
        return parseIntSafe(s, 0);
    }

    private int parseIntSafe(String s, int defaultValue) {
        try {
            if (s != null && !s.trim().isEmpty()) return Integer.parseInt(s.trim());
        } catch (NumberFormatException e) { }
        return defaultValue;
    }
}