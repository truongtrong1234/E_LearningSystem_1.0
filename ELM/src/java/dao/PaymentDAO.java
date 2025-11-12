package dao;

import context.DBContext;
import model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class PaymentDAO extends DBContext {

    // CREATE
    public int insertPayment(Payment p) {
        String sql = "INSERT INTO Payments (EnrollmentID, Amount, Status, TransactionID) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setInt(1, p.getEnrollmentID());
            stm.setBigDecimal(2, p.getAmount());
            stm.setString(3, p.getStatus());
            stm.setString(4, p.getTransactionID());
            int affected = stm.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); 
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;

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
        Payment payment = new Payment();
        payment.setEnrollmentID(28);
        payment.setAmount(BigDecimal.TEN);
        payment.setTransactionID("3232323");
        payment.setStatus("Success");
        int m = dao.insertPayment(payment); 
        System.out.println(m);
    }
}
