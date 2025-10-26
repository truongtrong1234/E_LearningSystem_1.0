package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Chapter;

public class ChapterDAO extends DBContext {

    // CREATE
    public void insertChap(Chapter chapter) {
        String sql = "INSERT INTO Chapters (CourseID, Title) VALUES (?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter.getCourseID());
            stm.setString(2, chapter.getTitle());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all
    public List<Chapter> getAllChap() {
        List<Chapter> list = new ArrayList<>();
        String sql = "SELECT * FROM Chapters";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Chapter c = new Chapter(
                    rs.getInt("ChapterID"),
                    rs.getInt("CourseID"),
                    rs.getString("Title")
                );
                list.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by ID
    public Chapter getChapByID(int id) {
        String sql = "SELECT * FROM Chapters WHERE ChapterID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Chapter(
                    rs.getInt("ChapterID"),
                    rs.getInt("CourseID"),
                    rs.getString("Title")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
     public List<Chapter> getChaptersByCourseId(int courseId) {
        List<Chapter> list = new ArrayList<>();
        String sql = "SELECT ChapterID, CourseID, Title FROM Chapters WHERE CourseID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Chapter ch = new Chapter();
                ch.setChapterID(rs.getInt("ChapterID"));
                ch.setCourseID(rs.getInt("CourseID"));
                ch.setTitle(rs.getString("Title"));
                list.add(ch);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    // UPDATE
    public void updateChap(Chapter chapter) {
        String sql = "UPDATE Chapters SET CourseID = ?, title = ? WHERE ChapterID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter.getCourseID());
            stm.setString(2, chapter.getTitle());
            stm.setInt(3, chapter.getChapterID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void deleteChap(int id) {
        String sql = "DELETE FROM Chapters WHERE ChapterID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // (Tùy chọn) — kiểm tra nhanh
    public static void main(String[] args) {
        ChapterDAO dao = new ChapterDAO();
        System.out.println("Danh sách chương:");
        for (Chapter c : dao.getChaptersByCourseId(1)) {
            System.out.println(c.getChapterID() + " - " + c.getTitle()+ c.getCourseID());
        }
    }
}
