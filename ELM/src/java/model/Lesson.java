/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


public class Lesson {
    private int lessonID;
    private int chapterID;
    private String title;

    public Lesson() {}
    public Lesson(int lessonID, int chapterID, String title) {
        this.lessonID = lessonID;
        this.chapterID = chapterID;
        this.title = title;
    }

    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }
    public int getChapterID() { return chapterID; }
    public void setChapterID(int chapterID) { this.chapterID = chapterID; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}

