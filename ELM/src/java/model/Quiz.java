package model;

public class Quiz {
    private int quizID;
    private int chapterID;
    private String title;

    public Quiz() {}

    public Quiz(int quizID, int chapterID, String title) {
        this.quizID = quizID;
        this.chapterID = chapterID;
        this.title = title;
    }

    public int getQuizID() { return quizID; }
    public void setQuizID(int quizID) { this.quizID = quizID; }

    public int getChapterID() { return chapterID; }
    public void setChapterID(int chapterID) { this.chapterID = chapterID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    @Override
    public String toString() {
        return "Quiz{" + 
               "quizID=" + quizID + 
               ", chapterID=" + chapterID + 
               ", title='" + title + '\'' + 
               '}';
    }
}
