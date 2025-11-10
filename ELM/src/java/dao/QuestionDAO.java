package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Question;

public class QuestionDAO {
    /**
     * Thêm mới câu hỏi vào cơ sở dữ liệu
     * @param q Question object
     */
    public void insertQuestion(Question q) {
        String sql = "INSERT INTO Questions " +
                     "(QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
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

    /**
     * Lấy danh sách tất cả câu hỏi theo QuizID
     * @param quizID ID của quiz
     * @return List<Question>
     */
    public List<Question> getQuestionsByQuizID(int quizID) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Questions WHERE QuizID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quizID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question(
                            rs.getInt("QuestionID"),
                            rs.getInt("QuizID"),
                            rs.getString("QuestionText"),
                            rs.getString("OptionA"),
                            rs.getString("OptionB"),
                            rs.getString("OptionC"),
                            rs.getString("OptionD"),
                            rs.getString("CorrectAnswer")
                    );
                    list.add(q);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy chi tiết một câu hỏi theo ID
     * @param id QuestionID
     * @return Question object hoặc null nếu không tồn tại
     */
    public Question getQuestionById(int id) {
        String sql = "SELECT * FROM Questions WHERE QuestionID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
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
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật thông tin câu hỏi
     * @param q Question object
     * @return true nếu update thành công, false nếu thất bại
     */
    public boolean updateQuestion(Question q) {
        String sql = "UPDATE Questions SET " +
                     "QuestionText=?, OptionA=?, OptionB=?, OptionC=?, OptionD=?, CorrectAnswer=? " +
                     "WHERE QuestionID=?";
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

    /**
     * Xóa câu hỏi theo QuestionID
     * @param id QuestionID
     * @return true nếu xóa thành công, false nếu thất bại
     */
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
    public static void main(String[] args) {
        QuestionDAO dao  = new QuestionDAO(); 
        dao.deleteQuestion(21); 
    }
}
