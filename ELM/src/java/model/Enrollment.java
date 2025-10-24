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

    public Enrollment() {}
    public Enrollment(int enrollmentID, int accountID, int courseID) {
        this.enrollmentID = enrollmentID;
        this.accountID = accountID;
        this.courseID = courseID;
    }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }
    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }
    public int getCourseID() { return courseID; }
    public void setCourseID(int courseID) { this.courseID = courseID; }
}
