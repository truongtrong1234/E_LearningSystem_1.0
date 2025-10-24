package dao;

import context.DBContext;
import model.Material;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO extends DBContext {

    // CREATE
    public void insert(Material m) {
        String sql = "INSERT INTO Materials (LessonID, Title, ContentURL, MaterialType) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, m.getLessonID());
            stm.setString(2, m.getTitle());
            stm.setString(3, m.getContentURL());
            stm.setString(4, m.getMaterialType());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all materials
    public List<Material> getAll() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM Materials";
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
    public Material getByID(int id) {
        String sql = "SELECT * FROM Materials WHERE MaterialID = ?";
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

    // READ - get all by LessonID
    public List<Material> getByLessonID(int lessonID) {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM Materials WHERE LessonID = ?";
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

    // UPDATE
    public void update(Material m) {
        String sql = "UPDATE Materials SET LessonID = ?, Title = ?, ContentURL = ?, MaterialType = ? WHERE MaterialID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, m.getLessonID());
            stm.setString(2, m.getTitle());
            stm.setString(3, m.getContentURL());
            stm.setString(4, m.getMaterialType());
            stm.setInt(5, m.getMaterialID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void delete(int id) {
        String sql = "DELETE FROM Materials WHERE MaterialID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Helper - mapping ResultSet to Material
    private Material mapResultSet(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("CreatedAt");
        return new Material(
                rs.getInt("MaterialID"),
                rs.getInt("LessonID"),
                rs.getString("Title"),
                rs.getString("ContentURL"),
                rs.getString("MaterialType"),
                ts != null ? new java.util.Date(ts.getTime()) : null
        );
    }

    // Test main
    public static void main(String[] args) {
        MaterialDAO dao = new MaterialDAO();
        List<Material> list = dao.getAll();
        for (Material m : list) {
            System.out.println(
                "MaterialID: " + m.getMaterialID() +
                " | LessonID: " + m.getLessonID() +
                " | Title: " + m.getTitle() +
                " | ContentURL: " + m.getContentURL() +
                " | Type: " + m.getMaterialType() +
                " | CreatedAt: " + m.getCreatedAt()
            );
        }
    }
}
