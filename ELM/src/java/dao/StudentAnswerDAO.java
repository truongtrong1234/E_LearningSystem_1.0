package dao;

import context.DBContext;
import model.StudentAnswer;

import java.sql.*;
import java.util.*;

public class StudentAnswerDAO extends DBContext {

    // 🟢 Helper: map ResultSet → StudentAnswer
    private StudentAnswer mapResultSet(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("AnsweredAt");
        return new StudentAnswer(
            rs.getInt("AnswerID"),
            rs.getInt("AccountID"),
            rs.getInt("QuestionID"),
            rs.getString("SelectedAnswer").charAt(0),
            rs.getBoolean("IsCorrect"),
            ts != null ? new java.util.Date(ts.getTime()) : null
        );
    }

    // 🟢 Lấy tất cả câu trả lời
    public List<StudentAnswer> getAllStudentAnswers() {
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

    // 🟢 Lấy câu trả lời theo ID
    public StudentAnswer getStudentAnswerById(int answerID) {
        String sql = "SELECT * FROM StudentAnswers WHERE AnswerID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, answerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🟢 Thêm mới câu trả lời
    public boolean insertStudentAnswer(StudentAnswer sa) {
        String sql = "INSERT INTO StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect, AnsweredAt) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sa.getAccountID());
            ps.setInt(2, sa.getQuestionID());
            ps.setString(3, String.valueOf(sa.getSelectedAnswer()));
            ps.setBoolean(4, sa.isCorrect());
            if (sa.getAnsweredAt() != null) {
                ps.setTimestamp(5, new Timestamp(sa.getAnsweredAt().getTime()));
            } else {
                ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Cập nhật câu trả lời
    public boolean updateStudentAnswer(StudentAnswer sa) {
        String sql = "UPDATE StudentAnswers SET AccountID=?, QuestionID=?, SelectedAnswer=?, IsCorrect=?, AnsweredAt=? WHERE AnswerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sa.getAccountID());
            ps.setInt(2, sa.getQuestionID());
            ps.setString(3, String.valueOf(sa.getSelectedAnswer()));
            ps.setBoolean(4, sa.isCorrect());
            ps.setTimestamp(5, new Timestamp(sa.getAnsweredAt().getTime()));
            ps.setInt(6, sa.getAnswerID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Xóa câu trả lời
    public boolean deleteStudentAnswer(int answerID) {
        String sql = "DELETE FROM StudentAnswers WHERE AnswerID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, answerID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🧪 Test main
    public static void main(String[] args) {
        StudentAnswerDAO dao = new StudentAnswerDAO();
        List<StudentAnswer> list = dao.getAllStudentAnswers();

        if (list.isEmpty()) {
            System.out.println("⚠️ Không có dữ liệu StudentAnswers trong DB!");
        } else {
            for (StudentAnswer sa : list) {
                System.out.println("AnswerID: " + sa.getAnswerID() +
                                   " | AccountID: " + sa.getAccountID() +
                                   " | QuestionID: " + sa.getQuestionID() +
                                   " | SelectedAnswer: " + sa.getSelectedAnswer() +
                                   " | IsCorrect: " + sa.isCorrect() +
                                   " | AnsweredAt: " + sa.getAnsweredAt());
            }
        }
    }
}
