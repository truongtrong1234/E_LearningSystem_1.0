package model;

import java.util.Date;

public class Material {
    private int materialID;
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
                ", lessonID=" + lessonID +
                ", title='" + title + '\'' +
                ", contentURL='" + contentURL + '\'' +
                ", materialType='" + materialType + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
