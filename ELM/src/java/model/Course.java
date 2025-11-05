package model;

import java.math.BigDecimal;
import java.util.List;

public class Course {

    private int courseID;
    private String title;
    private String description;
    private int instructorID;
    private BigDecimal price;
    private int courseclass;     // thay createAt bằng courseclass (int)
    private int categoryID;
    private String thumbnail;
    private String categoryName;
    private String instructorName;

    private List<Chapter> chapters;

    public Course(String title, String description, int instructorID, BigDecimal price, int courseclass, int categoryID, String thumbnail, String categoryName, String instructorName, List<Chapter> chapters) {
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
        this.categoryName = categoryName;
        this.instructorName = instructorName;
        this.chapters = chapters;
    }

    public List<Chapter> getChapters() {
        return chapters;
    }

    public void setChapters(List<Chapter> chapters) {
        this.chapters = chapters;
    }

    public Course(int courseID, String title, String description, int instructorID, BigDecimal price, int courseclass, int categoryID, String thumbnail, String categoryName, String instructorName) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
        this.categoryName = categoryName;
        this.instructorName = instructorName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getInstructorName() {
        return instructorName;
    }

    public void setInstructorName(String instructorName) {
        this.instructorName = instructorName;
    }

    public Course() {
    }

    public Course(int courseID, String title, String description, int instructorID, BigDecimal price, int courseclass, int categoryID, String thumbnail) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
    }

    public Course(String title, String description, int instructorID, BigDecimal price, int courseclass, int categoryID, String thumbnail, String categoryName, String instructorName) {
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
        this.categoryName = categoryName;
        this.instructorName = instructorName;
    }

    // Constructor không ID
    public Course(String title, String description, int instructorID,
            BigDecimal price, int courseclass, int categoryID, String thumbnail) {
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
    }

    @Override
    public String toString() {
        return "Course{" + "courseID=" + courseID + ", title=" + title + ", description=" + description + ", instructorID=" + instructorID + ", price=" + price + ", courseclass=" + courseclass + ", categoryID=" + categoryID + ", thumbnail=" + thumbnail + ", categoryName=" + categoryName + ", instructorName=" + instructorName + ", chapters=" + chapters + '}';
    }


    // Getters & setters
    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getInstructorID() {
        return instructorID;
    }

    public void setInstructorID(int instructorID) {
        this.instructorID = instructorID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getCourseclass() {
        return courseclass;
    }

    public void setCourseclass(int courseclass) {
        this.courseclass = courseclass;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
}
