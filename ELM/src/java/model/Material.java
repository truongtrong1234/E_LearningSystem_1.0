package model;

import java.util.Date;

public class Material {
    private int materialID;
    private String courseName;
    private String chapterName;
    private String lessonName;
    private int courseID;
    private int chapterID;
    private int lessonID;
    private String title;
    private String contentURL;
    private String materialType; // 'Video','PDF','Slide','Other'
    private Date createdAt;

    public Material() {}

    public Material(int materialID, int lessonID, String title, String contentURL, String materialType, Date createdAt) {
        this.materialID = materialID;
        this.lessonID = lessonID;
        this.title = title;
        this.contentURL = contentURL;
        this.materialType = materialType;
        this.createdAt = createdAt;
    }

    public int getMaterialID() { return materialID; }
    public void setMaterialID(int materialID) { this.materialID = materialID; }
    
    public String getCourseName() {return courseName;}
    public void setCourseName(String courseName) {this.courseName = courseName;}
    
    public String getChapterName() {return chapterName;}
    public void setChapterName(String chapterName) {this.chapterName = chapterName;}
    
    public String getLessonName() { return lessonName; }
    public void setLessonName(String lessonName) { this.lessonName = lessonName; }
    
    public int getCourseID() {return courseID;}
    public void setCourseID(int courseID) {this.courseID = courseID;}
    
    public int getChapterID() {return chapterID;}
    public void setChapterID(int chapterID) {this.chapterID = chapterID;}

    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContentURL() { return contentURL; }
    public void setContentURL(String contentURL) { this.contentURL = contentURL; }

    public String getMaterialType() { return materialType; }
    public void setMaterialType(String materialType) { this.materialType = materialType; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Material{" +
                "materialID=" + materialID +
                ", lessonID=" + courseID +
                ", lessonID=" + courseName +
                ", lessonID=" + chapterID +
                ", lessonID=" + chapterName +
                ", lessonID=" + lessonID +
                ", lessonID=" + lessonName +
                ", title='" + title + '\'' +
                ", contentURL='" + contentURL + '\'' +
                ", materialType='" + materialType + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
