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
import jakarta.servlet.http.HttpSession;
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


//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int courseID = Integer.parseInt(request.getParameter("CourseID"));
//        request.setAttribute("CourseID", courseID);
//        int chapterID = Integer.parseInt(request.getParameter("ChapterID"));
//        request.setAttribute("ChapterID", chapterID);
//        int LessonID = Integer.parseInt(request.getParameter("LessonID"));
//        MaterialDAO mateDAO = new MaterialDAO();
//        List<Material> material = mateDAO.getByLessonID(LessonID);
//        request.setAttribute("material", material);
//        request.setAttribute("thisLessonID", LessonID);
//        request.getRequestDispatcher("/instructor/uploadMaterial.jsp").forward(request, response);
//    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MaterialDAO mdao = new MaterialDAO();
        int courseID = Integer.parseInt(request.getParameter("thisCourseID"));
        int ChapterID = Integer.parseInt(request.getParameter("thisChapterID"));
        int LessonID = Integer.parseInt(request.getParameter("thisLessonID"));
        Part filePart = request.getPart("PartFile");
        String contentType = filePart.getContentType();
        boolean valid = false;
        try {
            String title = request.getParameter("title");
            String type = request.getParameter("type");
            String urlType;
            switch (type) {
                case "Video":
                    valid = contentType.startsWith("video/");
                    urlType = "video";
                    break;
                case "PDF":
                    valid = contentType.equals("application/pdf");
                    urlType = "raw";
                    break;
                case "Doc":
                    valid = contentType.equals("application/msword")
                            || contentType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
                    urlType = "raw";
                    break;
                default:
                    valid = false;
                    urlType = null;
                    break;
            }

            if (!valid) {
                session.setAttribute("errorMessage", "Loại file không khớp với lựa chọn ");
                response.sendRedirect("/ELM/instructor/dashboard?actionCourse=uploadMaterial&CourseID=" + courseID + "&ChapterID=" + ChapterID + "&LessonID=" + LessonID);
                return;
            } else {
                session.removeAttribute("errorMessage");
            }
            if (filePart == null) {
                request.setAttribute("errorMessage", "không được để trống");
            }
            String url = CloudinaryUtil.uploadFile(filePart, urlType);
            Material mate = new Material();
            mate.setLessonID(LessonID);
            mate.setMaterialType(type);
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
            response.sendRedirect("/ELM/instructor/dashboard?actionCourse=uploadMaterial&CourseID=" + courseID + "&ChapterID=" + ChapterID + "&LessonID=" + LessonID);
        } else {
            response.sendRedirect("/ELM/instructor/dashboard?actionCourse=uploadMaterial&CourseID=" + courseID + "&ChapterID=" + ChapterID + "&LessonID=" + LessonID);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
