package dao;

import model.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

public class AdminDAO {
    private Connection conn;

    public AdminDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?serverTimezone=UTC", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ---------- Account ----------
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Account(
                    rs.getInt("id"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("role"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Account getAccountById(int id) {
        String sql = "SELECT * FROM account WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("id"), rs.getString("email"), rs.getString("password"),
                        rs.getString("name"), rs.getString("role"), rs.getString("status"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void updateAccount(int id, String email, String pass, String name, String role) {
        String sql = "UPDATE account SET email=?, password=?, name=?, role=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass);
            ps.setString(3, name);
            ps.setString(4, role);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteAccount(int id) {
        String sql = "DELETE FROM account WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ---------- Course ----------
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM course ORDER BY created_at DESC";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Course c = new Course();
                //c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                //c.setCategory(rs.getString("category"));
                //c.setLevel(rs.getString("level"));
                //c.setLanguage(rs.getString("language"));
                //c.setPrice(rs.getDouble("price"));
                c.setDescription(rs.getString("description"));
                int instr = rs.getInt("instructor_id");
                //c.setInstructorId(rs.wasNull() ? null : instr);
                Timestamp t = rs.getTimestamp("created_at");
                //c.setCreatedAt(t != null ? new Date(t.getTime()) : null);
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Course getCourseById(int id) {
        String sql = "SELECT * FROM course WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Course c = new Course();
                //c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                //c.setCategory(rs.getString("category"));
                //c.setLevel(rs.getString("level"));
                //c.setLanguage(rs.getString("language"));
                //c.setPrice(rs.getDouble("price"));
                c.setDescription(rs.getString("description"));
                int instr = rs.getInt("instructor_id");
                //c.setInstructorId(rs.wasNull() ? null : instr);
                Timestamp t = rs.getTimestamp("created_at");
                //c.setCreatedAt(t != null ? new Date(t.getTime()) : null);
                return c;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void updateCourse(int id, String title, String category, String level, String language, double price, String description) {
        String sql = "UPDATE course SET title=?, category=?, level=?, language=?, price=?, description=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, category);
            ps.setString(3, level);
            ps.setString(4, language);
            ps.setDouble(5, price);
            ps.setString(6, description);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteCourse(int id) {
        String sql = "DELETE FROM course WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ---------- Feedback / Reports ----------
    public List<Feedback> getAllReports() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Feedback f = new Feedback();
                f.setId(rs.getInt("id"));
                int sid = rs.getInt("sender_id");
                f.setSenderId(rs.wasNull() ? null : sid);
                f.setMessage(rs.getString("message"));
                Timestamp t = rs.getTimestamp("created_at");
                f.setCreatedAt(t != null ? new Date(t.getTime()) : null);
                list.add(f);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void deleteReport(int id) {
        String sql = "DELETE FROM feedback WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
