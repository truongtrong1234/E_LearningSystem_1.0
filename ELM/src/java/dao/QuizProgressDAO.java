package dao;

import context.DBContext;
import model.QuizProgress;
import java.sql.*;
import java.math.BigDecimal;
import java.util.*;

public class QuizProgressDAO extends DBContext {

    // Helper: map ResultSet → QuizProgress object
    private QuizProgress mapResultSet(ResultSet rs) throws SQLException {
        return new QuizProgress(
            rs.getInt("ProgressID"),
            rs.getInt("AccountID"),
            rs.getInt("QuizID"),
            rs.getObject("CorrectCount") != null ? rs.getInt("CorrectCount") : null,
            rs.getBigDecimal("TotalScore"),
            rs.getTimestamp("TakenDate")
        );
    }

    // Lấy tất cả tiến độ quiz
    public List<QuizProgress> getAllQuizProgress() {
        List<QuizProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM QuizProgress";
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

    // Lấy tiến độ theo ProgressID
    public QuizProgress getQuizProgressById(int progressID) {
        String sql = "SELECT * FROM QuizProgress WHERE ProgressID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, progressID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy tiến độ theo AccountID & QuizID
    public QuizProgress getQuizProgressByAccountAndQuiz(int accountID, int quizID) {
        String sql = "SELECT * FROM QuizProgress WHERE AccountID = ? AND QuizID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, quizID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm mới tiến độ quiz
    public boolean insertQuizProgress(QuizProgress qp) {
        String sql = """
            INSERT INTO QuizProgress (AccountID, QuizID, CorrectCount, TotalScore, TakenDate)
            VALUES (?, ?, ?, ?, ?)
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, qp.getAccountID());
            ps.setInt(2, qp.getQuizID());
            if (qp.getCorrectCount() != null) ps.setInt(3, qp.getCorrectCount());
            else ps.setNull(3, Types.INTEGER);
            ps.setBigDecimal(4, qp.getTotalScore() != null ? qp.getTotalScore() : BigDecimal.ZERO);
            ps.setTimestamp(5, qp.getTakenDate() != null ? new Timestamp(qp.getTakenDate().getTime()) : new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật tiến độ quiz
    public boolean updateQuizProgress(QuizProgress qp) {
        String sql = """
            UPDATE QuizProgress
            SET AccountID = ?, QuizID = ?, CorrectCount = ?, TotalScore = ?, TakenDate = ?
            WHERE ProgressID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, qp.getAccountID());
            ps.setInt(2, qp.getQuizID());
            if (qp.getCorrectCount() != null) ps.setInt(3, qp.getCorrectCount());
            else ps.setNull(3, Types.INTEGER);
            ps.setBigDecimal(4, qp.getTotalScore());
            ps.setTimestamp(5, new Timestamp(qp.getTakenDate().getTime()));
            ps.setInt(6, qp.getProgressID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

  public boolean deleteQuizProgress(int accountID, int quizID) {
    String sql = "DELETE FROM QuizProgress WHERE AccountID = ? AND QuizID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, accountID);
        ps.setInt(2, quizID);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    public int countCorrectAnswers(int accountID, int quizID) {
        int correctCount = 0;
        String sql = "SELECT COUNT(*) FROM StudentAnswers sa " +
                     "JOIN Questions q ON sa.QuestionID = q.QuestionID " +
                     "WHERE sa.AccountID = ? AND q.QuizID = ? AND sa.IsCorrect = 1";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, quizID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                correctCount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return correctCount;
    }

    public int totalQuestions(int quizID) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Questions WHERE QuizID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quizID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public void saveProgress(int accountID, int quizID, int correctCount, double totalScore) {
        String sql = "INSERT INTO QuizProgress(AccountID, QuizID, CorrectCount, TotalScore, TakenDate) " +
                     "VALUES (?, ?, ?, ?, GETDATE())";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, quizID);
            ps.setInt(3, correctCount);
            ps.setDouble(4, totalScore);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // Test main
    public static void main(String[] args) {
        QuizProgressDAO dao = new QuizProgressDAO();
        int i = dao.countCorrectAnswers(2, 5); 
        System.out.println(i);
    }
}
