/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;
import java.math.BigDecimal;

public class Payment {
    private int paymentID;
    private int enrollmentID;
    private BigDecimal amount;
    private String status; // 'Pending','Success','Failed','Refunded'
    private String transactionID;
    private Date paidAt;

    public Payment() {}
    public Payment(int paymentID, int enrollmentID, BigDecimal amount, String status, String transactionID, Date paidAt) {
        this.paymentID = paymentID;
        this.enrollmentID = enrollmentID;
        this.amount = amount;
        this.status = status;
        this.transactionID = transactionID;
        this.paidAt = paidAt;
    }

    public int getPaymentID() { return paymentID; }
    public void setPaymentID(int paymentID) { this.paymentID = paymentID; }
    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getTransactionID() { return transactionID; }
    public void setTransactionID(String transactionID) { this.transactionID = transactionID; }
    public Date getPaidAt() { return paidAt; }
    public void setPaidAt(Date paidAt) { this.paidAt = paidAt; }
}

