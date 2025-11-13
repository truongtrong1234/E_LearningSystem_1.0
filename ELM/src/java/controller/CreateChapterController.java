/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ChapterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Chapter;

public class CreateChapterController extends HttpServlet {

  
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseID = Integer.parseInt(request.getParameter("thisCourseID"));
        String title = request.getParameter("chapterTitle");
        String action = request.getParameter("action"); 
        Chapter ch = new Chapter();
        ch.setCourseID(courseID);
        ch.setTitle(title);
        ChapterDAO dao = new ChapterDAO();
        int newchapterID = dao.insertChapterAndReturnID(ch);
        if ("delete".equalsIgnoreCase(action)) {
            int chapterID = Integer.parseInt(request.getParameter("chapterID"));
            dao.deleteChap(chapterID);
            response.sendRedirect("/ELM/instructor/dashboard?actionCourse=createChapter&courseID=" + courseID);
        }else if ("edit".equalsIgnoreCase(action)) {
            int chapterID = Integer.parseInt(request.getParameter("chapterID"));
            String EditedTitle = request.getParameter("title");
            dao.updateChapterTitle(chapterID,EditedTitle);
            response.sendRedirect("/ELM/instructor/dashboard?actionCourse=createChapter&courseID=" + courseID);
        }
        else{response.sendRedirect("/ELM/instructor/dashboard?actionCourse=createChapter&courseID=" + courseID);}
        
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
