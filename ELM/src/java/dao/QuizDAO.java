package dao;

import context.DBContext;
import model.Quiz;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    // =============================
    // Thêm Quiz mới và trả về ID
    // =============================
    public int insertQuizReturnId(Quiz quiz) {
        String sql = "INSERT INTO Quizzes (ChapterID, Title) VALUES (?, ?)";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, quiz.getChapterID());
            ps.setString(2, quiz.getTitle());
            int affected = ps.executeUpdate();

            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // quizID mới tạo
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // nếu fail
    }

    // =============================
    // Lấy danh sách tất cả Quiz
    // =============================
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

    // =====================================
    // Lấy danh sách Quiz theo ChapterID
    // =====================================
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

    // =================================
    // Lấy Quiz theo QuizID
    // =================================
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

    // ========================================
    // Lấy tất cả quiz theo CourseID (JOIN)
    // ========================================
    public List<Quiz> getQuizzesByCourseID(int courseID) {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT q.QuizID, q.ChapterID, q.Title " +
                     "FROM Quizzes q " +
                     "JOIN Chapters c ON q.ChapterID = c.ChapterID " +
                     "WHERE c.CourseID = ? ORDER BY q.QuizID DESC";

        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseID);
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

    // =====================================================
    // Lấy courseID từ chapterID (để redirect sau khi lưu)
    // =====================================================
    public int getCourseIdByChapterId(int chapterID) {
        String sql = "SELECT CourseID FROM Chapters WHERE ChapterID = ?";
        try (Connection con = new DBContext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, chapterID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("CourseID");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Không tìm thấy
    }

    // =============================
    // Test nhanh DAO
    // =============================
    public static void main(String[] args) {
        QuizDAO dao = new QuizDAO();

        try {
            // Test chèn quiz mới
            Quiz quiz = new Quiz();
            quiz.setChapterID(3);
            quiz.setTitle("Unit Test Quiz");
            int newId = dao.insertQuizReturnId(quiz);
            System.out.println("New QuizID: " + newId);

            // Test lấy theo chapter
            List<Quiz> list = dao.getQuizzesByChapter(3);
            for (Quiz q : list) {
                System.out.println(q.getQuizID() + " - " + q.getTitle());
            }

            // Test lấy courseID từ chapterID
            int courseID = dao.getCourseIdByChapterId(3);
            System.out.println("CourseID of Chapter 3: " + courseID);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
