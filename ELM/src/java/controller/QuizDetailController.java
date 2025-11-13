package controller;

import dao.QuestionDAO;
import dao.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Question;
import model.Quiz;

/**
 *
 * @author Admin
 */
public class QuizDetailController extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuizDetailController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String chapterIDStr = request.getParameter("ChapterID");
        String quizIDStr = request.getParameter("quizID");

        int chapterID = 0;
        int quizID = 0;
        String error = null;

        if (chapterIDStr == null || chapterIDStr.isEmpty()) {
            error = "Thiếu Chapter ID.";
        } else {
            try {
                chapterID = Integer.parseInt(chapterIDStr);
            } catch (NumberFormatException e) {
                error = "Chapter ID không hợp lệ.";
            }
        }

        if (quizIDStr == null || quizIDStr.isEmpty()) {
            if (error == null) {
                 error = "Thiếu Quiz ID.";
            }
        } else {
            try {
                quizID = Integer.parseInt(quizIDStr);
            } catch (NumberFormatException e) {
                if (error == null) {
                     error = "Quiz ID không hợp lệ.";
                }
            }
        }

        if (error != null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, error);
            return;
        }

        QuizDAO quizDAO = new QuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        Quiz quiz = quizDAO.getQuizById(quizID);

        if (quiz == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy Quiz có ID: " + quizID);
            return;
        }

        List<Question> questions = questionDAO.getQuestionsByQuizID(quizID);

        request.setAttribute("thisChapterID", chapterID); 
        request.setAttribute("thisquizID", quizID);      
        request.setAttribute("quiz", quiz);
        request.setAttribute("questions", questions);

        request.getRequestDispatcher("/instructor/editQuizDetail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String quizID_raw = request.getParameter("thisquizID");
        Integer quizID = null;
        if (quizID_raw != null && !quizID_raw.isEmpty()) {
            quizID = Integer.parseInt(quizID_raw);
        }
        int chapterID = Integer.parseInt(request.getParameter("thisChapterID"));
        QuizDAO quizDAO = new QuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        try {
            switch (action) {
                case "updateTitle":
                    String quizTitle = request.getParameter("quizTitle");
                    Quiz quiz = new Quiz(); 
                    quiz.setChapterID(chapterID);
                    quiz.setTitle(quizTitle);
                    quiz.setQuizID(quizID);
                    quizDAO.updateQuiz(quiz);
                    break;

                case "addQuestion":
                    String questionText = request.getParameter("questionText");
                    String optionA = request.getParameter("optionA");
                    String optionB = request.getParameter("optionB");
                    String optionC = request.getParameter("optionC");
                    String optionD = request.getParameter("optionD");
                    String correctAnswer = request.getParameter("correctAnswer");

                    Question newQuestion = new Question();
                    newQuestion.setQuizID(quizID);
                    newQuestion.setQuestionText(questionText);
                    newQuestion.setOptionA(optionA);
                    newQuestion.setOptionB(optionB);
                    newQuestion.setOptionC(optionC);
                    newQuestion.setOptionD(optionD);
                    newQuestion.setCorrectAnswer(correctAnswer);

                    questionDAO.insertQuestion(newQuestion);
                    break;

                case "updateQuestion":
                    int questionID = Integer.parseInt(request.getParameter("questionID"));
                    String qText = request.getParameter("questionText");
                    String qA = request.getParameter("optionA");
                    String qB = request.getParameter("optionB");
                    String qC = request.getParameter("optionC");
                    String qD = request.getParameter("optionD");
                    String qCorrect = request.getParameter("correctAnswer");

                    Question q = new Question(questionID, quizID, qText, qA, qB, qC, qD, qCorrect);
                    questionDAO.updateQuestion(q);
                    break;

                case "deleteQuestion":
                    int deleteID = Integer.parseInt(request.getParameter("questionID"));
                    questionDAO.deleteQuestion(deleteID);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Sau khi xử lý, load lại trang
        response.sendRedirect("editQuizDetail?ChapterID="+chapterID+"&quizID=" + quizID);
    }
    
}
