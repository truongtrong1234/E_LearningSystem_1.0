package dao;

import java.sql.*;
import java.util.*;
import model.Question;
import context.DBContext;

public class QuestionDAO {

    // Thêm mới câu hỏi
    public void insertQuestion(Question q) {
        String sql = """
            INSERT INTO Questions 
            (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, q.getQuizID());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectAnswer());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách câu hỏi theo QuizID
    public List<Question> getQuestionsByQuizID(int quizID) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Questions WHERE QuizID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quizID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Question(
                    rs.getInt("QuestionID"),
                    rs.getInt("QuizID"),
                    rs.getString("QuestionText"),
                    rs.getString("OptionA"),
                    rs.getString("OptionB"),
                    rs.getString("OptionC"),
                    rs.getString("OptionD"),
                    rs.getString("CorrectAnswer")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết một câu hỏi
    public Question getQuestionById(int id) {
        String sql = "SELECT * FROM Questions WHERE QuestionID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Question(
                    rs.getInt("QuestionID"),
                    rs.getInt("QuizID"),
                    rs.getString("QuestionText"),
                    rs.getString("OptionA"),
                    rs.getString("OptionB"),
                    rs.getString("OptionC"),
                    rs.getString("OptionD"),
                    rs.getString("CorrectAnswer")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật câu hỏi
    public boolean updateQuestion(Question q) {
        String sql = """
            UPDATE Questions
            SET QuestionText=?, OptionA=?, OptionB=?, OptionC=?, OptionD=?, CorrectAnswer=?
            WHERE QuestionID=?
        """;
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, q.getQuestionText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectAnswer());
            ps.setInt(7, q.getQuestionID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa câu hỏi
    public boolean deleteQuestion(int id) {
        String sql = "DELETE FROM Questions WHERE QuestionID = ?";
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
