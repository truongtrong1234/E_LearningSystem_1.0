/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.LessonDAO;
import model.Lesson;
import dao.ChapterDAO;
import dao.CourseDAO;
import dao.MaterialDAO;
import dao.QnADAO;
import dao.QuestionDAO;
import dao.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Chapter;
import model.Course;
import model.Lesson;
import model.QnAQuestion;
import model.QnAReply;
import model.Question;
import model.Quiz;

/**
 *
 * @author ADMIN
 */
public class ViewCourseDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CourseContentAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseContentAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param req
     * @param resp
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    Account acc = (Account) session.getAttribute("account");

    if (acc == null || !"admin".equals(acc.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    int courseID = Integer.parseInt(request.getParameter("CourseID"));
    int lessonID = 0;

    if (request.getParameter("LessonID") != null) {
        lessonID = Integer.parseInt(request.getParameter("LessonID"));
    }

    CourseDAO courseDao = new CourseDAO();
    ChapterDAO chDao = new ChapterDAO();
    QuizDAO quizDao = new QuizDAO();
    QuestionDAO questionDao = new QuestionDAO();
    LessonDAO lessonDao = new LessonDAO();
    MaterialDAO materialDao = new MaterialDAO(); // 🟠 thêm dòng này

    Course course = courseDao.getCourseById(courseID);
    List<Chapter> chapterList = chDao.getChaptersByCourseId(courseID);

    Map<Integer, List<Lesson>> chapterLessonMap = new HashMap<>();
    for (Chapter c : chapterList) {
        List<Lesson> lessons = lessonDao.getByChapterID(c.getChapterID());
        chapterLessonMap.put(c.getChapterID(), lessons);
    }

    Map<Integer, List<Quiz>> chapterQuizMap = new HashMap<>();
    for (Chapter c : chapterList) {
        List<Quiz> quizzes = quizDao.getQuizzesByChapter(c.getChapterID());
        chapterQuizMap.put(c.getChapterID(), quizzes);
    }

    // 🟢 Lấy tài liệu của bài học được chọn
    List<model.Material> materials = null;
    if (lessonID != 0) {
        materials = materialDao.getByLessonID(lessonID);
    }

    // Q&A
    QnADAO qnaDAO = new QnADAO();
    List<QnAQuestion> qnaList = qnaDAO.getQuestionsByCourse(courseID);
    Map<Integer, List<QnAReply>> replyMap = new HashMap<>();
    for (QnAQuestion q : qnaList) {
        List<QnAReply> replies = qnaDAO.getRepliesByQnAID(q.getQnaID());
        replyMap.put(q.getQnaID(), replies);
    }

    // Gửi dữ liệu sang JSP
    request.setAttribute("materials", materials);
    request.setAttribute("selectedLessonID", lessonID);
    request.setAttribute("course", course);
    request.setAttribute("chapterList", chapterList);
    request.setAttribute("chapterLessonMap", chapterLessonMap);
    request.setAttribute("chapterQuizMap", chapterQuizMap);
    request.setAttribute("qnaList", qnaList);
    request.setAttribute("replyMap", replyMap);
    request.setAttribute("CourseID", courseID);

    request.getRequestDispatcher("/admin/ViewCourseDetail.jsp").forward(request, response);
}


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
