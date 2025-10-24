package dao;

import context.DBContext;
import model.LessonProgress;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LessonProgressDAO extends DBContext {

    // CREATE
    public void insert(LessonProgress lp) {
        String sql = "INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted, CompletedAt) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lp.getEnrollmentID());
            stm.setInt(2, lp.getLessonID());
            stm.setBoolean(3, lp.isCompleted());
            if (lp.getCompletedAt() != null)
                stm.setTimestamp(4, new Timestamp(lp.getCompletedAt().getTime()));
            else
                stm.setNull(4, Types.TIMESTAMP);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all
    public List<LessonProgress> getAll() {
        List<LessonProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM LessonProgress";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by ID
    public LessonProgress getByID(int id) {
        String sql = "SELECT * FROM LessonProgress WHERE LessonProgressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // READ - get by EnrollmentID
    public List<LessonProgress> getByEnrollmentID(int enrollmentID) {
        List<LessonProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM LessonProgress WHERE EnrollmentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get by LessonID
    public List<LessonProgress> getByLessonID(int lessonID) {
        List<LessonProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM LessonProgress WHERE LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lessonID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // READ - get specific record (EnrollmentID + LessonID)
    public LessonProgress getByEnrollmentAndLesson(int enrollmentID, int lessonID) {
        String sql = "SELECT * FROM LessonProgress WHERE EnrollmentID = ? AND LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            stm.setInt(2, lessonID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // UPDATE
    public void update(LessonProgress lp) {
        String sql = "UPDATE LessonProgress SET EnrollmentID = ?, LessonID = ?, IsCompleted = ?, CompletedAt = ? WHERE LessonProgressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lp.getEnrollmentID());
            stm.setInt(2, lp.getLessonID());
            stm.setBoolean(3, lp.isCompleted());
            if (lp.getCompletedAt() != null)
                stm.setTimestamp(4, new Timestamp(lp.getCompletedAt().getTime()));
            else
                stm.setNull(4, Types.TIMESTAMP);
            stm.setInt(5, lp.getLessonProgressID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void delete(int id) {
        String sql = "DELETE FROM LessonProgress WHERE LessonProgressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Mark lesson completed
    public void markCompleted(int enrollmentID, int lessonID) {
        String sql = "UPDATE LessonProgress SET IsCompleted = 1, CompletedAt = GETDATE() WHERE EnrollmentID = ? AND LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            stm.setInt(2, lessonID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Check if completed
    public boolean isLessonCompleted(int enrollmentID, int lessonID) {
        String sql = "SELECT IsCompleted FROM LessonProgress WHERE EnrollmentID = ? AND LessonID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
            stm.setInt(2, lessonID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("IsCompleted");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Helper: map a row to LessonProgress object
    private LessonProgress mapResultSet(ResultSet rs) throws SQLException {
        LessonProgress lp = new LessonProgress();
        lp.setLessonProgressID(rs.getInt("LessonProgressID"));
        lp.setEnrollmentID(rs.getInt("EnrollmentID"));
        lp.setLessonID(rs.getInt("LessonID"));
        lp.setCompleted(rs.getBoolean("IsCompleted"));
        Timestamp ts = rs.getTimestamp("CompletedAt");
        if (ts != null) {
            lp.setCompletedAt(new java.util.Date(ts.getTime()));
        }
        return lp;
    }

    // Test nhanh
    public static void main(String[] args) {
    LessonProgressDAO dao = new LessonProgressDAO();
    List<LessonProgress> list = dao.getAll();
    for (LessonProgress lp : list) {
        System.out.println(
            lp.getLessonProgressID() + " | " +
            lp.getEnrollmentID() + " | " +
            lp.getLessonID() + " | " +
            lp.isCompleted() + " | " +
            lp.getCompletedAt()
        );
    }
}

}

