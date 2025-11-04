package dao;

import context.DBContext;
import model.StudentAnswer;
import java.sql.*;
import java.util.*;

public class StudentAnswerDAO extends DBContext {

    // Helper: map ResultSet → StudentAnswer
    private StudentAnswer mapResultSet(ResultSet rs) throws SQLException {
        return new StudentAnswer(
            rs.getInt("AnswerID"),
            rs.getInt("AccountID"),
            rs.getInt("QuestionID"),
            rs.getString("SelectedAnswer").charAt(0),
            rs.getBoolean("IsCorrect")
        );
    }

    // Lấy tất cả
    public List<StudentAnswer> getAll() {
        List<StudentAnswer> list = new ArrayList<>();
        String sql = "SELECT * FROM StudentAnswers";
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

    // Lấy theo AccountID
    public List<StudentAnswer> getByAccount(int accountID) {
        List<StudentAnswer> list = new ArrayList<>();
        String sql = "SELECT * FROM StudentAnswers WHERE AccountID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //  Lấy theo QuizID (thông qua QuestionID)
    public List<StudentAnswer> getByQuiz(int accountID, int quizID) {
        List<StudentAnswer> list = new ArrayList<>();
        String sql = """
            SELECT sa.* 
            FROM StudentAnswers sa
            JOIN Questions q ON sa.QuestionID = q.QuestionID
            WHERE sa.AccountID = ? AND q.QuizID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, quizID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //  Thêm câu trả lời
    public boolean insert(StudentAnswer sa) {
        String sql = "INSERT INTO StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sa.getAccountID());
            ps.setInt(2, sa.getQuestionID());
            ps.setString(3, String.valueOf(sa.getSelectedAnswer()));
            ps.setBoolean(4, sa.isCorrect());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //  Cập nhật
    public boolean update(StudentAnswer sa) {
        String sql = "UPDATE StudentAnswers SET AccountID=?, QuestionID=?, SelectedAnswer=?, IsCorrect=? WHERE AnswerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sa.getAccountID());
            ps.setInt(2, sa.getQuestionID());
            ps.setString(3, String.valueOf(sa.getSelectedAnswer()));
            ps.setBoolean(4, sa.isCorrect());
            ps.setInt(5, sa.getAnswerID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //  Xóa
    public boolean delete(int answerID) {
        String sql = "DELETE FROM StudentAnswers WHERE AnswerID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, answerID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //  Xóa tất cả câu trả lời của 1 học sinh trong 1 quiz
    public boolean deleteByQuiz(int accountID, int quizID) {
        String sql = """
            DELETE sa
            FROM StudentAnswers sa
            JOIN Questions q ON sa.QuestionID = q.QuestionID
            WHERE sa.AccountID = ? AND q.QuizID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, quizID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Test main
    public static void main(String[] args) {
        StudentAnswerDAO dao = new StudentAnswerDAO();
        List<StudentAnswer> list = dao.getAll();

        if (list.isEmpty()) {
            System.out.println("⚠️ Không có dữ liệu StudentAnswers trong DB!");
        } else {
            for (StudentAnswer sa : list) {
                System.out.println("AnswerID: " + sa.getAnswerID() +
                                   " | AccountID: " + sa.getAccountID() +
                                   " | QuestionID: " + sa.getQuestionID() +
                                   " | Selected: " + sa.getSelectedAnswer() +
                                   " | Correct: " + sa.isCorrect());
            }
        }
    }
}
