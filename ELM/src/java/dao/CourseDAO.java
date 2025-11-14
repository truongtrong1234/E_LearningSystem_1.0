    package dao;

import java.sql.*;
import java.util.*;
import model.Course;
import context.DBContext;
import java.util.Date;

public class CourseDAO extends DBContext {
    public List<Course> searchCourses(String keyword, Integer cateID, Integer instructorID) {
    List<Course> list = new ArrayList<>();

    StringBuilder sql = new StringBuilder("""
        SELECT c.CourseID,
               c.Title,
               c.Description,
               c.InstructorID,
               c.Price,
               c.Class,
               c.CategoryID,
               c.Thumbnail,
               a.name AS InstructorName,
               cat.CategoryName
        FROM Courses c
        JOIN Accounts a ON c.InstructorID = a.AccountID
        JOIN Category cat ON c.CategoryID = cat.CategoryID
        WHERE 1 = 1
    """);

    // Thêm điều kiện động
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (c.Title LIKE ? OR a.name LIKE ?)");
    }
    if (cateID != null) {
        sql.append(" AND c.CategoryID = ?");
    }
    if (instructorID != null) {
        sql.append(" AND c.InstructorID = ?");
    }

    sql.append(" ORDER BY c.Title ASC");

    try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
        int index = 1;

        if (keyword != null && !keyword.trim().isEmpty()) {
            stm.setString(index++, "%" + keyword + "%");
            stm.setString(index++, "%" + keyword + "%");
        }
        if (cateID != null) {
            stm.setInt(index++, cateID);
        }
        if (instructorID != null) {
            stm.setInt(index++, instructorID);
        }

        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Course c = new Course();
            c.setCourseID(rs.getInt("CourseID"));
            c.setTitle(rs.getString("Title"));
            c.setDescription(rs.getString("Description"));
            c.setInstructorID(rs.getInt("InstructorID"));
            c.setInstructorName(rs.getString("InstructorName"));
            c.setPrice(rs.getBigDecimal("Price"));
            c.setCourseclass(rs.getInt("Class"));
            c.setCategoryID(rs.getInt("CategoryID"));
            c.setCategoryName(rs.getString("CategoryName"));
            c.setThumbnail(rs.getString("Thumbnail"));

            list.add(c);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}

      // Lấy tất cả khóa học
