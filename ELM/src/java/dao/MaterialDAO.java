package dao;

import context.DBContext;
import model.Material;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO extends DBContext {

    // CREATE
    public int insert(Material m) {
        String sql = "INSERT INTO Materials (LessonID, Title, ContentURL, MaterialType) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setInt(1, m.getLessonID());
            stm.setString(2, m.getTitle());
            stm.setString(3, m.getContentURL());
            stm.setString(4, m.getMaterialType());
            int affected = stm.executeUpdate();

        if (affected > 0) {
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // ✅ Trả về CourseID vừa tạo
                }
            }
        }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
         return -1;
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
    public List<String> getContentURLsByLessonID(int lessonID) {
    List<String> urls = new ArrayList<>();
    String sql = "SELECT ContentURL FROM Materials WHERE LessonID = ?";

    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, lessonID);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            String url = rs.getString("ContentURL");
            if (url != null && !url.trim().isEmpty()) {
                urls.add(url);
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }

    return urls;
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
//    public void delete(int id) throws SQLException{
//        String sql = "DELETE FROM Materials WHERE MaterialID = ?";
//        try {
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setInt(1, id);
//            stm.executeUpdate();
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//    }
    public void delete(int id) { // Giữ nguyên chữ ký hàm
        String sql = "DELETE FROM Materials WHERE MaterialID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            int rowsAffected = stm.executeUpdate();
            if (rowsAffected == 0) {
                throw new RuntimeException("Xóa không thành công. Material ID " + id + " không tồn tại.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new RuntimeException("Lỗi SQL khi xóa material.", ex);
        }
    }
    
    // Lấy tất cả material theo InstructorID
    public List<Material> getByInstructor(int instructorID) {
        List<Material> list = new ArrayList<>();
        String sql = """
            SELECT m.MaterialID, m.Title, m.ContentURL, m.MaterialType, m.CreatedAt, 
                   l.Title AS LessonName, 
                   c.ChapterID, c.Title AS ChapterName,      
                   co.CourseID, co.Title AS CourseName
            FROM Materials m
            INNER JOIN Lessons l ON m.LessonID = l.LessonID
            INNER JOIN Chapters c ON l.ChapterID = c.ChapterID
            INNER JOIN Courses co ON c.CourseID = co.CourseID
            WHERE co.InstructorID = ?
            ORDER BY m.CreatedAt DESC
        """;

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Material m = new Material();
                    m.setMaterialID(rs.getInt("MaterialID"));
                    m.setTitle(rs.getString("Title"));
                    m.setContentURL(rs.getString("ContentURL"));
                    m.setMaterialType(rs.getString("MaterialType"));
                    m.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    m.setLessonName(rs.getString("LessonName"));
                    m.setChapterName(rs.getString("ChapterName"));
                    m.setCourseName(rs.getString("CourseName"));
                    m.setChapterID(rs.getInt("ChapterID"));
                    m.setCourseID(rs.getInt("CourseID"));
                    list.add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy material theo courseID + instructorID
    public List<Material> getByCourseAndInstructor(int courseID, int instructorID) {
        List<Material> list = new ArrayList<>();
        String sql = """
            SELECT m.MaterialID, m.Title, m.ContentURL, m.MaterialType, m.CreatedAt, 
                   l.Title AS LessonName,
                   c.ChapterID, c.Title AS ChapterName,      
                   co.CourseID, co.Title AS CourseName        
            FROM Materials m
            INNER JOIN Lessons l ON m.LessonID = l.LessonID
            INNER JOIN Chapters c ON l.ChapterID = c.ChapterID
            INNER JOIN Courses co ON c.CourseID = co.CourseID
            WHERE co.InstructorID = ? AND co.CourseID = ?   -- THÊM ĐIỀU KIỆN LỌC
            ORDER BY m.CreatedAt DESC
        """;

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorID); 
            ps.setInt(2, courseID);     

            try (ResultSet rs = ps.executeQuery()) {
                 while (rs.next()) {
                    Material m = new Material();
                    m.setMaterialID(rs.getInt("MaterialID"));
                    m.setTitle(rs.getString("Title"));            
                    m.setContentURL(rs.getString("ContentURL")); 
                    m.setMaterialType(rs.getString("MaterialType"));
                    m.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    m.setLessonName(rs.getString("LessonName"));
                    m.setChapterName(rs.getString("ChapterName")); 
                    m.setCourseName(rs.getString("CourseName"));   
                    m.setChapterID(rs.getInt("ChapterID"));
                    m.setCourseID(rs.getInt("CourseID"));
                    list.add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
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
        Material mate = new Material(); 
        mate.setLessonID(24);
        mate.setMaterialType("PDF");
        mate.setContentURL("https://example.com/video1.mp4");
        mate.setTitle("Video bài giảng đạo hàm");
        int newID = dao.insert(mate); 
        System.out.println(newID);
    }
}
