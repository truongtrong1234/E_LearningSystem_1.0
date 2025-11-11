package controller;

import dao.CourseDAO;
import dao.MaterialDAO;
import model.Material;
import model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;

public class MaterialListController extends HttpServlet {

    private final MaterialDAO materialDAO = new MaterialDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập và lấy instructorID
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int instructorID = acc.getAccountId();
        
        // Lấy tham số courseID cho chức năng lọc
        int courseID = 0;
        String courseIDParam = request.getParameter("courseID");
        if (courseIDParam != null && !courseIDParam.isEmpty()) {
            try {
                courseID = Integer.parseInt(courseIDParam);
            } catch (NumberFormatException e) {
                // Xử lý nếu courseID không phải là số
                Logger.getLogger(MaterialListController.class.getName()).log(Level.WARNING, "Invalid courseID parameter: " + courseIDParam);
            }
        }
        
        // Lấy tham số hành động (action)
        String action = request.getParameter("action");
        String materialIDStr = request.getParameter("materialID");
        int materialID = 0;

        if (materialIDStr != null && !materialIDStr.isEmpty()) {
            try {
                materialID = Integer.parseInt(materialIDStr);
            } catch (NumberFormatException e) {
                // Nếu ID không hợp lệ, set thông báo lỗi và tiếp tục tải danh sách
                request.setAttribute("error", "ID material không hợp lệ.");
                action = "list"; 
            }
        }
        
        // XỬ LÝ HÀNH ĐỘNG VIEW 
        if ("view".equals(action) && materialID > 0) {
            handleView(request, response, materialID);
            return; 
        }
        
        //XỬ LÝ HIỂN THỊ DANH SÁCH 
        handleList(request, response, instructorID, courseID);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        Account acc = (Account) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String materialIDStr = request.getParameter("materialID");

        // XỬ LÝ HÀNH ĐỘNG DELETE
        if ("delete".equals(action) && materialIDStr != null) {
            try {
                int materialID = Integer.parseInt(materialIDStr);
                handleDelete(request, response, materialID); // Gọi hàm xử lý xóa

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID material không hợp lệ.");
            } 
            catch (RuntimeException ex) { 
                request.getSession().setAttribute("error", "Lỗi xóa dữ liệu: " + ex.getMessage());
                Logger.getLogger(MaterialListController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        // Chuyển hướng về MaterialListController để tải lại danh sách
        response.sendRedirect("MaterialListController?activeTab=material-content"); 
    }
    
    //Xử lý logic hiển thị danh sách material
    private void handleList(HttpServletRequest request, HttpServletResponse response, int instructorID, int courseID)
            throws ServletException, IOException {
        List<Material> materialList;
        List<Course> courseList = courseDAO.getCourseByInstructorID(instructorID); 
        request.setAttribute("courseList", courseList);
        
        try {
            if (courseID > 0) {
            // Lọc theo Khóa học (nếu courseID > 0)
            materialList = materialDAO.getByCourseAndInstructor(courseID, instructorID); 
            // Lưu lại courseID đã chọn để JSP giữ lại giá trị dropdown
            request.setAttribute("selectedCourseID", courseID);
        } else{
                materialList = materialDAO.getByInstructor(instructorID); // Hiển thị danh sách Material theo instructorID
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Quay lại lấy danh sách mặc định nếu có lỗi trong logic lọc
            materialList = materialDAO.getByInstructor(instructorID);
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình lọc.");
        }

        // Gửi list sang JSP
        request.setAttribute("materialList", materialList);
        
        // Set tab active là material
        request.setAttribute("activeTab", "material-content");

        // Forward về dashboard.jsp
        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
    }

    // Xử lý logic xóa material
    private void handleDelete(HttpServletRequest request, HttpServletResponse response, int materialID)
            throws IOException {
        materialDAO.delete(materialID); 
        request.getSession().setAttribute("message", "Xóa material (ID: " + materialID + ") thành công!");
    }
    
    // Xử lý logic xem chi tiết material
    private void handleView(HttpServletRequest request, HttpServletResponse response, int materialID)
            throws ServletException, IOException {
        
        Material material = materialDAO.getByID(materialID);
        
        if (material != null) {
            request.setAttribute("materialDetail", material);
            // Chuyển hướng đến trang chi tiết material
            request.getRequestDispatcher("/instructor/viewMaterial.jsp").forward(request, response);
        } else {
            int instructorID = (Integer) request.getSession().getAttribute("accountId");
            // Set thông báo lỗi và chuyển hướng về trang danh sách
            request.setAttribute("error", "Không tìm thấy Material có ID: " + materialID);
            handleList(request, response, instructorID, 0);
        }
    }
}