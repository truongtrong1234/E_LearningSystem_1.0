package model;

public class Chapter {
    private int chapterID;
    private int courseID;
    private String title;

    public Chapter() {}
    public Chapter(int chapterID, int courseID, String title) {
        this.chapterID = chapterID;
        this.courseID = courseID;
        this.title = title;
    }

    public int getChapterID() { return chapterID; }
    public void setChapterID(int chapterID) { this.chapterID = chapterID; }
    public int getCourseID() { return courseID; }
    public void setCourseID(int courseID) { this.courseID = courseID; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}
