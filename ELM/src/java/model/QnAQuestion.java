package model;

import java.util.Date;

public class QnAQuestion {
    private int qnaID;
    private int courseID;
    private int askedBy;
    private String askedByName;
    private String askedByAvatar;
    private String question;
    private Date askedAt;
    private QnAReply reply; // liên kết 1-1 với phần trả lời

    public QnAQuestion() {}

    public QnAQuestion(int qnaID, int courseID, int askedBy, String question, Date askedAt) {
        this.qnaID = qnaID;
        this.courseID = courseID;
        this.askedBy = askedBy;
        this.question = question;
        this.askedAt = askedAt;
    }

    // Getter / Setter
    public int getQnaID() { return qnaID; }
    public void setQnaID(int qnaID) { this.qnaID = qnaID; }

    public int getCourseID() { return courseID; }
    public void setCourseID(int courseID) { this.courseID = courseID; }

    public int getAskedBy() { return askedBy; }
    public void setAskedBy(int askedBy) { this.askedBy = askedBy; }

    public String getAskedByName() { return askedByName; }
    public void setAskedByName(String askedByName) { this.askedByName = askedByName; }

    public String getAskedByAvatar() { return askedByAvatar; }
    public void setAskedByAvatar(String askedByAvatar) { this.askedByAvatar = askedByAvatar; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public Date getAskedAt() { return askedAt; }
    public void setAskedAt(Date askedAt) { this.askedAt = askedAt; }

    public QnAReply getReply() { return reply; }
    public void setReply(QnAReply reply) { this.reply = reply; }
}
