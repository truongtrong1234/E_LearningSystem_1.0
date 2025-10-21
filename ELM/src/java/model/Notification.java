/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class Notification {
    private int notificationID;
    private int accountID;
    private String type; // 'System', 'Email', 'CourseUpdate', 'Payment', 'Reminder'
    private String title;
    private String message;
    private boolean isRead;
    private Date createdAt;

    public Notification() {}

    public Notification(int notificationID, int accountID, String type, String title, String message, boolean isRead, Date createdAt) {
        this.notificationID = notificationID;
        this.accountID = accountID;
        this.type = type;
        this.title = title;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    public int getNotificationID() { return notificationID; }
    public void setNotificationID(int notificationID) { this.notificationID = notificationID; }
    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public boolean isRead() { return isRead; }
    public void setRead(boolean isRead) { this.isRead = isRead; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
