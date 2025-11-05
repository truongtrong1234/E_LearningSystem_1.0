/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import java.math.BigDecimal;
import java.util.List;
import model.Account;
import model.Category;
import model.Course;
import util.CloudinaryUtil;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class EditCourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("id"));
        CourseDAO cdao = new CourseDAO();
        Course course = new Course();
        course = cdao.getCourseById(courseId);
        request.setAttribute("course", course);
        CategoryDAO catedao = new CategoryDAO();
        List<Category> categoryList = catedao.getAllCat();
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("/instructor/veCourse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("thisCourseID"));
        try {

            // 2️⃣ Lấy các dữ liệu từ form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int theClass = Integer.parseInt(request.getParameter("className"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double pricedouble = Double.parseDouble(request.getParameter("price"));
            BigDecimal price = BigDecimal.valueOf(pricedouble);

            // 3️⃣ Lấy instructor từ session
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            int instructorID = acc.getAccountId();

            // 4️⃣ Upload file (nếu có)
            Part filePart = request.getPart("thumbnail");
            String thumbnailUrl = null;

            // Nếu người dùng có chọn ảnh mới thì upload lên Cloudinary
            if (filePart != null && filePart.getSize() > 0) {
                thumbnailUrl = CloudinaryUtil.uploadImage(filePart);
            }

            // 5️⃣ Lấy course hiện tại để giữ lại thumbnail cũ nếu không upload mới
            CourseDAO cdao = new CourseDAO();
            Course existing = cdao.getCourseById(courseId);
            if (thumbnailUrl == null) {
                thumbnailUrl = existing.getThumbnail(); // giữ nguyên ảnh cũ
            }

            // 6️⃣ Tạo đối tượng course và update
            Course c = new Course();
            c.setCourseID(courseId);
            c.setTitle(title);
            c.setDescription(description);
            c.setInstructorID(instructorID);
            c.setPrice(price);
            c.setCourseclass(theClass);
            c.setCategoryID(categoryID);
            c.setThumbnail(thumbnailUrl);

            boolean isUpdated = cdao.updateCourse(c);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/instructor/editCourse?id=" + courseId);
            } else {
                request.setAttribute("errorMessage", "Update failed!");
                response.sendRedirect("/ELM/instructor/editCourse?id=" + courseId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update course. Please check your inputs.");
            response.sendRedirect("/ELM/instructor/editCourse?id=" + courseId);
        }

    }
}
