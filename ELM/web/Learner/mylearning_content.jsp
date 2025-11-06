<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Nội dung học</title>
        <link rel="stylesheet" href="assets/css/mylearningcontent.css?v3">
        <link rel="stylesheet" href="assets/css/headerLearner.css?v3">
        <link rel="stylesheet" href="assets/css/footer.css?v3">
        <link rel="stylesheet" href="assets/css/comments.css?v1">

    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp"/>
        <h1>${course.title}</h1>

        <div class="content-wrapper">
            <!-- 🔹 CỘT TRÁI: TÀI LIỆU -->
            <div class="materials-pane">
                <h3>Tài liệu bài học</h3>
                <c:choose>
                    <c:when test="${not empty materials}">
                        <ul>
                            <c:forEach var="m" items="${materials}">
                                <li>
                                    <a href="viewMaterial?url=${m.contentURL}" target="_blank">
                                        ${m.title} (${m.materialType})
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p>👉 Hãy chọn một bài học ở bên phải để xem tài liệu.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 🔹 CỘT PHẢI: DANH SÁCH CHƯƠNG/BÀI -->
            <div class="lessons-pane">
                <c:forEach var="entry" items="${chapterLessonMap}">
                    <div class="chapter-block">
                        <c:forEach var="chapter" items="${chapterList}">
                            <c:if test="${chapter.chapterID == entry.key}">
                                <h4>
                                    <input type="checkbox" disabled
                                           <c:if test="${chapterCompletedMap[chapter.chapterID]}">checked</c:if> />
                                    ${chapter.title}
                                </h4>
                            </c:if>
                        </c:forEach>

                        <ul>
                            <c:forEach var="lesson" items="${entry.value}">
                                <li>
                                    <input type="checkbox" class="lesson-check"
                                           data-lessonid="${lesson.lessonID}"
                                           data-courseid="${CourseID}"
                                           <c:if test="${lessonCompletedMap[lesson.lessonID]}">checked</c:if> />
                                    <a href="myContent?CourseID=${CourseID}&LessonID=${lesson.lessonID}"
                                       class="${lesson.lessonID == selectedLessonID ? 'active' : ''}">
                                        ${lesson.title}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>



        
        
        <!-- ====== HỎI & ĐÁP (Q&A) ====== -->
<!-- ====== HỎI & ĐÁP (Q&A) ====== -->
<section class="qna-section" id="qna">
    <div class="qna-header">
        <h3>Hỏi & Đáp khóa học</h3>

    </div>

    <!-- ===== Form đặt câu hỏi ===== -->
    <form action="${pageContext.request.contextPath}/qnaQuestion" method="post">
        <input type="hidden" name="courseID" value="${course.courseID}">
        <div class="qna-ask">
            <textarea name="question" placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>
        </div>
        <div class="qna-actions">
            <button type="submit" class="btn btn-primary">Gửi câu hỏi</button>
        </div>
    </form>

    <!-- ===== Danh sách câu hỏi ===== -->
    <div class="qna-list">
        <c:choose>
            <c:when test="${not empty qnaList}">
                <c:forEach var="q" items="${qnaList}">
                    <div class="qna-item">
                        <div class="avatar">
                                        <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img"/>

                            
                        </div>

                        <div class="qna-body">
                            <!-- ===== Người hỏi ===== -->
                            <div class="qna-meta">
                                <strong>${q.askedByName}</strong>
                                <span class="time">
                                    <fmt:formatDate value="${q.askedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>

                            <div class="qna-question">
                                <c:out value="${q.question}"/>
                            </div>

                            <!-- ===== Trả lời (nếu có) ===== -->
                            <c:if test="${not empty q.reply}">
                                <div class="qna-reply">
                                    <div class="reply-meta">
                                        <img src="${q.repliedByAvatar}" alt="instructor"
                                             onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                        <strong>${q.repliedByName}</strong>
                                        <span class="text-muted">(Giảng viên)</span>
                                    </div>
                                    <div class="reply-content">
                                        <c:out value="${q.reply.replyMessage}"/>
                                    </div>
                                    <div class="reply-time">
                                        <fmt:formatDate value="${q.reply.repliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ===== Form trả lời (chỉ Instructor chủ khóa) ===== -->
                            <c:if test="${account.role eq 'Instructor' && account.accountID == course.instructorID && empty q.reply}">
                                <form action="${pageContext.request.contextPath}/qnaReply" method="post" class="reply-form">
                                    <input type="hidden" name="qnaID" value="${q.qnaID}">
                                    <textarea name="replyMessage" placeholder="Nhập câu trả lời..." required></textarea>
                                    <button type="submit" class="btn btn-success">Gửi phản hồi</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="no-qna">Chưa có câu hỏi nào. Hãy là người đầu tiên đặt câu hỏi!</div>
            </c:otherwise>
        </c:choose>
    </div>
</section>
        <!-- Form hỏi -->
<form action="qnaQuestion" method="post">
    <input type="hidden" name="courseID" value="${CourseID}">
    <textarea name="question" placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>
    <div class="qna-actions">
        <button type="submit">Gửi câu hỏi</button>
    </div>
</form>


<!-- Form trả lời -->
<c:if test="${account.role == 'Instructor' && empty q.reply}">
    <form action="qnaReply" method="post">
        <input type="hidden" name="qnaID" value="${q.qnaID}">
        <textarea name="replyMessage" placeholder="Nhập câu trả lời..." required></textarea>
        <button type="submit">Gửi phản hồi</button>
    </form>
</c:if>




        <!-- footer -->

        <jsp:include page="/components/footer.jsp"/>
        <!-- 🔹 Script xử lý tick bài học -->
        <script>
            document.querySelectorAll(".lesson-check").forEach(chk => {
                chk.addEventListener("change", function () {
                    const lessonID = this.dataset.lessonid;
                    const courseID = this.dataset.courseid;
                    const isCompleted = this.checked;

                    // Gửi request cập nhật
                    const bodyData = "lessonID=" + encodeURIComponent(lessonID)
                            + "&courseID=" + encodeURIComponent(courseID)
                            + "&isCompleted=" + isCompleted;

                    fetch("updateLessonProgress", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: bodyData
                    })
                            .then(res => {
                                if (!res.ok)
                                    throw new Error("Network response was not ok");
                                return res.text();
                            })
                            .then(data => console.log("✅ Update success:", data))
                            .catch(err => console.error("❌ Fetch error:", err));
                });
            });
        </script>

    </body>
</html>
