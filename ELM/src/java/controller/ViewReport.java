/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;
import dao.ReportDAO;
import dao.ReportReplyDAO;
import model.Report;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ReportReply;

/**
 *
 * @author ADMIN
 */
public class ViewReport extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ViewReport</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewReport at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id_raw = request.getParameter("id");
        if (id_raw == null || id_raw.isEmpty()) {
            response.sendRedirect("sendReport");
            return;
        }

        try {
            int id = Integer.parseInt(id_raw);

            ReportDAO reportDAO = new ReportDAO();
            ReportReplyDAO replyDAO = new ReportReplyDAO();


            // ✅ Lấy thông tin report + danh sách replies
            Report report = reportDAO.getReportById(id);
            List<ReportReply> replies = replyDAO.getRepliesByReportId(id);

            if (report == null) {
                response.sendRedirect("sendReport");
                return;
            }

            request.setAttribute("report", report);
            request.setAttribute("replies", replies);
            request.getRequestDispatcher("/instructor/ViewReport.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("sendReport");
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
