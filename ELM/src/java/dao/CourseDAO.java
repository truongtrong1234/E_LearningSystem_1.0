package dao;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import model.Course;
import context.DBContext;
import java.util.Date;

public class CourseDAO extends DBContext {

    // 🟢 Lấy tất cả khóa học
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM Courses";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course(
                        rs.getInt("CourseID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getInt("InstructorID"),
                        rs.getBigDecimal("Price"),
                        rs.getInt("Class"),   // ✅ Đổi ở đây
                        rs.getInt("CategoryID"),
                        rs.getString("Thumbnail")
                );
                list.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🟢 Lấy khóa học theo ID
    public Course getCourseById(int courseID) {
        String sql = "SELECT * FROM Courses WHERE CourseID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Course(
                        rs.getInt("CourseID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getInt("InstructorID"),
                        rs.getBigDecimal("Price"),
                        rs.getInt("Class"),   // ✅ Đổi ở đây
                        rs.getInt("CategoryID"),
                        rs.getString("Thumbnail")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🟢 Thêm khóa học mới
    public boolean insertCourse(Course course) {
        String sql = "INSERT INTO Courses (Title, Description, InstructorID, Price, Class, CategoryID, Thumbnail) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getInstructorID());
            ps.setBigDecimal(4, course.getPrice());
            ps.setInt(5, course.getCourseclass());  // ✅ Đổi ở đây
            ps.setInt(6, course.getCategoryID());
            ps.setString(7, course.getThumbnail());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Cập nhật khóa học
    public boolean updateCourse(Course course) {
        String sql = "UPDATE Courses SET Title=?, Description=?, InstructorID=?, Price=?, Class=?, CategoryID=?, Thumbnail=? " +
                     "WHERE CourseID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getInstructorID());
            ps.setBigDecimal(4, course.getPrice());
            ps.setInt(5, course.getCourseclass());  // ✅ Đổi ở đây
            ps.setInt(6, course.getCategoryID());
            ps.setString(7, course.getThumbnail());
            ps.setInt(8, course.getCourseID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🟢 Xóa khóa học
    public boolean deleteCourse(int id) {
        String sql = "DELETE FROM Courses WHERE CourseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public static void main(String[] args) {
//        CourseDAO dao = new CourseDAO();
//        List<Course> list = dao.getAllCourses();
//
//        if (list != null && !list.isEmpty()) {
//            for (Course c : list) {
//                System.out.println("ID: " + c.getCourseID() + 
//                                   " | Title: " + c.getTitle() + 
//                                   " | Price: " + c.getPrice());
//            }
//        } else {
//            System.out.println("⚠️ Không có khóa học nào!");
//        }
        CourseDAO dao = new CourseDAO(); 
        Course course = new Course();
         course.setTitle("Java Web Basics");
        course.setDescription("Learn how to build web apps using Java Servlets and JSP.");
        course.setInstructorID(1);      // Giả sử instructorID = 1
        course.setPrice(new BigDecimal("0"));
        course.setCourseclass(11);      // Lớp 11
        course.setCategoryID(2);        // Giả sử categoryID = 2
         // test link        
        boolean insertResult = dao.insertCourse(course);
        System.out.println("Insert result: " + insertResult);
        
    }
}

//       

        // 🟢 2. Lấy tất cả khóa học

//
//        // 🟢 3. Lấy 1 khóa học theo ID (ví dụ ID = 1)
//        Course c1 = dao.getCourseById(2);
////        if (c1 != null) {
////            System.out.println("Tìm thấy khóa học ID=1: " + c1.getTitle());
////        } else {
////            System.out.println("Không tìm thấy khóa học ID=1");
////        }
//
//        // 🟢 4. Cập nhật khóa học (ví dụ cập nhật title & price của ID = 1)
//        if (c1 != null) {
//            c1.setTitle("Java Web Advanced");
//            c1.setPrice(new BigDecimal("249.99"));
//            boolean updateResult = dao.updateCourse(c1);
//            System.out.println("Update result: " + updateResult);
//        }

        // 🟢 5. Xóa khóa học theo ID (ví dụ xóa ID = 3)
//        boolean deleteResult = dao.deleteCourse(4);
//        System.out.println("Delete result (ID=3): " + deleteResult);
