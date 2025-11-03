package dao;

import context.DBContext;
import model.MaterialProgress;
import java.sql.*;
import java.util.*;

public class MaterialProgressDAO extends DBContext {

    // 🟢 Helper: map ResultSet → MaterialProgress
    private MaterialProgress map(ResultSet rs) throws SQLException {
        return new MaterialProgress(
            rs.getInt("MaterialProgressID"),
            rs.getInt("EnrollmentID"),
            rs.getInt("MaterialID"),
            rs.getBoolean("IsCompleted")
        );
    }

    // 🟢 Lấy tất cả tiến độ material
    public List<MaterialProgress> getAll() {
        List<MaterialProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM MaterialProgress";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟢 Lấy tiến độ theo EnrollmentID
    public List<MaterialProgress> getByEnrollment(int enrollmentID) {
        List<MaterialProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM MaterialProgress WHERE EnrollmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟢 Lấy tiến độ cụ thể theo enrollment + material
    public MaterialProgress getOne(int enrollmentID, int materialID) {
        String sql = "SELECT * FROM MaterialProgress WHERE EnrollmentID = ? AND MaterialID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentID);
            ps.setInt(2, materialID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🟢 Thêm tiến độ mới
    public boolean insert(MaterialProgress mp) {
        String sql = "INSERT INTO MaterialProgress (EnrollmentID, MaterialID, IsCompleted) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, mp.getEnrollmentID());
            ps.setInt(2, mp.getMaterialID());
            ps.setBoolean(3, mp.isCompleted());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Cập nhật trạng thái hoàn thành
    public boolean update(MaterialProgress mp) {
        String sql = "UPDATE MaterialProgress SET IsCompleted = ? WHERE EnrollmentID = ? AND MaterialID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, mp.isCompleted());
            ps.setInt(2, mp.getEnrollmentID());
            ps.setInt(3, mp.getMaterialID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Xóa tiến độ theo Enrollment
    public boolean deleteByEnrollment(int enrollmentID) {
        String sql = "DELETE FROM MaterialProgress WHERE EnrollmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🧪 Test nhanh
    public static void main(String[] args) {
        MaterialProgressDAO dao = new MaterialProgressDAO();
        List<MaterialProgress> list = dao.getAll();

        if (list.isEmpty()) {
            System.out.println("⚠️ Không có dữ liệu MaterialProgress!");
        } else {
            for (MaterialProgress mp : list) {
                System.out.println("MaterialProgressID: " + mp.getMaterialProgressID() +
                                   " | EnrollmentID: " + mp.getEnrollmentID() +
                                   " | MaterialID: " + mp.getMaterialID() +
                                   " | Completed: " + mp.isCompleted());
            }
        }
    }
}
