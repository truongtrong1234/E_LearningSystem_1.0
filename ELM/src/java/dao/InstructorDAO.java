package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Instructor;

public class InstructorDAO extends DBContext {

    public List<Instructor> getAllInstructors() {
        List<Instructor> list = new ArrayList<>();
        String sql = """
            SELECT AccountID, name, email, picture 
            FROM Accounts 
            WHERE role = 'instructor'
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Instructor ins = new Instructor();
                ins.setInstructorID(rs.getInt("AccountID"));
                ins.setInstructorName(rs.getString("name"));
                ins.setEmail(rs.getString("email"));
                ins.setPicture(rs.getString("picture"));
                list.add(ins);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public Instructor getInstructorByCourseID(int courseID) {
    String sql = """
        SELECT a.AccountID, a.name, a.email, a.picture
        FROM Accounts a
        JOIN Courses c ON a.AccountID = c.InstructorID
        WHERE c.CourseID = ?
    """;

    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, courseID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            Instructor ins = new Instructor();
            ins.setInstructorID(rs.getInt("AccountID"));
            ins.setInstructorName(rs.getString("name"));
            ins.setEmail(rs.getString("email"));
            ins.setPicture(rs.getString("picture"));
            return ins;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null; // nếu không tìm thấy
}

}
