package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Quiz;

public class QuizDAO {

    // Lấy tất cả quiz
    public List<Quiz> getAllQuizzes() {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT QuizID, ChapterID, Title FROM Quizzes ORDER BY QuizID DESC";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Quiz q = new Quiz();
                q.setQuizID(rs.getInt("QuizID"));
                q.setChapterID(rs.getInt("ChapterID"));
                q.setTitle(rs.getString("Title"));
                list.add(q);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy quiz theo Chapter
    public List<Quiz> getQuizzesByChapter(int chapterID) {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT QuizID, ChapterID, Title FROM Quizzes WHERE ChapterID = ? ORDER BY QuizID DESC";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, chapterID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setTitle(rs.getString("Title"));
                    list.add(q);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

        // Lấy quiz theo ID
    public Quiz getQuizById(int id) {
        String sql = "SELECT q.QuizID, c.ChapterID, q.Title, c.CourseID "
           + "FROM Quizzes q "
           + "JOIN Chapters c ON c.ChapterID = q.ChapterID "
           + "WHERE q.QuizID = ?";

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("quizID"));
                    q.setTitle(rs.getString("title"));
                    q.setChapterID(rs.getInt("chapterID"));
                    q.setCourseID(rs.getInt("courseID")); // ✅ nhớ thêm dòng này
                    return q;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    

    // Lấy quiz theo Course
    public List<Quiz> getQuizzesByCourseID(int courseID) {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT q.QuizID, q.ChapterID, q.Title " +
                     "FROM Quizzes q " +
                     "JOIN Chapters c ON q.ChapterID = c.ChapterID " +
                     "WHERE c.CourseID = ? " +
                     "ORDER BY q.QuizID DESC";

        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setTitle(rs.getString("Title"));
                    list.add(q);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy quiz theo Course + Chapter 
    public List<Quiz> getQuizzesByCourseAndChapter(int courseID, int chapterID) {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT q.QuizID, q.ChapterID, q.Title " +
                     "FROM Quizzes q " +
                     "JOIN Chapters c ON q.ChapterID = c.ChapterID " +
                     "WHERE c.CourseID = ? AND q.ChapterID = ? " +
                     "ORDER BY q.QuizID DESC";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseID);
            ps.setInt(2, chapterID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setTitle(rs.getString("Title"));
                    list.add(q);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy quiz theo instructorID
    public List<Quiz> getQuizzesByInstructorID(int instructorID) {
        List<Quiz> list = new ArrayList<>();
        String sql = """
            SELECT q.QuizID, q.Title,
                   c.ChapterID, c.Title AS ChapterName,
                   co.CourseID, co.Title AS CourseName
            FROM Quizzes q
            INNER JOIN Chapters c ON q.ChapterID = c.ChapterID
            INNER JOIN Courses co ON c.CourseID = co.CourseID
            WHERE co.InstructorID = ?
            ORDER BY q.QuizID DESC
        """;

        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, instructorID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setTitle(rs.getString("Title"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setCourseID(rs.getInt("CourseID"));
                    q.setChapterName(rs.getString("ChapterName"));
                    q.setCourseName(rs.getString("CourseName"));
                    list.add(q);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy quiz theo course + instructor
    public List<Quiz> getByCourseAndInstructor(int courseID, int instructorID) {
        List<Quiz> list = new ArrayList<>();
        String sql = """
            SELECT q.QuizID, q.Title,
                   c.ChapterID, c.Title AS ChapterName,
                   co.CourseID, co.Title AS CourseName
            FROM Quizzes q
            INNER JOIN Chapters c ON q.ChapterID = c.ChapterID
            INNER JOIN Courses co ON c.CourseID = co.CourseID
            WHERE co.InstructorID = ? AND co.CourseID = ?
            ORDER BY q.QuizID DESC
        """;

        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, instructorID);
            ps.setInt(2, courseID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setTitle(rs.getString("Title"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setCourseID(rs.getInt("CourseID"));
                    q.setChapterName(rs.getString("ChapterName"));
                    q.setCourseName(rs.getString("CourseName"));
                    list.add(q);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Thêm quiz 
    public boolean insertQuiz(Quiz q) {
        String sql = "INSERT INTO Quizzes (ChapterID, Title) VALUES (?, ?)";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, q.getChapterID());
            ps.setString(2, q.getTitle());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm quiz và trả về ID vừa tạo
    public int insertQuizReturnId(Quiz q) {
        String sql = "INSERT INTO Quizzes (ChapterID, Title) VALUES (?, ?)";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, q.getChapterID());
            ps.setString(2, q.getTitle());

            int affected = ps.executeUpdate();
            if (affected == 0) return -1;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Cập nhật quiz
    public void updateQuiz(Quiz quiz) {
        String sql = "UPDATE Quizzes SET Title = ?, ChapterID = ? WHERE QuizID = ?"; 
        
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, quiz.getTitle());
            ps.setInt(2, quiz.getChapterID());
            ps.setInt(3, quiz.getQuizID()); 

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL khi cập nhật Quiz: " + e.getMessage()); 
        }
    }

   public void deleteQuiz(int quizID) {
        String sql = "DELETE FROM Quizzes WHERE QuizID = ?";
        
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quizID);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new RuntimeException("Không tìm thấy Bài kiểm tra có ID: " + quizID + " để xóa.");
            }
        } catch (SQLException e) {
            String errorMessage = e.getMessage();

            if (errorMessage != null && errorMessage.contains("FOREIGN KEY")) {
                throw new RuntimeException("Không thể xóa Quiz ID " + quizID + ". " +
                                           "Còn tồn tại các Câu hỏi (Questions) hoặc dữ liệu liên quan khác.");
            }
            throw new RuntimeException("Lỗi SQL khi xóa Quiz: " + errorMessage);

        }
    }
}

