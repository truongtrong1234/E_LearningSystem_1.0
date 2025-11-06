/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.LessonDAO;
import dao.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Lesson;
import model.Material;

/**
 *
 * @author Admin
 */
public class ViewMaterialController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewMaterial</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewMaterial at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        urlMaterial
        String url = request.getParameter("url");
        String materials = null;
        MaterialDAO materialDAO = new MaterialDAO();
        if (url.contains("/video/")) {
            materials = "<a href='" + url + "'>Link</a>";
        } else {
            materials = "<iframe src='https://docs.google.com/gview?url=" + url + "&embedded=true' width='100%' height='600px'></iframe>";
        }
        request.setAttribute("materials", materials);
        request.getRequestDispatcher("/Learner/viewMaterial.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
