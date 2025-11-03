package model;

import java.math.BigDecimal;

public class CourseProgress {
    private int progressID;
    private int enrollmentID;
    private BigDecimal completedPercent;

    public CourseProgress() {}

    public CourseProgress(int progressID, int enrollmentID, BigDecimal completedPercent) {
        this.progressID = progressID;
        this.enrollmentID = enrollmentID;
        this.completedPercent = completedPercent;
    }

    public int getProgressID() { return progressID; }
    public void setProgressID(int progressID) { this.progressID = progressID; }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }

    public BigDecimal getCompletedPercent() { return completedPercent; }
    public void setCompletedPercent(BigDecimal completedPercent) { this.completedPercent = completedPercent; }
}
