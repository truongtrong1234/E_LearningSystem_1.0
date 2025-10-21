/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class Enrollment {
    private int enrollmentID;
    private int accountID;
    private int courseID;
    private Date enrolledAt;
    private String status; // 'Active',...

    public Enrollment() {}
    public Enrollment(int enrollmentID, int accountID, int courseID, Date enrolledAt, String status) {
        this.enrollmentID = enrollmentID;
        this.accountID = accountID;
        this.courseID = courseID;
        this.enrolledAt = enrolledAt;
        this.status = status;
    }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }
    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }
    public int getCourseID() { return courseID; }
    public void setCourseID(int courseID) { this.courseID = courseID; }
    public Date getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(Date enrolledAt) { this.enrolledAt = enrolledAt; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
