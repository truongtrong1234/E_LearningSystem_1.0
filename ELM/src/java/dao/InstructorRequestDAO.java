package dao;
import java.util.Date;
import context.DBContext;
import model.InstructorRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InstructorRequestDAO extends DBContext {

    public boolean insertRequest(InstructorRequest r) {
        String sql = "INSERT INTO InstructorRequest (accountID, fullName, email, phone, title, experience, skills, bio, cvFile) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, r.getAccountID());
            ps.setString(2, r.getFullName());
            ps.setString(3, r.getEmail());
            ps.setString(4, r.getPhone());
            ps.setString(5, r.getTitle());
            ps.setString(6, r.getExperience());
            ps.setString(7, r.getSkills());
            ps.setString(8, r.getBio());
            ps.setString(9, r.getCvFile());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public InstructorRequest getRequestByID(int requestID) {
    String sql = "SELECT * FROM InstructorRequest WHERE requestID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, requestID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            InstructorRequest r = new InstructorRequest();
            r.setRequestID(rs.getInt("requestID"));
            r.setAccountID(rs.getInt("accountID"));
            r.setFullName(rs.getString("fullName"));
            r.setEmail(rs.getString("email"));
            r.setPhone(rs.getString("phone"));
            r.setTitle(rs.getString("title"));
            r.setExperience(rs.getString("experience"));
            r.setSkills(rs.getString("skills"));
            r.setBio(rs.getString("bio"));
            r.setCvFile(rs.getString("cvFile"));
            r.setStatus(rs.getString("status"));

            Timestamp ts = rs.getTimestamp("createdAt");
            if (ts != null) {
                r.setCreatedAt(new Date(ts.getTime())); // Chuyển Timestamp -> Date
            }

            return r;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

public InstructorRequest getRequestByAccountID(int accountID) {
    String sql = "SELECT * FROM InstructorRequest WHERE accountID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, accountID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            InstructorRequest r = new InstructorRequest();
            r.setRequestID(rs.getInt("requestID"));
            r.setAccountID(rs.getInt("accountID"));
            r.setFullName(rs.getString("fullName"));
            r.setEmail(rs.getString("email"));
            r.setPhone(rs.getString("phone"));
            r.setTitle(rs.getString("title"));
            r.setExperience(rs.getString("experience"));
            r.setSkills(rs.getString("skills"));
            r.setBio(rs.getString("bio"));
            r.setCvFile(rs.getString("cvFile"));
            r.setStatus(rs.getString("status"));
            
            Timestamp ts = rs.getTimestamp("createdAt");
            if (ts != null) {
                r.setCreatedAt(new Date(ts.getTime())); // chuyển Timestamp -> Date
            }

            return r;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null; // chưa gửi
}


public List<InstructorRequest> getAllRequests() {
    List<InstructorRequest> list = new ArrayList<>();
    String sql = "SELECT * FROM InstructorRequest ORDER BY createdAt ASC";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            InstructorRequest r = new InstructorRequest();
            r.setRequestID(rs.getInt("requestID"));
            r.setAccountID(rs.getInt("accountID"));
            r.setFullName(rs.getString("fullName"));
            r.setEmail(rs.getString("email"));
            r.setPhone(rs.getString("phone"));
            r.setTitle(rs.getString("title"));
            r.setExperience(rs.getString("experience"));
            r.setSkills(rs.getString("skills"));
            r.setBio(rs.getString("bio"));
            r.setCvFile(rs.getString("cvFile"));
            r.setStatus(rs.getString("status"));

            Timestamp ts = rs.getTimestamp("createdAt");
            if (ts != null) {
                r.setCreatedAt(new Date(ts.getTime())); // chuyển Timestamp -> Date
            }

            list.add(r);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public void updateRequestStatus(int requestID, String status) {
    String sql = "UPDATE InstructorRequest SET status = ? WHERE requestID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, requestID);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public void updateAccountRole(int accountID, String role) {
    String sql = "UPDATE Accounts SET role = ? WHERE accountID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, role);
        ps.setInt(2, accountID);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}
