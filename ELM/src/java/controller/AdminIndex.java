package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import context.DBContext;

public class AdminIndex extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userCount = 0, courseCount = 0, reportCount = 0 ; int requestCount=0;

        try (Connection conn = new DBContext().getConnection();
             Statement st = conn.createStatement()) {

            ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM Accounts");
            if (rs1.next()) userCount = rs1.getInt(1);
            rs1.close();

            ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM Courses");
            if (rs2.next()) courseCount = rs2.getInt(1);
            rs2.close();

            ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM Reports");
            if (rs3.next()) reportCount = rs3.getInt(1);
            rs3.close();
            
            ResultSet rs4=st.executeQuery("select count (*) from InstructorRequest");
            if(rs4.next()) requestCount= rs4.getInt(1);
            rs4.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("userCount", userCount);
        request.setAttribute("courseCount", courseCount);
        request.setAttribute("reportCount", reportCount);
        request.setAttribute("requestCount", requestCount);

        request.getRequestDispatcher("/admin/adminIndex.jsp").forward(request, response);
    }
}
