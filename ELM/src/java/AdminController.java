package controller;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import java.io.*;
import java.util.*;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private AdminDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String section = req.getParameter("section");
        if (section == null) section = "accounts";

        switch (section) {
            case "accounts":
                req.setAttribute("users", dao.getAllAccounts());
                req.getRequestDispatcher("/admin/adminAccounts.jsp").forward(req, resp);
                break;
            case "editAccount":
                int uid = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("user", dao.getAccountById(uid));
                req.getRequestDispatcher("/admin/editAccount.jsp").forward(req, resp);
                break;
            case "courses":
                req.setAttribute("courses", dao.getAllCourses());
                req.getRequestDispatcher("/admin/adminCourses.jsp").forward(req, resp);
                break;
            case "editCourse":
                int cid = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("course", dao.getCourseById(cid));
                req.getRequestDispatcher("/admin/editCourse.jsp").forward(req, resp);
                break;
            case "reports":
                req.setAttribute("reports", dao.getAllReports());
                req.getRequestDispatcher("/admin/adminReports.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin?section=accounts");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) { resp.sendRedirect(req.getContextPath() + "/admin"); return; }

        switch (action) {
            case "updateAccount": {
                int id = Integer.parseInt(req.getParameter("id"));
                String email = req.getParameter("email");
                String name = req.getParameter("name");
                String pass = req.getParameter("password");
                String role = req.getParameter("role");
                dao.updateAccount(id, email, pass, name, role);
                resp.sendRedirect(req.getContextPath() + "/admin?section=accounts");
                break;
            }
            case "deleteAccount": {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteAccount(id);
                resp.getWriter().write("ok");
                break;
            }
            case "updateCourse": {
                int id = Integer.parseInt(req.getParameter("id"));
                String title = req.getParameter("title");
                String category = req.getParameter("category");
                String level = req.getParameter("level");
                String language = req.getParameter("language");
                double price = Double.parseDouble(req.getParameter("price"));
                String description = req.getParameter("description");
                dao.updateCourse(id, title, category, level, language, price, description);
                resp.sendRedirect(req.getContextPath() + "/admin?section=courses");
                break;
            }
            case "deleteCourse": {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteCourse(id);
                resp.getWriter().write("ok");
                break;
            }
            case "deleteReport": {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteReport(id);
                resp.getWriter().write("ok");
                break;
            }
            default:
                resp.sendError(400);
        }
    }
}
