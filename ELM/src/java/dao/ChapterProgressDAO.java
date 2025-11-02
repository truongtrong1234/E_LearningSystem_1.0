package dao;

import context.DBContext;
import model.ChapterProgress;
import java.sql.*;
import java.util.*;

public class ChapterProgressDAO extends DBContext {

    // 🟢 Helper để chuyển ResultSet → ChapterProgress
    private ChapterProgress map(ResultSet rs) throws SQLException {
        return new ChapterProgress(
            rs.getInt("ChapterProgressID"),
            rs.getInt("EnrollmentID"),
            rs.getInt("ChapterID"),
            rs.getBoolean("IsCompleted")
        );
    }

    // 🟢 Lấy tất cả tiến độ
    public List<ChapterProgress> getAll() {
        List<ChapterProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM ChapterProgress";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟢 Lấy tiến độ theo EnrollmentID
    public List<ChapterProgress> getByEnrollment(int enrollmentID) {
        List<ChapterProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM ChapterProgress WHERE EnrollmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟢 Lấy 1 bản ghi cụ thể (enrollment + chapter)
    public ChapterProgress getOne(int enrollmentID, int chapterID) {
        String sql = "SELECT * FROM ChapterProgress WHERE EnrollmentID = ? AND ChapterID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentID);
            ps.setInt(2, chapterID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🟢 Thêm tiến độ mới
    public boolean insert(ChapterProgress cp) {
        String sql = "INSERT INTO ChapterProgress (EnrollmentID, ChapterID, IsCompleted) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cp.getEnrollmentID());
            ps.setInt(2, cp.getChapterID());
            ps.setBoolean(3, cp.isCompleted());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        // ✅ Tạo tiến độ cho tất cả Chapter của khóa học
    public void insertChapterProgressForCourse(int accountID, int courseID) {
        int enrollmentID = getEnrollmentID(accountID, courseID);
        if (enrollmentID == -1) return;

        String sql = """
            INSERT INTO ChapterProgress (EnrollmentID, ChapterID, IsCompleted)
            SELECT ?, c.ChapterID, 0
            FROM Chapters c
            WHERE c.CourseID = ?
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, enrollmentID);
            stm.setInt(2, courseID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
//////
public void updateChapterCompletionIfNeeded(int enrollmentID, int lessonID) {
    String sql = """
        UPDATE ChapterProgress
        SET IsCompleted = CASE 
            WHEN NOT EXISTS (
                SELECT 1 FROM LessonProgress lp
                JOIN Lessons l ON lp.LessonID = l.LessonID
                WHERE lp.EnrollmentID = ? AND l.ChapterID = (
                    SELECT ChapterID FROM Lessons WHERE LessonID = ?
                ) AND lp.IsCompleted = 0
            ) THEN 1 ELSE 0 END
        WHERE EnrollmentID = ? AND ChapterID = (
            SELECT ChapterID FROM Lessons WHERE LessonID = ?
        )
    """;
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, enrollmentID);
        stm.setInt(2, lessonID);
        stm.setInt(3, enrollmentID);
        stm.setInt(4, lessonID);
        stm.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}
    
public Map<Integer, Boolean> getChapterCompletionMap(int accountID, int courseID) {
    Map<Integer, Boolean> map = new HashMap<>();
    String sql = """
        SELECT cp.ChapterID, cp.IsCompleted
        FROM ChapterProgress cp
        JOIN Enrollments e ON cp.EnrollmentID = e.EnrollmentID
        WHERE e.AccountID = ? AND e.CourseID = ?
    """;
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, accountID);
        ps.setInt(2, courseID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            map.put(rs.getInt("ChapterID"), rs.getBoolean("IsCompleted"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return map;
}

    private int getEnrollmentID(int accountID, int courseID) {
        String sql = "SELECT EnrollmentID FROM Enrollments WHERE AccountID = ? AND CourseID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, accountID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) return rs.getInt("EnrollmentID");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }
    // 🟢 Cập nhật trạng thái hoàn thành
    public boolean update(ChapterProgress cp) {
        String sql = "UPDATE ChapterProgress SET IsCompleted = ? WHERE EnrollmentID = ? AND ChapterID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, cp.isCompleted());
            ps.setInt(2, cp.getEnrollmentID());
            ps.setInt(3, cp.getChapterID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

 

    // 🧪 Test thử
    public static void main(String[] args) {
        ChapterProgressDAO dao = new ChapterProgressDAO();
        List<ChapterProgress> list = dao.getAll();

        if (list.isEmpty()) {
            System.out.println("⚠️ Không có dữ liệu ChapterProgress!");
        } else {
            for (ChapterProgress cp : list) {
                System.out.println("ChapterProgressID: " + cp.getChapterProgressID() +
                                   " | EnrollmentID: " + cp.getEnrollmentID() +
                                   " | ChapterID: " + cp.getChapterID() +
                                   " | Completed: " + cp.isCompleted());
            }
        }
    }
}

