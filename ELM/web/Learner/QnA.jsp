<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Demo Q&A Section</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 30px;
        }
        .qna-section {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            max-width: 800px;
            margin: auto;
        }
        .qna-header h3 {
            margin: 0;
            color: #333;
        }
        .qna-subtitle {
            color: #777;
            margin-bottom: 20px;
        }
        textarea {
            width: 100%;
            min-height: 80px;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }
        button {
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            cursor: pointer;
        }
        .qna-item {
            display: flex;
            gap: 12px;
            border-bottom: 1px solid #eee;
            padding: 16px 0;
        }
        .avatar img {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }
        .qna-body {
            flex: 1;
        }
        .qna-meta {
            font-size: 14px;
            color: #555;
        }
        .qna-meta strong {
            color: #222;
        }
        .qna-question {
            margin-top: 6px;
            font-size: 15px;
        }
        .qna-reply {
            margin-top: 12px;
            padding: 12px;
            background: #f5f8ff;
            border-left: 4px solid #007bff;
            border-radius: 6px;
        }
        .reply-meta {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: bold;
        }
        .reply-meta img {
            width: 28px;
            height: 28px;
            border-radius: 50%;
        }
        .reply-content {
            margin-top: 4px;
        }
        .reply-btn {
            margin-top: 10px;
            background: #28a745;
        }
        .no-qna {
            text-align: center;
            color: #777;
            padding: 20px;
        }
    </style>
</head>
<body>
<%
    class QnAReply {
        public String replyMessage, repliedByName, repliedByAvatar;
        public java.util.Date repliedAt;
        public QnAReply(String msg, String by, String avt, java.util.Date at) {
            this.replyMessage = msg;
            this.repliedByName = by;
            this.repliedByAvatar = avt;
            this.repliedAt = at;
        }
        public String getReplyMessage() { return replyMessage; }
        public String getRepliedByName() { return repliedByName; }
        public String getRepliedByAvatar() { return repliedByAvatar; }
        public java.util.Date getRepliedAt() { return repliedAt; }
    }

    class QnA {
        public int qnaID;
        public String question, askedByName, askedByAvatar;
        public java.util.Date askedAt;
        public QnAReply reply;
        public QnA(int id, String q, String by, String avt, java.util.Date at, QnAReply r) {
            this.qnaID = id;
            this.question = q;
            this.askedByName = by;
            this.askedByAvatar = avt;
            this.askedAt = at;
            this.reply = r;
        }
        public int getQnaID() { return qnaID; }
        public String getQuestion() { return question; }
        public String getAskedByName() { return askedByName; }
        public String getAskedByAvatar() { return askedByAvatar; }
        public java.util.Date getAskedAt() { return askedAt; }
        public QnAReply getReply() { return reply; }
    }

    java.util.List<QnA> fakeQnAList = new java.util.ArrayList<>();

    fakeQnAList.add(new QnA(1,
        "Thầy ơi, phần ví dụ trong bài 3 có thể áp dụng cho project cuối kỳ không ạ?",
        "Nguyễn Văn A",
        "assets/img/avt1.jpg",
        new java.util.Date(System.currentTimeMillis() - 3600_000),
        new QnAReply(
            "Có em nhé, chỉ cần chỉnh sửa phần đầu vào để phù hợp với đề bài project là được.",
            "Thầy Trần Minh",
            "assets/img/teacher1.jpg",
            new java.util.Date(System.currentTimeMillis() - 1800_000)
        )
    ));

    fakeQnAList.add(new QnA(2,
        "Em bị lỗi khi chạy code trong Lesson 5, nó báo lỗi NullPointerException. Thầy giúp em với.",
        "Lê Thị B",
        "assets/img/avt2.jpg",
        new java.util.Date(System.currentTimeMillis() - 7200_000),
        null
    ));

    pageContext.setAttribute("qnaList", fakeQnAList);
%>



<section class="qna-section">
    <div class="qna-header">
        <h3>Hỏi & Đáp khóa học</h3>
        <p class="qna-subtitle">Đặt câu hỏi cho giảng viên hoặc xem phản hồi từ họ.</p>
    </div>

    <form id="questionForm" onsubmit="return false;">
        <textarea placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>
        <div class="qna-actions">
            <button type="submit">Gửi câu hỏi</button>
        </div>
    </form>

    <div class="qna-list">
        <c:choose>
            <c:when test="${not empty qnaList}">
 <%
    for (Object obj : fakeQnAList) {
        QnA q = (QnA) obj;
%>
    <div class="qna-item" data-id="<%= q.qnaID %>">
        <div class="avatar">
            <img src="<%= q.askedByAvatar %>" onerror="this.src='https://i.imgur.com/6VBx3io.png'">
        </div>
        <div class="qna-body">
            <div class="qna-meta">
                <strong><%= q.askedByName %></strong>
                <span class="time"><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(q.askedAt) %></span>
            </div>
            <div class="qna-question"><%= q.question %></div>

            <% if (q.reply != null) { %>
                <div class="qna-reply">
                    <div class="reply-meta">
                        <img src="<%= q.reply.repliedByAvatar %>" alt="instructor" onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                        <strong><%= q.reply.repliedByName %></strong> <span>(Giảng viên)</span>
                    </div>
                    <div class="reply-content"><%= q.reply.replyMessage %></div>
                    <div class="reply-time">
                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(q.reply.repliedAt) %>
                    </div>
                </div>
            <% } else { %>
                <div class="no-reply">⏳ Chưa có phản hồi từ giảng viên.</div>
            <% } %>
        </div>
    </div>
<% } %>

            </c:when>
            <c:otherwise>
                <div class="no-qna">Chưa có câu hỏi nào. Hãy là người đầu tiên đặt câu hỏi!</div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

</body>
</html>
