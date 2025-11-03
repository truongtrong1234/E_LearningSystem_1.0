package dao;

import java.sql.*;
import java.util.*;
import model.Question;
import context.DBContext;

public class QuestionDAO {
    public void insertQuestion(Question q) {
        String sql = "INSERT INTO Question (quizID, questionText, optionA, optionB, optionC, optionD, correctAnswer) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBContext.getConnectionStatic();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, q.getQuizID());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectAnswer());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Question> getQuestionsByQuizID(int quizID) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Question WHERE quizID=?";
        try (Connection con = DBContext.getConnectionStatic();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, quizID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Question(
                    rs.getInt("questionID"),
                    rs.getInt("quizID"),
                    rs.getString("questionText"),
                    rs.getString("optionA"),
                    rs.getString("optionB"),
                    rs.getString("optionC"),
                    rs.getString("optionD"),
                    rs.getString("correctAnswer")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
