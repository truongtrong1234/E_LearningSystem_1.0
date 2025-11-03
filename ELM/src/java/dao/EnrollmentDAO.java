package dao;

import context.DBContext;
import model.Enrollment;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Course;

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
// ✅ Trả về EnrollmentID mới được tạo
public int insertEnrollment(int accountID, int courseID) {
    String sql = "INSERT INTO Enrollments (AccountID, CourseID) VALUES (?, ?)";
    try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        stm.setInt(1, accountID);
        stm.setInt(2, courseID);
        stm.executeUpdate();

        try (ResultSet rs = stm.getGeneratedKeys()) {
            if (rs.next()) {
                return rs.getInt(1); // EnrollmentID
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return -1;
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

    public int getEnrollmentID(int accountID, int courseID){
    String sql = "SELECT EnrollmentID FROM Enrollments WHERE AccountID = ? AND CourseID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, accountID);
        ps.setInt(2, courseID);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) return rs.getInt("EnrollmentID");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1; // nếu không có
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
  public List<Course> getCoursesByAccountId(int accountId) {
        List<Course> list = new ArrayList<>();

        String sql = """
            SELECT 
                c.CourseID, 
                c.Title, 
                c.Description, 
                c.InstructorID,
                c.Price,
                c.Class,
                c.CategoryID,
                c.Thumbnail,
                a.name AS InstructorName,
                cat.CategoryName AS CategoryName
            FROM Courses c
            JOIN Enrollments e ON e.CourseID = c.CourseID
            JOIN Accounts a ON a.AccountID = c.InstructorID
            JOIN Category cat ON cat.CategoryID = c.CategoryID
            WHERE e.AccountID = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setCourseID(rs.getInt("CourseID"));
                c.setTitle(rs.getString("Title"));
                c.setDescription(rs.getString("Description"));
                c.setInstructorID(rs.getInt("InstructorID"));
                c.setPrice(rs.getBigDecimal("Price"));
                c.setCourseclass(Integer.parseInt(rs.getString("Class")));
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setThumbnail(rs.getString("Thumbnail"));
                c.setInstructorName(rs.getString("InstructorName"));
                c.setCategoryName(rs.getString("CategoryName"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
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
        int accountID = 5; // 👈 đổi ID theo tài khoản thực tế trong DB của bạn
       List<Course> courseList =  dao.getCoursesByAccountId(accountID); 
        for (Course course : courseList) {
            System.out.println(course);
        }
    
    }
}
