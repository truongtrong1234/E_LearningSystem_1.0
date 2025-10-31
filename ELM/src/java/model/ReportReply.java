package model;

import java.time.LocalDateTime;

public class ReportReply {
    private int replyId;
    private int reportId;
    private int adminId;           // Tài khoản admin trả lời
    private String replyMessage;
    private LocalDateTime repliedAt;

    // ===== Constructors =====
    public ReportReply() {}

    public ReportReply(int replyId, int reportId, int adminId, String replyMessage, LocalDateTime repliedAt) {
        this.replyId = replyId;
        this.reportId = reportId;
        this.adminId = adminId;
        this.replyMessage = replyMessage;
        this.repliedAt = repliedAt;
    }

    // ===== Getters & Setters =====
    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getReplyMessage() {
        return replyMessage;
    }

    public void setReplyMessage(String replyMessage) {
        this.replyMessage = replyMessage;
    }

    public LocalDateTime getRepliedAt() {
        return repliedAt;
    }

    public void setRepliedAt(LocalDateTime repliedAt) {
        this.repliedAt = repliedAt;
    }
}
