package model;

public class ChapterProgress {
    private int chapterProgressID;
    private int enrollmentID;
    private int chapterID;
    private boolean isCompleted;

    public ChapterProgress() {}

    public ChapterProgress(int chapterProgressID, int enrollmentID, int chapterID, boolean isCompleted) {
        this.chapterProgressID = chapterProgressID;
        this.enrollmentID = enrollmentID;
        this.chapterID = chapterID;
        this.isCompleted = isCompleted;
    }

    public int getChapterProgressID() { return chapterProgressID; }
    public void setChapterProgressID(int chapterProgressID) { this.chapterProgressID = chapterProgressID; }

    public int getEnrollmentID() { return enrollmentID; }
    public void setEnrollmentID(int enrollmentID) { this.enrollmentID = enrollmentID; }

    public int getChapterID() { return chapterID; }
    public void setChapterID(int chapterID) { this.chapterID = chapterID; }

    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }
}
