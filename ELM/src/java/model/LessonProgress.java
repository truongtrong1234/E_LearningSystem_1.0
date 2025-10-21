/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;

public class LessonProgress {
    private int lessonProgressID;
    private int enrollmentID;
    private int lessonID;
    private boolean isCompleted;
    private Date completedAt;

    public LessonProgress() {}

    public LessonProgress(int lessonProgressID, int enrollmentID, int lessonID, boolean isCompleted, Date completedAt) {
        this.lessonProgressID = lessonProgressID;
        this.enrollmentID = enrollmentID;
        this.lessonID = lessonID;
        this.isCompleted = isCompleted;
        this.completedAt = completedAt;
    }

    public int getLessonProgressID() { return lessonProgressID; }
    public void setLessonProgressID(int lessonProgressID) { this.lessonProgressID = lessonProgressID; }
    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }
    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }
    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean isCompleted) { this.isCompleted = isCompleted; }
    public Date getCompletedAt() { return completedAt; }
    public void setCompletedAt(Date completedAt) { this.completedAt = completedAt; }
}
