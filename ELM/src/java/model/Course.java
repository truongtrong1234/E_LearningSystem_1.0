package model;

import java.math.BigDecimal;

public class Course {
    private int courseID;
    private String title;
    private String description;
    private int instructorID;
    private BigDecimal price;
    private int courseclass;     // thay createAt bằng courseclass (int)
    private int categoryID;
    private String thumbnail;

    public Course() {}

    // FULL constructor có ID
    public Course(int courseID, String title, String description, int instructorID,
                  BigDecimal price, int courseclass, int categoryID, String thumbnail) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.courseclass = courseclass;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
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
        return "Course{" +
                "courseID=" + courseID +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", instructorID=" + instructorID +
                ", price=" + price +
                ", class=" + courseclass +
                ", categoryID=" + categoryID +
                ", thumbnail='" + thumbnail + '\'' +
                '}';
    }

    // Getters & setters
    public int getCourseID() { return courseID; }
    public void setCourseID(int courseID) { this.courseID = courseID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getInstructorID() { return instructorID; }
    public void setInstructorID(int instructorID) { this.instructorID = instructorID; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getCourseclass() { return courseclass; }
    public void setCourseclass(int courseclass) { this.courseclass = courseclass; }

    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }

    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
}
