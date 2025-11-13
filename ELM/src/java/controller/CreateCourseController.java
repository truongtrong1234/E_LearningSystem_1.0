/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import dao.CategoryDAO;
import dao.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Category;
import model.Course;
import util.CloudinaryUtil;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class CreateCourseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            String title = request.getParameter("courseTitle");
            String description = request.getParameter("description");
            int theClass = Integer.parseInt(request.getParameter("class"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double pricedouble = Double.parseDouble(request.getParameter("price"));
            BigDecimal price  = BigDecimal.valueOf(pricedouble); 
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            int instructorID = acc.getAccountId();
            // upload file
            Part filePart = request.getPart("thumbnail");
            if (filePart==null) {
                request.setAttribute("errorMessage", "không được để trống thumbnail");
            }
            String url = CloudinaryUtil.uploadImage(filePart);
            Course c = new Course(title, description, instructorID, price, theClass, categoryID, url);
            CourseDAO cdao = new CourseDAO(); 
            int newCourseID =  cdao.insertCourseAndReturnID(c);
            response.sendRedirect("/ELM/instructor/dashboard?actionCourse=createChapter&courseID="+newCourseID);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to create course. Please check inputs.");
            doGet(request, response);
        }

    }
}
