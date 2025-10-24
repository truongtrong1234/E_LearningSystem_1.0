package dao;

import context.DBContext;
import model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class PaymentDAO extends DBContext {

    // CREATE
    public void insertPayment(Payment p) {
        String sql = "INSERT INTO Payments (EnrollmentID, Amount, Status, TransactionID) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, p.getEnrollmentID());
            stm.setBigDecimal(2, p.getAmount());
            stm.setString(3, p.getStatus());
            stm.setString(4, p.getTransactionID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // READ - Get all payments
    public List<Payment> getAllPayment() {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payments ORDER BY PaidAt DESC";
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

    // READ - Get payment by ID
    public Payment getPaymentByID(int id) {
        String sql = "SELECT * FROM Payments WHERE PaymentID = ?";
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

    // READ - Get all payments by EnrollmentID
    public List<Payment> getPaymentByEnrollmentID(int enrollmentID) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE EnrollmentID = ? ORDER BY PaidAt DESC";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, enrollmentID);
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
    public void updatePayment(Payment p) {
        String sql = "UPDATE Payments SET EnrollmentID = ?, Amount = ?, Status = ?, TransactionID = ? WHERE PaymentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, p.getEnrollmentID());
            stm.setBigDecimal(2, p.getAmount());
            stm.setString(3, p.getStatus());
            stm.setString(4, p.getTransactionID());
            stm.setInt(5, p.getPaymentID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // UPDATE - Change payment status only
    public void updatePaymentStatus(int id, String status) {
        String sql = "UPDATE Payments SET Status = ? WHERE PaymentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DELETE
    public void deletePayment(int id) {
        String sql = "DELETE FROM Payments WHERE PaymentID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Helper - Map SQL ResultSet → Payment Object
    private Payment mapResultSet(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("PaidAt");
        return new Payment(
                rs.getInt("PaymentID"),
                rs.getInt("EnrollmentID"),
                rs.getBigDecimal("Amount"),
                rs.getString("Status"),
                rs.getString("TransactionID"),
                ts != null ? new java.util.Date(ts.getTime()) : null
        );
    }

    // Test main
    public static void main(String[] args) {
        PaymentDAO dao = new PaymentDAO();
        List<Payment> list = dao.getAllPayment();
        for (Payment p : list) {
            System.out.println(
                "PaymentID: " + p.getPaymentID() +
                " | EnrollmentID: " + p.getEnrollmentID() +
                " | Amount: " + p.getAmount() +
                " | Status: " + p.getStatus() +
                " | TransactionID: " + p.getTransactionID() +
                " | PaidAt: " + p.getPaidAt()
            );
        }
    }
}
