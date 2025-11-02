package model;

public class LessonProgress {
    private int lessonProgressID;
    private int enrollmentID;
    private int lessonID;
    private boolean isCompleted;

    public LessonProgress() {}

    public LessonProgress(int lessonProgressID, int enrollmentID, int lessonID, boolean isCompleted) {
        this.lessonProgressID = lessonProgressID;
        this.enrollmentID = enrollmentID;
        this.lessonID = lessonID;
        this.isCompleted = isCompleted;
    }

    public int getLessonProgressID() { return lessonProgressID; }
    public void setLessonProgressID(int lessonProgressID) { this.lessonProgressID = lessonProgressID; }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }

    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }

    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }
}
