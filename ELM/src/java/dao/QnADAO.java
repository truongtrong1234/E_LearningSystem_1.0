package dao;

import context.DBContext;
import model.QnAQuestion;
import model.QnAReply;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QnADAO extends DBContext {

    /**
     * Lấy danh sách câu hỏi của 1 course kèm reply gần nhất (nếu có) và thông tin user.
     * Sử dụng ROW_NUMBER() để lấy reply mới nhất cho mỗi QnAID (SQL Server).
     */
    public List<QnAQuestion> getQuestionsByCourse(int courseID) {
    List<QnAQuestion> list = new ArrayList<>();

    String sql = """
        SELECT q.QnAID, q.CourseID, q.AskedBy, q.Question, q.AskedAt,
               a.name AS AskedByName, a.picture AS AskedByAvatar,
               r.ReplyID, r.RepliedBy, r.ReplyMessage, r.RepliedAt,
               ia.name AS RepliedByName, ia.picture AS RepliedByAvatar
        FROM QnAQuestion q
        JOIN Accounts a ON q.AskedBy = a.AccountID
        LEFT JOIN (
            SELECT rr.*
            FROM (
                SELECT *, ROW_NUMBER() OVER (PARTITION BY QnAID ORDER BY RepliedAt DESC) AS rn
                FROM QnAReply
            ) rr WHERE rr.rn = 1
        ) r ON q.QnAID = r.QnAID
        LEFT JOIN Accounts ia ON r.RepliedBy = ia.AccountID
        WHERE q.CourseID = ?
        ORDER BY q.AskedAt DESC
    """;

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, courseID);
        System.out.println(">>> Running SQL getQuestionsByCourse for CourseID=" + courseID);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                QnAQuestion q = new QnAQuestion();
                q.setQnaID(rs.getInt("QnAID"));
                q.setCourseID(rs.getInt("CourseID"));
                q.setAskedBy(rs.getInt("AskedBy"));
                q.setQuestion(rs.getString("Question"));
                Timestamp askedTs = rs.getTimestamp("AskedAt");
                if (askedTs != null) q.setAskedAt(new java.util.Date(askedTs.getTime()));

                // Thông tin người hỏi
                q.setAskedByName(rs.getString("AskedByName"));
                q.setAskedByAvatar(rs.getString("AskedByAvatar"));

                // Nếu có phản hồi (reply)
                int replyId = rs.getInt("ReplyID");
                if (!rs.wasNull()) {
                    QnAReply reply = new QnAReply();
                    reply.setReplyID(replyId);
                    reply.setQnaID(q.getQnaID());
                    reply.setRepliedBy(rs.getInt("RepliedBy"));
                    reply.setReplyMessage(rs.getString("ReplyMessage"));
                    Timestamp repliedTs = rs.getTimestamp("RepliedAt");
                    if (repliedTs != null) reply.setRepliedAt(new java.util.Date(repliedTs.getTime()));
                    reply.setRepliedByName(rs.getString("RepliedByName"));
                    reply.setRepliedByAvatar(rs.getString("RepliedByAvatar"));
                    q.setReply(reply);
                }

                list.add(q);
                System.out.println(">>> Found question: " + rs.getString("Question"));

            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }

    return list;
}

    public List<QnAReply> getRepliesByQnAID(int qnaID) {
    List<QnAReply> replies = new ArrayList<>();
    String sql = """
        SELECT r.ReplyID, r.ReplyMessage, r.RepliedAt,
               a.name AS RepliedByName, a.picture AS RepliedByAvatar
        FROM QnAReply r
        JOIN Accounts a ON r.RepliedBy = a.AccountID
        WHERE r.QnAID = ?
        ORDER BY r.RepliedAt ASC
    """;

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, qnaID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            QnAReply reply = new QnAReply();
            reply.setReplyID(rs.getInt("ReplyID"));
            reply.setReplyMessage(rs.getString("ReplyMessage"));
            reply.setRepliedAt(rs.getTimestamp("RepliedAt"));
            reply.setRepliedByName(rs.getString("RepliedByName"));
            reply.setRepliedByAvatar(rs.getString("RepliedByAvatar"));
            replies.add(reply);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
        System.out.println(replies.size());
    return replies;
}


    /**
     * Thêm câu hỏi mới.
     * Chỉ INSERT các cột thực sự tồn tại trong bảng QnAQuestion.
     */
public void addQuestion(int courseID, int askedBy, String question) {
    String sql = "INSERT INTO QnAQuestion (CourseID, AskedBy, Question, AskedAt) VALUES (?, ?, ?, GETDATE())";

    // tạo connection mới thay vì dùng connection trong class cha
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, courseID);
        ps.setInt(2, askedBy);
        ps.setString(3, question);
        ps.executeUpdate();

    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}


    /**
     * Thêm reply (giảng viên trả lời). Chỉ insert các cột thực có trong QnAReply.
     */
    public void addReply(int qnaID, int repliedBy, String replyMessage) {
        String sql = "INSERT INTO QnAReply (QnAID, RepliedBy, ReplyMessage, RepliedAt) VALUES (?, ?, ?, GETDATE())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, qnaID);
            ps.setInt(2, repliedBy);
            ps.setString(3, replyMessage);
            ps.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
