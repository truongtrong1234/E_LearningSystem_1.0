package model;

import java.util.Date;

public class QnAReply {
    private int replyID;
    private int qnaID;
    private int repliedBy;
    private String repliedByName;
    private String repliedByAvatar;
    private String replyMessage;
    private Date repliedAt;

    public QnAReply() {}

    public QnAReply(int replyID, int qnaID, int repliedBy, String replyMessage, Date repliedAt) {
        this.replyID = replyID;
        this.qnaID = qnaID;
        this.repliedBy = repliedBy;
        this.replyMessage = replyMessage;
        this.repliedAt = repliedAt;
    }

    // Getter / Setter
    public int getReplyID() { return replyID; }
    public void setReplyID(int replyID) { this.replyID = replyID; }

    public int getQnaID() { return qnaID; }
    public void setQnaID(int qnaID) { this.qnaID = qnaID; }

    public int getRepliedBy() { return repliedBy; }
    public void setRepliedBy(int repliedBy) { this.repliedBy = repliedBy; }

    public String getRepliedByName() { return repliedByName; }
    public void setRepliedByName(String repliedByName) { this.repliedByName = repliedByName; }

    public String getRepliedByAvatar() { return repliedByAvatar; }
    public void setRepliedByAvatar(String repliedByAvatar) { this.repliedByAvatar = repliedByAvatar; }

    public String getReplyMessage() { return replyMessage; }
    public void setReplyMessage(String replyMessage) { this.replyMessage = replyMessage; }

    public Date getRepliedAt() { return repliedAt; }
    public void setRepliedAt(Date repliedAt) { this.repliedAt = repliedAt; }
}
