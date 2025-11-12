package controller;

import dao.QuizDAO;
import dao.CourseDAO;
import model.Account;
import model.Quiz;
import model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QuizListController extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();
    private final CourseDAO courseDAO = new CourseDAO(); 
    private static final String QUIZ_TAB = "quiz-content";
    private static final String QUIZ_LIST_URL = "/instructor/quizList"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int instructorID = acc.getAccountId();
        
        int courseID = 0;
        String courseIDParam = request.getParameter("courseID");
        if (courseIDParam != null && !courseIDParam.isEmpty()) {
            try {
                courseID = Integer.parseInt(courseIDParam);
            } catch (NumberFormatException e) {
                Logger.getLogger(QuizListController.class.getName()).log(Level.WARNING, "Invalid courseID parameter: " + courseIDParam);
            }
        }
        
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            String quizIDStr = request.getParameter("quizID");

            if (quizIDStr != null && !quizIDStr.isEmpty()) {
                try {
                    int quizID = Integer.parseInt(quizIDStr);
                    Quiz selectedQuiz = quizDAO.getQuizById(quizID); 

                    if (selectedQuiz != null) {
                        int chapterID = selectedQuiz.getChapterID();

                        response.sendRedirect(request.getContextPath() 
                        + "/instructor/QuizDetailController?action=edit&ChapterID=" + chapterID 
                        + "&quizID=" + quizIDStr
                        + "&source=list");
                    return;
                    } else {
                         request.setAttribute("error", "Không tìm thấy Bài kiểm tra có ID hợp lệ.");
                         handleList(request, response, instructorID, 0); 
                         return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID bài kiểm tra không hợp lệ.");
                    handleList(request, response, instructorID, 0); 
                    return;
                }
            } else {
                request.setAttribute("error", "Thiếu ID bài kiểm tra để chỉnh sửa.");
                handleList(request, response, instructorID, 0); 
                return;
            }
        }
        
        handleList(request, response, instructorID, courseID);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(request, response, ((Account) request.getSession().getAttribute("account")).getAccountId());
        } else if ("update".equals(action)) { // Xử lí Update
            handleUpdate(request, response, ((Account) request.getSession().getAttribute("account")).getAccountId());
        }
        
        // Chuyển hướng về trang danh sách sau action
        response.sendRedirect(request.getContextPath() + QUIZ_LIST_URL + "?activeTab=" + QUIZ_TAB);
    }
    
    private void handleList(HttpServletRequest request, HttpServletResponse response, 
                            int instructorID, int courseID)
            throws ServletException, IOException {
        List<Quiz> quizList;
        List<Course> courseList;

        try {
            courseList = courseDAO.getCourseByInstructorID(instructorID);
            request.setAttribute("courseList", courseList);

            // Tải danh sách Quiz đã được lọc
            if (courseID > 0) {
                quizList = quizDAO.getByCourseAndInstructor(courseID, instructorID);
                request.setAttribute("selectedCourseID", courseID);
            } else {
                quizList = quizDAO.getQuizzesByInstructorID(instructorID);
            }
        } catch (Exception e) {
            Logger.getLogger(QuizListController.class.getName()).log(Level.SEVERE, "Lỗi tải danh sách Quiz", e);
            // Quay về danh sách mặc định nếu có lỗi SQL trong logic lọc
            quizList = quizDAO.getQuizzesByInstructorID(instructorID); 
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình tải dữ liệu.");
        }

        request.setAttribute("quizList", quizList);
        request.setAttribute("activeTab", QUIZ_TAB);

        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, int instructorID)
            throws IOException {
        String quizIDStr = request.getParameter("quizID");
        try {
            int quizID = Integer.parseInt(quizIDStr);
            quizDAO.deleteQuiz(quizID);
            request.getSession().setAttribute("message", "Xóa bài kiểm tra (ID: " + quizID + ") thành công!");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID bài kiểm tra không hợp lệ.");
        } catch (RuntimeException ex) {
            request.getSession().setAttribute("error", "Lỗi xóa dữ liệu: " + ex.getMessage());
            Logger.getLogger(QuizListController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // Cập nhật xử lí dữ liệu từ form EDIT
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, int instructorID)
            throws IOException {
        try {
            int quizID = Integer.parseInt(request.getParameter("quizID"));
            String title = request.getParameter("title");
            int chapterID = Integer.parseInt(request.getParameter("chapterID"));

            Quiz updatedQuiz = new Quiz();
            updatedQuiz.setQuizID(quizID);
            updatedQuiz.setTitle(title);
            updatedQuiz.setChapterID(chapterID);
            
            quizDAO.updateQuiz(updatedQuiz);
            
            request.getSession().setAttribute("message", "Cập nhật Quiz ID " + quizID + " thành công!");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Lỗi dữ liệu: ID/Chapter không hợp lệ.");
        } catch (RuntimeException e) {
            request.getSession().setAttribute("error", "Lỗi cập nhật Quiz: " + e.getMessage()); 
            Logger.getLogger(QuizListController.class.getName()).log(Level.SEVERE, "Update Error", e);
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response, int quizID)
            throws ServletException, IOException {
        
        Quiz quiz = quizDAO.getQuizById(quizID);
        
        if (quiz != null) {
            // Lấy danh sách Chapters và Courses để điền vào dropdown trong form EDIT
            List<Course> courseList = courseDAO.getCourseByInstructorID(((Account) request.getSession().getAttribute("account")).getAccountId());
            
            request.setAttribute("quizDetail", quiz);
            request.setAttribute("courseList", courseList); 
            // request.setAttribute("chapterList", chapterList); 
            
            request.getRequestDispatcher("/instructor/editQuizDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy Bài kiểm tra có ID: " + quizID);
            int instructorID = ((Account) request.getSession().getAttribute("account")).getAccountId();
            handleList(request, response, instructorID, 0); 
        }
    }
}