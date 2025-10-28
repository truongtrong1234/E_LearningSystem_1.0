package model;

import java.util.Date;

public class Feedback {
    private int id;
    private Integer senderId;
    private String message;
    private Date createdAt;

    public Feedback() {}

    public Feedback(int id, Integer senderId, String message, Date createdAt) {
        this.id = id; this.senderId = senderId; this.message = message; this.createdAt = createdAt;
    }

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Integer getSenderId() { return senderId; }
    public void setSenderId(Integer senderId) { this.senderId = senderId; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
