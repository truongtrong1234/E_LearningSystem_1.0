package model;

public class Quiz {
    private int quizID;
    private int chapterID;
    private int courseID; // Thêm trường Course ID
    private String title;
    private String chapterName;
    private String courseName;

    public Quiz() {}

    // Constructor đầy đủ
    public Quiz(int quizID, int chapterID, int courseID, String title, String chapterName, String courseName) {
        this.quizID = quizID;
        this.chapterID = chapterID;
        this.courseID = courseID;
        this.title = title;
        this.chapterName = chapterName;
        this.courseName = courseName;
    }

    // Constructor cơ bản (dùng khi tạo mới) - Đã thêm courseID
    public Quiz(int chapterID, int courseID, String title) {
        this.chapterID = chapterID;
        this.courseID = courseID;
        this.title = title;
    }

    // Getters and Setters
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

    public int getCourseID() { // Getter mới
        return courseID;
    }

    public void setCourseID(int courseID) { // Setter mới
        this.courseID = courseID;
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
                ", courseID=" + courseID +
                ", title='" + title + '\'' +
                ", chapterName='" + chapterName + '\'' +
                ", courseName='" + courseName + '\'' +
                '}';
    }
}