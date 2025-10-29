package model;

public class Quiz {
    private int quizID;
    private int chapterID;
    private String title;
    private String chapterName;
    private String courseName;

    public Quiz() {}

    // Constructor đầy đủ
    public Quiz(int quizID, int chapterID, String title, String chapterName, String courseName) {
        this.quizID = quizID;
        this.chapterID = chapterID;
        this.title = title;
        this.chapterName = chapterName;
        this.courseName = courseName;
    }

    // Constructor cơ bản (dùng khi tạo mới)
    public Quiz(int chapterID, String title) {
        this.chapterID = chapterID;
        this.title = title;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public int getChapterID() {
        return chapterID;
    }

    public void setChapterID(int chapterID) {
        this.chapterID = chapterID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getChapterName() {
        return chapterName;
    }

    public void setChapterName(String chapterName) {
        this.chapterName = chapterName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return "Quiz{" +
                "quizID=" + quizID +
                ", chapterID=" + chapterID +
                ", title='" + title + '\'' +
                ", chapterName='" + chapterName + '\'' +
                ", courseName='" + courseName + '\'' +
                '}';
    }
}
