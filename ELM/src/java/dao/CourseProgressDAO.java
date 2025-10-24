package dao;

import context.DBContext;
import model.CourseProgress;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class CourseProgressDAO extends DBContext {

    // CREATE
    public void insertCourseProgress(CourseProgress cp) {
        String sql = "INSERT INTO CourseProgress (EnrollmentID, CompletedPercent, LastAccess) VALUES (?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cp.getEnrollmentID());
            stm.setBigDecimal(2, cp.getCompletedPercent() != null ? cp.getCompletedPercent() : BigDecimal.ZERO);
            stm.setTimestamp(3, cp.getLastAccess() != null ? new Timestamp(cp.getLastAccess().getTime()) : new Timestamp(System.currentTimeMillis()));
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all
    public List<CourseProgress> getAllCourseProgress() {
        List<CourseProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM CourseProgress";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new CourseProgress(
                        rs.getInt("ProgressID"),
                        rs.getInt("EnrollmentID"),
                        rs.getBigDecimal("CompletedPercent"),
                        rs.getTimestamp("LastAccess")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by EnrollmentID (vì UNIQUE)
    public CourseProgress getByEnrollmentID(int enrollmentID) {
        String sql = "SELECT * FROM CourseProgress WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new CourseProgress(
                        rs.getInt("ProgressID"),
                        rs.getInt("EnrollmentID"),
                        rs.getBigDecimal("CompletedPercent"),
                        rs.getTimestamp("LastAccess")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // UPDATE
    public void updateCourseProgress(CourseProgress cp) {
        String sql = "UPDATE CourseProgress SET CompletedPercent = ?, LastAccess = ? WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBigDecimal(1, cp.getCompletedPercent());
            stm.setTimestamp(2, new Timestamp(cp.getLastAccess().getTime()));
            stm.setInt(3, cp.getEnrollmentID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE (theo EnrollmentID)
    public void deleteByEnrollmentID(int enrollmentID) {
        String sql = "DELETE FROM CourseProgress WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Kiểm tra nhanh
    public static void main(String[] args) {
        CourseProgressDAO dao = new CourseProgressDAO();

        System.out.println("Tất cả CourseProgress:");
        for (CourseProgress cp : dao.getAllCourseProgress()) {
            System.out.println(cp.getProgressID() + " | " + cp.getEnrollmentID() + " | " +
                               cp.getCompletedPercent() + "% | " + cp.getLastAccess());
        }
    }
}
