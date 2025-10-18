package model;

import java.math.BigDecimal;
import java.util.Date;

public class Course {
    private int courseID;
    private String title;
    private String description;
    private int instructorID;
    private BigDecimal price;
    private Date createdAt;
    private int categoryID; // thêm mới
    private byte[] thumbnail; // lưu ảnh trực tiếp dưới dạng binary

    public byte[] getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(byte[] thumbnail) {
        this.thumbnail = thumbnail;
    }
    public Course() {}

    public Course(int courseID, String title, String description, int instructorID, BigDecimal price, Date createdAt, int categoryID, byte[] thumbnail) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.createdAt = createdAt;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
    }

    public Course(String title, String description, int instructorID, BigDecimal price, Date createdAt, int categoryID, byte[] thumbnail) {
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.createdAt = createdAt;
        this.categoryID = categoryID;
        this.thumbnail = thumbnail;
    }
    
    public Course(int courseID, String title, String description, int instructorID,
                  BigDecimal price, Date createdAt, int categoryID) {
        this.courseID = courseID;
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.createdAt = createdAt;
        this.categoryID = categoryID;
    }

    public Course(String title, String description, int instructorID,
                  BigDecimal price, Date createdAt, int categoryID) {
        this.title = title;
        this.description = description;
        this.instructorID = instructorID;
        this.price = price;
        this.createdAt = createdAt;
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return "Course{" + "courseID=" + courseID + ", title=" + title + ", description=" + description + ", instructorID=" + instructorID + ", price=" + price + ", createdAt=" + createdAt + ", categoryID=" + categoryID + '}';
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

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
}
