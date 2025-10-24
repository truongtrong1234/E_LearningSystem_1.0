package dao;

import context.DBContext;
import model.Enrollment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO extends DBContext {

    // CREATE
    public void insertEnrollment(Enrollment e) {
        String sql = "INSERT INTO Enrollments (AccountID, CourseID) VALUES (?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, e.getAccountID());
            stm.setInt(2, e.getCourseID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all
    public List<Enrollment> getAllEnrollment() {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT * FROM Enrollments";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Enrollment(
                        rs.getInt("EnrollmentID"),
                        rs.getInt("AccountID"),
                        rs.getInt("CourseID")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by ID
    public Enrollment getEnrollmentByID(int id) {
        String sql = "SELECT * FROM Enrollments WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Enrollment(
                        rs.getInt("EnrollmentID"),
                        rs.getInt("AccountID"),
                        rs.getInt("CourseID")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // READ - get by AccountID
    public List<Enrollment> getEnrollmentByAccountID(int accountID) {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT * FROM Enrollments WHERE AccountID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, accountID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Enrollment(
                        rs.getInt("EnrollmentID"),
                        rs.getInt("AccountID"),
                        rs.getInt("CourseID")
                ));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // UPDATE
    public void updateEnrollment(Enrollment e) {
        String sql = "UPDATE Enrollments SET AccountID = ?, CourseID = ? WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, e.getAccountID());
            stm.setInt(2, e.getCourseID());
            stm.setInt(3, e.getEnrollmentID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void deleteEnrollment(int id) {
        String sql = "DELETE FROM Enrollments WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // (Tùy chọn) - kiểm tra trùng (tránh lỗi UNIQUE)
    public boolean existsEnrollment(int accountID, int courseID) {
        String sql = "SELECT 1 FROM Enrollments WHERE AccountID = ? AND CourseID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, accountID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Test nhanh
    public static void main(String[] args) {
        EnrollmentDAO dao = new EnrollmentDAO();

        System.out.println("Danh sách enrollments:");
        for (Enrollment e : dao.getAllEnrollment()) {
            System.out.println(e.getEnrollmentID() + " | " + e.getAccountID() + " | " + e.getCourseID());
        }
    }
}
