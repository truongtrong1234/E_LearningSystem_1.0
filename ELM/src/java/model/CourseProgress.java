/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.math.BigDecimal;

public class CourseProgress {
    private int progressID;
    private int enrollmentID;
    private BigDecimal completedPercent;
    private Date lastAccess;

    public CourseProgress() {}

    public CourseProgress(int progressID, int enrollmentID, BigDecimal completedPercent, Date lastAccess) {
        this.progressID = progressID;
        this.enrollmentID = enrollmentID;
        this.completedPercent = completedPercent;
        this.lastAccess = lastAccess;
    }

    public int getProgressID() { return progressID; }
    public void setProgressID(int progressID) { this.progressID = progressID; }
    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }
    public BigDecimal getCompletedPercent() { return completedPercent; }
    public void setCompletedPercent(BigDecimal completedPercent) { this.completedPercent = completedPercent; }
    public Date getLastAccess() { return lastAccess; }
    public void setLastAccess(Date lastAccess) { this.lastAccess = lastAccess; }
}

