package dao;

import context.DBContext;
import model.ReportReply;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportReplyDAO extends DBContext {

    // CREATE
    public boolean insertReply(ReportReply reply) {
        String sql = "INSERT INTO ReportReplies (ReportID, AdminID, ReplyMessage, RepliedAt) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reply.getReportId());
            ps.setInt(2, reply.getAdminId());
            ps.setString(3, reply.getReplyMessage());
            ps.setTimestamp(4, Timestamp.valueOf(reply.getRepliedAt()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // READ - Get all replies for a report
    public List<ReportReply> getRepliesByReportId(int reportId) {
        List<ReportReply> list = new ArrayList<>();
        String sql = "SELECT * FROM ReportReplies WHERE ReportID = ? ORDER BY RepliedAt ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportReply rr = new ReportReply();
                rr.setReplyId(rs.getInt("ReplyID"));
                rr.setReportId(rs.getInt("ReportID"));
                rr.setAdminId(rs.getInt("AdminID"));
                rr.setReplyMessage(rs.getString("ReplyMessage"));
                rr.setRepliedAt(rs.getTimestamp("RepliedAt").toLocalDateTime());
                list.add(rr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // READ - Get one reply by ID
    public ReportReply getReplyById(int id) {
        String sql = "SELECT * FROM ReportReplies WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ReportReply rr = new ReportReply();
                rr.setReplyId(rs.getInt("ReplyID"));
                rr.setReportId(rs.getInt("ReportID"));
                rr.setAdminId(rs.getInt("AdminID"));
                rr.setReplyMessage(rs.getString("ReplyMessage"));
                rr.setRepliedAt(rs.getTimestamp("RepliedAt").toLocalDateTime());
                return rr;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // UPDATE
    public boolean updateReply(ReportReply reply) {
        String sql = "UPDATE ReportReplies SET ReplyMessage = ?, RepliedAt = ? WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reply.getReplyMessage());
            ps.setTimestamp(2, Timestamp.valueOf(reply.getRepliedAt()));
            ps.setInt(3, reply.getReplyId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // DELETE
    public boolean deleteReply(int id) {
        String sql = "DELETE FROM ReportReplies WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
