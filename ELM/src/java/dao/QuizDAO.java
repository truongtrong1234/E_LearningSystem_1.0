package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Quiz;

public class QuizDAO {
    // Lấy danh sách tất cả quiz
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

    // Lấy danh sách quiz theo Chapter
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

    // Lấy 1 quiz theo ID
    public Quiz getQuizById(int id) {
        String sql = "SELECT QuizID, ChapterID, Title FROM Quizzes WHERE QuizID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Quiz q = new Quiz();
                    q.setQuizID(rs.getInt("QuizID"));
                    q.setChapterID(rs.getInt("ChapterID"));
                    q.setTitle(rs.getString("Title"));
                    return q;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm mới quiz - trả về boolean (cũ)
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

    // Thêm mới quiz và trả về QuizID vừa tạo (sử dụng generated keys) -> trả về -1 nếu lỗi
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
                } else {
                    return -1;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    // Cập nhật quiz
    public boolean updateQuiz(Quiz q) {
        String sql = "UPDATE Quizzes SET ChapterID=?, Title=? WHERE QuizID=?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, q.getChapterID());
            ps.setString(2, q.getTitle());
            ps.setInt(3, q.getQuizID());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa quiz
    public boolean deleteQuiz(int id) {
        String sql = "DELETE FROM Quizzes WHERE QuizID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
