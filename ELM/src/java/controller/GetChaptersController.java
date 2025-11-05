package controller;

import com.google.gson.Gson;
import dao.ChapterDAO;
import model.Chapter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.List;

@WebServlet("/instructor/getChapters")
public class GetChaptersController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sCourseId = req.getParameter("courseId");
        if (sCourseId == null || sCourseId.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int courseId = Integer.parseInt(sCourseId);
        ChapterDAO dao = new ChapterDAO();
        List<Chapter> chapters = dao.getChaptersByCourseId(courseId);

        resp.setContentType("application/json;charset=UTF-8");
        String json = new Gson().toJson(chapters);
        resp.getWriter().write(json);
    }
}
