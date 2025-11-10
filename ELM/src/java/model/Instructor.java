package model;

public class Instructor {
    private int instructorID;      // Tương ứng với Accounts.AccountID
    private String instructorName; // Tương ứng với Accounts.name
    private String email;          // Tương ứng với Accounts.email
    private String picture;        // Tương ứng với Accounts.picture
    private String role;           // Luôn = 'instructor'

    public Instructor() {
    }

    public Instructor(int instructorID, String instructorName, String email, String picture, String role) {
        this.instructorID = instructorID;
        this.instructorName = instructorName;
        this.email = email;
        this.picture = picture;
        this.role = role;
    }

    public int getInstructorID() {
        return instructorID;
    }

    public void setInstructorID(int instructorID) {
        this.instructorID = instructorID;
    }

    public String getInstructorName() {
        return instructorName;
    }

    public void setInstructorName(String instructorName) {
        this.instructorName = instructorName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Instructor{" +
                "instructorID=" + instructorID +
                ", instructorName='" + instructorName + '\'' +
                ", email='" + email + '\'' +
                ", picture='" + picture + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
