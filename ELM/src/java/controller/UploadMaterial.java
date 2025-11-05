/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ChapterDAO;
import dao.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Chapter;
import model.Material;
import util.CloudinaryUtil;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class UploadMaterial extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadMaterial</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadMaterial at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseID = Integer.parseInt(request.getParameter("CourseID"));
        request.setAttribute("CourseID", courseID);
        int chapterID = Integer.parseInt(request.getParameter("ChapterID"));
        request.setAttribute("ChapterID", chapterID);
        int LessonID = Integer.parseInt(request.getParameter("LessonID"));
        MaterialDAO mateDAO = new MaterialDAO();
        List<Material> material = mateDAO.getByLessonID(LessonID);
        request.setAttribute("material", material);
        request.setAttribute("thisLessonID", LessonID);
        request.getRequestDispatcher("/instructor/uploadMaterial.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MaterialDAO mdao = new MaterialDAO();
        int courseID = Integer.parseInt(request.getParameter("thisCourseID"));
        int ChapterID = Integer.parseInt(request.getParameter("thisChapterID"));
        int LessonID = Integer.parseInt(request.getParameter("thisLessonID"));
        try {

            String title = request.getParameter("title");
            String type = request.getParameter("type");
            String urlType;
            switch (type) {
                case "Image":
                    urlType = "image";
                    break;
                case "Video":
                    urlType = "video";
                    break;
                default: // PDF, Other,...
                    urlType = "raw";
                    break;
            }
            Part filePart = request.getPart("PartFile");
            if (filePart == null) {
                request.setAttribute("errorMessage", "không được để trống");
            }
            String url = CloudinaryUtil.uploadFile(filePart, "raw");
            Material mate = new Material();
            mate.setLessonID(LessonID);
            mate.setMaterialType("Video");
            mate.setContentURL(url);
            mate.setTitle(title);
            
            int materialIDUpload = mdao.insert(mate);

        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Xem lại loại file và chọn lại ");
        }

        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            int materialID = Integer.parseInt(request.getParameter("materialID"));
            mdao.delete(materialID);
            response.sendRedirect("uploadMaterial?CourseID="+courseID+"&ChapterID="+ChapterID+"&LessonID=" + LessonID);
        } else {
            response.sendRedirect("uploadMaterial?CourseID="+courseID+"&ChapterID="+ChapterID+"&LessonID=" + LessonID);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
