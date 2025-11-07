package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Chapter;
import model.Course;

public class ChapterDAO extends DBContext {
public int countLessonsByCourse(int courseID) {
    String sql = "SELECT COUNT(*) AS total " +
                 "FROM Lessons l " +
                 "JOIN Chapters c ON l.ChapterID = c.ChapterID " +
                 "WHERE c.CourseID = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, courseID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) return rs.getInt("total");
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}

public int countCompletedLessons(int accountID, int courseID) {
    String sql = "SELECT COUNT(*) AS completed " +
                 "FROM LessonProgress lp " +
                 "JOIN Lessons l ON lp.LessonID = l.LessonID " +
                 "JOIN Chapters c ON l.ChapterID = c.ChapterID " +
                 "JOIN Enrollments e ON lp.EnrollmentID = e.EnrollmentID " +
                 "WHERE e.AccountID = ? AND c.CourseID = ? AND lp.IsCompleted = 1";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, accountID);
        stm.setInt(2, courseID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) return rs.getInt("completed");
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}


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
    public int insertChapterAndReturnID(Chapter chapter) {
    String sql = "INSERT INTO Chapters (CourseID, Title) VALUES (?, ?)";
    try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        stm.setInt(1, chapter.getCourseID());
        stm.setString(2, chapter.getTitle());

        int affected = stm.executeUpdate(); // ✅ chỉ gọi 1 lần
        if (affected > 0) {
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // ✅ Trả về ChapterID vừa tạo
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1;
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
    public void updateChapterTitle(int chapterID, String newTitle) {
    String sql = "UPDATE Chapters SET Title = ? WHERE ChapterID = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setString(1, newTitle);
        stm.setInt(2, chapterID);
        stm.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}

    // DELETE
//    public void deleteChap(int id) {
//        String sql = "DELETE FROM Chapters WHERE ChapterID = ?";
//        try {
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setInt(1, id);
//            stm.executeUpdate();
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//    }
    public void deleteChap(int chapterId) {
        String sql = "{call deleteChapter(?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, chapterId);
            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Test
    public static void main(String[] args) {
        ChapterDAO dao = new ChapterDAO();
        Chapter c = new Chapter();
       
    }
}
