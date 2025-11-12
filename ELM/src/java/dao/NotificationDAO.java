package dao;

import context.DBContext;
import model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO extends DBContext {

    // CREATE
    public void insertNotification(Notification n) {
        String sql = "INSERT INTO Notifications (AccountID, Type, Title, Message, IsRead) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, n.getAccountID());
            stm.setString(2, n.getType());
            stm.setString(3, n.getTitle());
            stm.setString(4, n.getMessage());
            stm.setBoolean(5, n.isRead());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - get all notifications
    public List<Notification> getAllNotification() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications ORDER BY CreatedAt DESC";
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
    public Notification getNotificationByID(int id) {
        String sql = "SELECT * FROM Notifications WHERE NotificationID = ?";
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

    // READ - get all by AccountID
    public List<Notification> getNotificationByAccountID(int accountID) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications WHERE AccountID = ? ORDER BY CreatedAt DESC";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, accountID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // UPDATE - mark as read/unread
    public void updateNotificationIsRead(int id, boolean isRead) {
        String sql = "UPDATE Notifications SET IsRead = ? WHERE NotificationID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, isRead);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public void markAllAsRead(int accountId) {
    String sql = "UPDATE Notifications SET IsRead = 1 WHERE AccountID = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, accountId);
        stm.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}

    public int countUnread(int accountId) {
    String sql = "SELECT COUNT(*) FROM Notifications WHERE AccountID = ? AND IsRead = 0";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, accountId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}


    // UPDATE - full update
    public void updateNotification(Notification n) {
        String sql = "UPDATE Notifications SET AccountID = ?, Type = ?, Title = ?, Message = ?, IsRead = ? WHERE NotificationID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, n.getAccountID());
            stm.setString(2, n.getType());
            stm.setString(3, n.getTitle());
            stm.setString(4, n.getMessage());
            stm.setBoolean(5, n.isRead());
            stm.setInt(6, n.getNotificationID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void deleteNotification(int id) {
        String sql = "DELETE FROM Notifications WHERE NotificationID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Helper: map ResultSet -> Notification object
    private Notification mapResultSet(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("CreatedAt");
        return new Notification(
                rs.getInt("NotificationID"),
                rs.getInt("AccountID"),
                rs.getString("Type"),
                rs.getString("Title"),
                rs.getString("Message"),
                rs.getBoolean("IsRead"),
                ts != null ? new java.util.Date(ts.getTime()) : null
        );
    }

    // Test main
    public static void main(String[] args) {
        NotificationDAO dao = new NotificationDAO();
        List<Notification> list = dao.getAllNotification();
        for (Notification n : list) {
            System.out.println(
                "NotificationID: " + n.getNotificationID() +
                " | AccountID: " + n.getAccountID() +
                " | Type: " + n.getType() +
                " | Title: " + n.getTitle() +
                " | Message: " + n.getMessage() +
                " | IsRead: " + n.isRead() +
                " | CreatedAt: " + n.getCreatedAt()
            );
        }
    }
}
