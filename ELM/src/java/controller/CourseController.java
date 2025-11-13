package controller;

import dao.CategoryDAO;
import dao.ChapterDAO;
import dao.CourseDAO;
import dao.LessonDAO;
import dao.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Category;
import model.Chapter;
import model.Course;
import model.Lesson;
import model.Material;

public class CourseController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        CourseDAO cdao = new CourseDAO();
        HttpSession session = request.getSession(); 
        String actionCourse = request.getParameter("actionCourse");
        
//        Hiển thị phần Chapter
        String courseIDString = request.getParameter("courseID");
        if (courseIDString==null) {
            courseIDString = ""+ 0 ; 
        }
        int courseID = Integer.parseInt(courseIDString);
        
        
        request.setAttribute("thisCourseID", courseID);
        ChapterDAO dao = new ChapterDAO();
        List<Chapter> chapters = dao.getChaptersByCourseId(courseID);
        request.setAttribute("chapters", chapters);
        request.setAttribute("courseID", courseID);
        String chapterIDString = request.getParameter("ChapterID");
        if (chapterIDString==null) {
            chapterIDString = ""+ 0 ; 
        }
        int ChapterID = Integer.parseInt(chapterIDString);
        LessonDAO lessonDao = new LessonDAO();
        List<Lesson> Lessons = lessonDao.getByChapterID(ChapterID);
        request.setAttribute("Lessons", Lessons);
        request.setAttribute("thischapterID", ChapterID);
        
        
        String lessonIDString = request.getParameter("LessonID");
        if (lessonIDString==null) {
            lessonIDString = ""+ 0 ; 
        }
        int LessonID = Integer.parseInt(lessonIDString);
        MaterialDAO mateDAO = new MaterialDAO();
        List<Material> material = mateDAO.getByLessonID(LessonID);
        request.setAttribute("material", material);
        request.setAttribute("thisLessonID", LessonID);
        
        String courseIDString1 = request.getParameter("id");
        if (courseIDString1==null) {
            courseIDString1 = ""+ 0 ; 
        }
        int courseId = Integer.parseInt(courseIDString1);
        Course course = new Course();
        course = cdao.getCourseById(courseId);
        request.setAttribute("course", course);
        
        Account account = (Account) session.getAttribute("account"); 
        int accountID = account.getAccountId();
        List<Course> courseList = cdao.getCourseByInstructorID(accountID); 
        request.setAttribute("actionCourse", actionCourse);
        request.setAttribute("courseList", courseList);
        CategoryDAO catedao = new CategoryDAO();
        List<Category> categoryList = catedao.getAllCat();
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int action =Integer.parseInt(request.getParameter("action")) ;
        CourseDAO cdao = new  CourseDAO();
        cdao.deleteCourse(action); 
        response.sendRedirect("/ELM/instructor/dashboard");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
