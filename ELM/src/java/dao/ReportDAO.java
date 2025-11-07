package dao;

import context.DBContext;
import model.Report;
import java.sql.*;
import java.util.*;

public class ReportDAO extends DBContext {
        // Thêm mới một report (khi người dùng gửi)
    public boolean insertReport(Report report) {
        String sql = """
            INSERT INTO Reports (AccountID, Title, Message, Status, CreatedAt)
            VALUES (?, ?, ?, ?, GETDATE())
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, report.getAccountId());
            ps.setString(2, report.getTitle());
            ps.setString(3, report.getMessage());
            ps.setString(4, "Pending"); // Trạng thái mặc định là chờ xử lý
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy toàn bộ báo cáo (JOIN với bảng Accounts)
    public List<Report> getAllReports() {
        List<Report> list = new ArrayList<>();
        String sql = """
            SELECT r.ReportID, r.AccountID, r.Title, r.Message, r.Status, r.CreatedAt,
                   a.name AS SenderName, a.email AS SenderEmail
            FROM Reports r
            JOIN Accounts a ON r.AccountID = a.AccountID
            ORDER BY r.CreatedAt DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Report r = new Report();
                r.setReportId(rs.getInt("ReportID"));
                r.setAccountId(rs.getInt("AccountID"));
                r.setTitle(rs.getString("Title"));
                r.setMessage(rs.getString("Message"));
                r.setStatus(rs.getString("Status"));
                Timestamp ts = rs.getTimestamp("CreatedAt");
                if (ts != null) r.setCreatedAt(ts.toLocalDateTime());
                r.setSenderName(rs.getString("SenderName"));
                r.setSenderEmail(rs.getString("SenderEmail"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy 1 report theo ID
    public Report getReportById(int id) {
        String sql = """
            SELECT r.ReportID, r.AccountID, r.Title, r.Message, r.Status, r.CreatedAt,
                   a.name AS SenderName, a.email AS SenderEmail
            FROM Reports r
            JOIN Accounts a ON r.AccountID = a.AccountID
            WHERE r.ReportID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Report r = new Report();
                r.setReportId(rs.getInt("ReportID"));
                r.setAccountId(rs.getInt("AccountID"));
                r.setTitle(rs.getString("Title"));
                r.setMessage(rs.getString("Message"));
                r.setStatus(rs.getString("Status"));
                Timestamp ts = rs.getTimestamp("CreatedAt");
                if (ts != null) r.setCreatedAt(ts.toLocalDateTime());
                r.setSenderName(rs.getString("SenderName"));
                r.setSenderEmail(rs.getString("SenderEmail"));
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Xóa report
    public void deleteReport(int id) {
        try (PreparedStatement ps = connection.prepareStatement("DELETE FROM Reports WHERE ReportID = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
