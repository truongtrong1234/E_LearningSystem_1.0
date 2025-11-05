package dao;

import context.DBContext;
import model.Lesson;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LessonDAO extends DBContext {

    // CREATE
    public int insert(Lesson l) {
        String sql = "INSERT INTO Lessons (ChapterID, Title) VALUES (?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setInt(1, l.getChapterID());
            stm.setString(2, l.getTitle());
            int affected = stm.executeUpdate(); // ✅ chỉ gọi 1 lần
            if (affected > 0) {
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // ✅ Trả về ChapterID vừa tạo
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    // READ - get all lessons
    public List<Lesson> getAll() {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM Lessons";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Lesson(
                        rs.getInt("LessonID"),
                        rs.getInt("ChapterID"),
                        rs.getString("Title")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by ID
    public Lesson getByID(int id) {
        String sql = "SELECT * FROM Lessons WHERE LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Lesson(
                        rs.getInt("LessonID"),
                        rs.getInt("ChapterID"),
                        rs.getString("Title")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // READ - get all lessons by chapterID
    public List<Lesson> getByChapterID(int chapterID) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM Lessons WHERE ChapterID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Lesson(
                        rs.getInt("LessonID"),
                        rs.getInt("ChapterID"),
                        rs.getString("Title")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Lesson> getByCourseID(int courseID) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM Lessons WHERE CourseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Lesson(
                        rs.getInt("LessonID"),
                        rs.getInt("ChapterID"),
                        rs.getString("Title")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateLesson(int lessonID, String newTitle) {
        String sql = "UPDATE Lessons SET Title = ? WHERE LessonID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, newTitle);
            stm.setInt(2, lessonID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void delete(int id) {
        String sql = "DELETE FROM Lessons WHERE LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Test
    public static void main(String[] args) {
        LessonDAO dao = new LessonDAO();
        Lesson les = new Lesson();
        les.setChapterID(1);
        les.setTitle("vldvl");
        int id = dao.insert(les);
        System.out.println(id);
    }
}
