package dao;

import context.DBContext;
import model.CourseProgress;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class CourseProgressDAO extends DBContext {

    // CREATE
    public void insertCourseProgress(CourseProgress cp) {
        String sql = "INSERT INTO CourseProgress (EnrollmentID, CompletedPercent) VALUES (?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, cp.getEnrollmentID());
            stm.setBigDecimal(2, cp.getCompletedPercent() != null ? cp.getCompletedPercent() : BigDecimal.ZERO);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
   // Tạo tiến độ khóa học
    public void insertCourseProgress(int accountID, int courseID) {
        int enrollmentID = getEnrollmentID(accountID, courseID);
        if (enrollmentID == -1) return;

        String sql = "INSERT INTO CourseProgress (EnrollmentID, CompletedPercent) VALUES (?, 0)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, enrollmentID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    
    // Lấy EnrollmentID
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

    // READ - get all
    public List<CourseProgress> getAllCourseProgress() {
        List<CourseProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM CourseProgress";
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                list.add(new CourseProgress(
                        rs.getInt("ProgressID"),
                        rs.getInt("EnrollmentID"),
                        rs.getBigDecimal("CompletedPercent")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by EnrollmentID
    public CourseProgress getByEnrollmentID(int enrollmentID) {
        String sql = "SELECT * FROM CourseProgress WHERE EnrollmentID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, enrollmentID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new CourseProgress(
                        rs.getInt("ProgressID"),
                        rs.getInt("EnrollmentID"),
                        rs.getBigDecimal("CompletedPercent")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Giả sử CourseProgress có int progress
    public void updateCourseProgress(int enrollmentID, int progress) {
        String sql = "UPDATE CourseProgress SET CompletedPercent = ? WHERE EnrollmentID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, progress);  // dùng int luôn
            stm.setInt(2, enrollmentID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }


    // DELETE
    public void deleteByEnrollmentID(int enrollmentID) {
        String sql = "DELETE FROM CourseProgress WHERE EnrollmentID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, enrollmentID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
