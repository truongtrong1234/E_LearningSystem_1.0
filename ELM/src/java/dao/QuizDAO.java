package dao;

import context.DBContext;
import model.Quiz;
import java.sql.*;
import java.util.*;

public class QuizDAO extends DBContext {

    // 🟢 Helper: map ResultSet → Quiz object
    private Quiz mapResultSet(ResultSet rs) throws SQLException {
        return new Quiz(
            rs.getInt("QuizID"),
            rs.getInt("ChapterID"),
            rs.getString("Title")
        );
    }

    // 🟢 Lấy tất cả Quiz
    public List<Quiz> getAllQuizzes() {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT * FROM Quizzes";
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

    // 🟢 Lấy Quiz theo ID
    public Quiz getQuizById(int id) {
        String sql = "SELECT * FROM Quizzes WHERE QuizID = ?";
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

    // 🟢 Thêm Quiz mới
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

    // 🟢 Cập nhật Quiz
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

    // 🟢 Xóa Quiz theo ID
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

    // 🧪 Test main
    public static void main(String[] args) {
        QuizDAO dao = new QuizDAO();
        List<Quiz> quizzes = dao.getAllQuizzes();

        if (quizzes.isEmpty()) {
            System.out.println("⚠️ Không có quiz nào trong database!");
        } else {
            for (Quiz q : quizzes) {
                System.out.println("QuizID: " + q.getQuizID() +
                                   " | ChapterID: " + q.getChapterID() +
                                   " | Title: " + q.getTitle());
            }
        }
    }
}
