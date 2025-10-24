package dao;

import context.DBContext;
import model.Lesson;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LessonDAO extends DBContext {

    // CREATE
    public void insert(Lesson l) {
        String sql = "INSERT INTO Lessons (ChapterID, Title) VALUES (?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, l.getChapterID());
            stm.setString(2, l.getTitle());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
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

    // UPDATE
    public void update(Lesson l) {
        String sql = "UPDATE Lessons SET ChapterID = ?, Title = ? WHERE LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, l.getChapterID());
            stm.setString(2, l.getTitle());
            stm.setInt(3, l.getLessonID());
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

    // Kiểm tra nhanh
    public static void main(String[] args) {
        LessonDAO dao = new LessonDAO();
        System.out.println("Danh sách lessons:");
        for (Lesson l : dao.getAll()) {
            System.out.println(l.getLessonID() + " | " + l.getChapterID() + " | " + l.getTitle());
        }
    }
}
