/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
public class Material {
    private int materialID;
    private int lessonID;
    private String title;
    private String contentURL;
    private String materialType; // 'Video','PDF','Slide','Other'

    public Material() {}
    public Material(int materialID, int lessonID, String title, String contentURL, String materialType) {
        this.materialID = materialID;
        this.lessonID = lessonID;
        this.title = title;
        this.contentURL = contentURL;
        this.materialType = materialType;
    }

    public int getMaterialID() { return materialID; }
    public void setMaterialID(int materialID) { this.materialID = materialID; }
    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContentURL() { return contentURL; }
    public void setContentURL(String contentURL) { this.contentURL = contentURL; }
    public String getMaterialType() { return materialType; }
    public void setMaterialType(String materialType) { this.materialType = materialType; }
}

