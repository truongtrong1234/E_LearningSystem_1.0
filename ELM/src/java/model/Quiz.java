/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Quiz {
    private int quizID;
    private int lessonID;
    private String title;

    public Quiz() {}
    public Quiz(int quizID, int lessonID, String title) {
        this.quizID = quizID;
        this.lessonID = lessonID;
        this.title = title;
    }

    public int getQuizID() { return quizID; }
    public void setQuizID(int quizID) { this.quizID = quizID; }
    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}