public List<Course> getAllCourses() {
    List<Course> list = new ArrayList<>();
    String sql = """
        SELECT 
            c.CourseID,
            c.Title,
            c.Description,
            c.InstructorID,
            a.name AS InstructorName,
            c.Price,
            c.Class,
            c.CategoryID,
            c.Thumbnail
        FROM Courses c
        LEFT JOIN Accounts a ON c.InstructorID = a.AccountID
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Course course = new Course(
                rs.getInt("CourseID"),
                rs.getString("Title"),
                rs.getString("Description"),
                rs.getInt("InstructorID"),
                rs.getBigDecimal("Price"),
                rs.getInt("Class"),
                rs.getInt("CategoryID"),
                rs.getString("Thumbnail")
            );

            // Thêm tên giảng viên
            course.setInstructorName(rs.getString("InstructorName"));

            list.add(course);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

public List<Course> getTop5MostEnrolledCourses() {
    List<Course> list = new ArrayList<>();
    String sql = """
        SELECT TOP 5 
            c.CourseID,
            c.Title,
            c.Description,
            c.InstructorID,
            a.name AS InstructorName,
            c.Price,
            c.Class,
            c.CategoryID,
            c.Thumbnail,
            COUNT(e.EnrollmentID) AS TotalEnroll
        FROM Courses c
        JOIN Enrollments e ON c.CourseID = e.CourseID
        JOIN Accounts a ON c.InstructorID = a.AccountID
        GROUP BY 
            c.CourseID, c.Title, c.Description, c.InstructorID, 
            c.Price, c.Class, c.CategoryID, c.Thumbnail, a.name
        ORDER BY COUNT(e.EnrollmentID) DESC
    """;

    try {
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Course c = new Course();
            c.setCourseID(rs.getInt("CourseID"));
            c.setTitle(rs.getString("Title"));
            c.setDescription(rs.getString("Description"));
            c.setCategoryID(rs.getInt("CategoryID"));
            c.setPrice(rs.getBigDecimal("Price"));
            c.setInstructorID(rs.getInt("InstructorID"));
            c.setInstructorName(rs.getString("InstructorName"));
            c.setTotalEnroll(rs.getInt("TotalEnroll"));
            list.add(c);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}
      
    // Lấy khoá học theo ID
    public Course getCourseById(int courseID) {
        String sql = """
        SELECT c.CourseID, c.Title, c.Description, c.InstructorID, 
               c.Price, c.[Class], c.CategoryID, c.Thumbnail,
               cat.CategoryName
        FROM Courses c
        JOIN Category cat ON c.CategoryID = cat.CategoryID
        WHERE c.CourseID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Course course = new Course();
                course.setCourseID(rs.getInt("CourseID"));
                course.setTitle(rs.getString("Title"));
                course.setDescription(rs.getString("Description"));
                course.setInstructorID(rs.getInt("InstructorID"));
                course.setPrice(rs.getBigDecimal("Price"));
                course.setCourseclass(rs.getInt("Class"));
                course.setCategoryID(rs.getInt("CategoryID"));
                course.setThumbnail(rs.getString("Thumbnail"));
                course.setCategoryName(rs.getString("CategoryName"));
                return course;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy khóa học theo instructorID
    public List<Course> getCourseByInstructorID(int instructorID) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE InstructorID=?"; 

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, instructorID);
            try (ResultSet rs = ps.executeQuery()) { 
                while (rs.next()) {
                    Course course = new Course(); 
                    course.setCourseID(rs.getInt("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setDescription(rs.getString("Description"));
                    course.setInstructorID(rs.getInt("InstructorID"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setCourseclass(rs.getInt("Class"));
                    course.setCategoryID(rs.getInt("CategoryID"));
                    course.setThumbnail(rs.getString("Thumbnail"));

                    list.add(course);
                }
            } // rs đóng tự động
        } catch (SQLException e) {
            // Đảm bảo log lỗi đầy đủ
            System.err.println("Lỗi truy vấn Khóa học theo InstructorID: " + e.getMessage());
            e.printStackTrace(); 
        }
        return list;
    }

    //Lấy khoá học theo Category
    public List<Course> getCoursesByCategory(int categoryID){
        List<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE categoryID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourseID(rs.getInt("courseID"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setCategoryID(rs.getInt("categoryID"));
                c.setInstructorID(rs.getInt("InstructorID"));
                c.setPrice(rs.getBigDecimal("Price"));
                c.setCourseclass(rs.getInt("Class"));
                c.setThumbnail(rs.getString("Thumbnail"));

                // add các field khác nếu cần
                list.add(c);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm khóa học mới
    public boolean insertCourse(Course course) {
        String sql = "INSERT INTO Courses (Title, Description, InstructorID, Price, Class, CategoryID, Thumbnail) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getInstructorID());
            ps.setBigDecimal(4, course.getPrice());
            ps.setInt(5, course.getCourseclass());  
            ps.setInt(6, course.getCategoryID());
            ps.setString(7, course.getThumbnail());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int insertCourseAndReturnID(Course course) {
        String sql = "INSERT INTO Courses (Title, Description, InstructorID, Price, Class, CategoryID, Thumbnail) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getInstructorID());
            ps.setBigDecimal(4, course.getPrice());
            ps.setInt(5, course.getCourseclass()); // ✅ field trong Course là courseclass
            ps.setInt(6, course.getCategoryID());
            ps.setString(7, course.getThumbnail());

            int affected = ps.executeUpdate();

            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // ✅ Trả về CourseID vừa tạo
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Cập nhật khóa học
    public boolean updateCourse(Course course) {
        String sql = "UPDATE Courses SET Title=?, Description=?, InstructorID=?, Price=?, Class=?, CategoryID=?";

        // Nếu thumbnail không null thì thêm vào câu lệnh
        if (course.getThumbnail() != null && !course.getThumbnail().isEmpty()) {
            sql += ", Thumbnail=?";
        }
        sql += " WHERE CourseID=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setString(index++, course.getTitle());
            ps.setString(index++, course.getDescription());
            ps.setInt(index++, course.getInstructorID());
            ps.setBigDecimal(index++, course.getPrice());
            ps.setInt(index++, course.getCourseclass());
            ps.setInt(index++, course.getCategoryID());

            // Nếu có thumbnail thì set tiếp
            if (course.getThumbnail() != null && !course.getThumbnail().isEmpty()) {
                ps.setString(index++, course.getThumbnail());
            }

            ps.setInt(index, course.getCourseID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa khóa học
    public boolean deleteCourse(int courseId) {
        String sql = "{call deleteCourse(?)}"; // gọi stored procedure
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, courseId); // truyền CourseID
            stmt.execute();
            return true; // xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // xóa thất bại
        }
    }

    // Tìm kiếm
    public List<Course> searchCourses(String keyword) {
        List<Course> list = new ArrayList<>();

        String sql = """
        SELECT * FROM Courses 
        WHERE Title COLLATE SQL_Latin1_General_Cp1253_CI_AI LIKE ? 
           OR Description COLLATE SQL_Latin1_General_Cp1253_CI_AI LIKE ?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course(
                        rs.getInt("CourseID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getInt("InstructorID"),
                        rs.getBigDecimal("Price"),
                        rs.getInt("Class"),
                        rs.getInt("CategoryID"),
                        rs.getString("Thumbnail")
                );
                list.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();
        List<Course> course = dao.getTop5MostEnrolledCourses(); 
        for (Course course1 : course) {
            System.out.println(course1);
        }
    }
}
