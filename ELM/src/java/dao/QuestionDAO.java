package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Question;

public class QuestionDAO {
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

   
   public boolean deleteQuestion(int id) {
    String sql = "{CALL deleteQuestion(?)}"; 
    
    try (Connection con = new DBContext().getConnection();
         CallableStatement cs = con.prepareCall(sql)) {
        
        cs.setInt(1, id);
        cs.execute();
        return true;

    } catch (SQLException e) {
        String msg = e.getMessage();
        if (msg != null && msg.contains("FOREIGN KEY")) {
            throw new RuntimeException("Không thể xóa câu hỏi ID " + id + 
                ". Còn tồn tại dữ liệu StudentAnswers liên quan.");
        }
        throw new RuntimeException("Lỗi SQL khi xóa câu hỏi: " + msg, e);
    }
}
    public static void main(String[] args) {
        QuestionDAO dao  = new QuestionDAO(); 
        dao.deleteQuestion(21); 
    }
}
