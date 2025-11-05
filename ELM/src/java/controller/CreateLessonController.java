/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ChapterDAO;
import dao.LessonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Chapter;
import model.Lesson;

public class CreateLessonController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateChapterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateChapterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int ChapterID = Integer.parseInt(request.getParameter("ChapterID"));
        LessonDAO lessonDao = new LessonDAO();
        List<Lesson> Lessons = lessonDao.getByChapterID(ChapterID);
        request.setAttribute("Lessons", Lessons);
        request.setAttribute("thischapterID", ChapterID);
        request.getRequestDispatcher("/instructor/createLesson.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int ChapterID = Integer.parseInt(request.getParameter("thischapterID"));
        String title = request.getParameter("chapterTitle");
        Lesson lesson = new Lesson();
        lesson.setChapterID(ChapterID);
        lesson.setTitle(title);
        LessonDAO lessonDAO = new LessonDAO();
        int newLessonID = lessonDAO.insert(lesson);
        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            int lessonID = Integer.parseInt(request.getParameter("lessonID"));
            lessonDAO.delete(lessonID);
            response.sendRedirect("createLesson?ChapterID=" + ChapterID);
        }else if ("edit".equalsIgnoreCase(action)) {
            int lessonID = Integer.parseInt(request.getParameter("lessonID"));
            String EditedTitle = request.getParameter("title");
            lessonDAO.updateLesson(lessonID, EditedTitle);
            response.sendRedirect("createLesson?ChapterID=" + ChapterID);
        }else
        {response.sendRedirect("createLesson?ChapterID=" + ChapterID);}
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
