package dao;

import context.DBContext;
import model.Quiz;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO extends DBContext {

    // Helper: map ResultSet → Quiz object
    private Quiz mapResultSet(ResultSet rs) throws SQLException {
        Quiz q = new Quiz();
        q.setQuizID(rs.getInt("QuizID"));
        q.setChapterID(rs.getInt("ChapterID"));
        q.setTitle(rs.getString("Title"));

        // Nếu có join thêm tên Chapter / Course
        try {
            q.setChapterName(rs.getString("ChapterName"));
        } catch (SQLException ignored) {}
        try {
            q.setCourseName(rs.getString("CourseName"));
        } catch (SQLException ignored) {}

        return q;
    }

    /** 
     * Lấy tất cả Quiz kèm tên Chapter & Course 
     */
    public List<Quiz> getAllQuizzes() {
        List<Quiz> list = new ArrayList<>();
        String sql = """
            SELECT q.QuizID, q.Title, q.ChapterID,
                   ch.Title AS ChapterName,
                   c.Title AS CourseName
            FROM Quizzes q
            JOIN Chapters ch ON q.ChapterID = ch.ChapterID
            JOIN Courses c ON c.CourseID = c.CourseID
            ORDER BY q.QuizID DESC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** 
     * Lấy danh sách Quiz theo Instructor (nếu cần)
     */
    public List<Quiz> getQuizzesByInstructor(int instructorId) {
        List<Quiz> list = new ArrayList<>();
        String sql = """
            SELECT q.QuizID, q.Title, q.ChapterID,
                   ch.Title AS ChapterName,
                   c.Title AS CourseName
            FROM Quizzes q
            JOIN Chapters ch ON q.ChapterID = c.ChapterID
            JOIN Courses c ON c.CourseID = cr.CourseID
            WHERE c.InstructorID = ?
            ORDER BY q.QuizID DESC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, instructorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** 
     * Lấy Quiz theo ID 
     */
    public Quiz getQuizById(int id) {
        String sql = """
            SELECT q.QuizID, q.Title, q.ChapterID,
                   ch.Title AS ChapterName,
                   c.Title AS CourseName
            FROM Quizzes q
            JOIN Chapters ch ON q.ChapterID = c.ChapterID
            JOIN Courses c ON c.CourseID = cr.CourseID
            WHERE q.QuizID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** 
     * Thêm Quiz mới 
     */
    public boolean insertQuiz(Quiz q) {
        String sql = "INSERT INTO Quizzes (ChapterID, Title) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, q.getChapterID());
            ps.setString(2, q.getTitle());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 
     * Cập nhật Quiz 
     */
    public boolean updateQuiz(Quiz q) {
        String sql = "UPDATE Quizzes SET ChapterID = ?, Title = ? WHERE QuizID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, q.getChapterID());
            ps.setString(2, q.getTitle());
            ps.setInt(3, q.getQuizID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 
     * Xóa Quiz theo ID 
     */
    public boolean deleteQuiz(int id) {
        String sql = "DELETE FROM Quizzes WHERE QuizID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
