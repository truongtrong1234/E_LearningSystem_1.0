package dao;

import context.DBContext;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class LessonProgressDAO extends DBContext {

    // Tạo tiến độ cho tất cả Lesson của khóa học
    public void insertLessonProgressForCourse(int accountID, int courseID) {
        int enrollmentID = getEnrollmentID(accountID, courseID);
        if (enrollmentID == -1) return;

        String sql = """
            INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted)
            SELECT ?, l.LessonID, 0
            FROM Lessons l
            INNER JOIN Chapters c ON l.ChapterID = c.ChapterID
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
    public void updateLessonCompletion(int enrollmentID, int lessonID, boolean isCompleted) {
    String sql = "UPDATE LessonProgress SET IsCompleted = ? WHERE EnrollmentID = ? AND LessonID = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setBoolean(1, isCompleted);
        stm.setInt(2, enrollmentID);
        stm.setInt(3, lessonID);
        stm.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}

    public Map<Integer, Boolean> getLessonCompletionMap(int accountID, int courseID) {
        Map<Integer, Boolean> map = new HashMap<>();
        String sql = """
            SELECT lp.LessonID, lp.IsCompleted
            FROM LessonProgress lp
            JOIN Enrollments e ON lp.EnrollmentID = e.EnrollmentID
            WHERE e.AccountID = ? AND e.CourseID = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("LessonID"), rs.getBoolean("IsCompleted"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}
