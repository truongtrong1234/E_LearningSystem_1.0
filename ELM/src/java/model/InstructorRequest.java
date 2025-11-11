package model;


import java.util.Date;

public class InstructorRequest {
    private int requestID;
    private int accountID;
    private String fullName;
    private String email;
    private String phone;
    private String title;
    private String experience;
    private String skills;
    private String bio;
    private String cvFile;
    private String status;
private Date createdAt;


    public InstructorRequest() {}

    public InstructorRequest(int requestID, int accountID, String fullName, String email, String phone,
                             String title, String experience, String skills, String bio,
                             String cvFile, String status, Date createdAt) {
        this.requestID = requestID;
        this.accountID = accountID;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.title = title;
        this.experience = experience;
        this.skills = skills;
        this.bio = bio;
        this.cvFile = cvFile;
        this.status = status;
        this.createdAt = createdAt;
    }

    // ===== Getter & Setter =====
    public int getRequestID() { return requestID; }
    public void setRequestID(int requestID) { this.requestID = requestID; }

    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getCvFile() { return cvFile; }
    public void setCvFile(String cvFile) { this.cvFile = cvFile; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
