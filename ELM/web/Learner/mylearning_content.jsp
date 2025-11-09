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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mylearningcontent.css?v=3">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=3">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/comments.css">



    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp"/>
        <h1>${course.title}</h1>

        <div class="content-wrapper">
            <!-- CỘT TRÁI: TÀI LIỆU -->
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
                        <p> Hãy chọn một bài học ở bên phải để xem tài liệu.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="materials-pane">
                <h3>Kết quả bài kiểm tra</h3>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-warning">
                            <tr>
                                <th scope="col">Tên bài kiểm tra</th>
                                <th scope="col" class="text-end">Kết quả</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:choose>
                                <c:when test="${not empty QuizMap}">
                                    <c:forEach var="entry" items="${QuizMap}">
                                        <tr>
                                            <td>${entry.key}</td>
                                            <td class="text-end">
                                                <c:choose>
                                                    <c:when test="${entry.value != null}">
                                                        <span class="fw-bold text-dark">${entry.value}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted fst-italic">Chưa làm</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach> 
                                </c:when>
                                <c:otherwise>
                                <span class="text-muted fst-italic">Không có bài kiểm tra nào</span>
                            </c:otherwise>
                        </c:choose>

                        </tbody>
                    </table>
                </div>
            </div>
            <!-- CỘT PHẢI: DANH SÁCH CHƯƠNG/BÀI -->
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
                        <p>Bài kiểm tra</p>
                        <ul>

                            <c:forEach var="quiz" items="${chapterQuizMap[entry.key]}">
                                <li>
                                    <a href="Learner/doQuiz?CourseID=${CourseID}&ChapterID=${entry.key}&QuizID=${quiz.quizID}"
                                       class="btn btn-primary btn-sm">
                                        <i class="bi bi-question-circle me-1"></i> ${quiz.title}
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>



        <!-- ====== HỎI & ĐÁP (Q&A) ====== -->
        <section class="qna-section" id="qna">
            <div class="qna-header">
                <h3>Hỏi & Đáp khóa học</h3>

            </div>


            <!-- ===== Danh sách câu hỏi ===== -->
            <div class="qna-list">
                <c:choose>
                    <c:when test="${not empty qnaList}">
                        <c:forEach var="q" items="${qnaList}">
                            <div class="qna-item">
                                <!-- ===== Avatar người hỏi ===== -->
                                <div class="avatar">
                                    <img src="${q.askedByAvatar}" 
                                         alt="avatar" 
                                         class="avatar-img"
                                         onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                </div>

                                <div class="qna-body">
                                    <!-- ===== Người hỏi ===== -->
                                    <div class="qna-meta">
                                        <strong>${q.askedByName}</strong>
                                        <span class="time">
                                            <fmt:formatDate value="${q.askedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>

                                    <!-- ===== Nội dung câu hỏi ===== -->
                                    <div class="qna-question">
                                        <c:out value="${q.question}"/>
                                    </div>




                                    <!-- ===== Nút Reply (chỉ Instructor chủ khóa, nếu chưa có reply) ===== -->
                                    <c:if test="${account.role eq 'instructor' && account.accountId == course.instructorID }">
                                        <div class="qna-actions">
                                            <a href="javascript:void(0);" class="reply-link"
                                               onclick="toggleReplyForm(${q.qnaID})">Reply</a>

                                        </div>

                                        <!-- Form trả lời (ẩn mặc định, chỉ hiện khi ấn nút Reply) -->
                                        <div class="reply-form" id="reply-form-${q.qnaID}" style="display:none; margin-top:8px;">
                                            <div class="reply-input-container">
                                                <img src="${sessionScope.account.picture}" class="avatar-img" alt="avatar"
                                                     onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                                <div class="reply-right">
                                                    <div class="reply-username"><strong>${sessionScope.account.name}</strong></div>
                                                    <form action="${pageContext.request.contextPath}/qnaReply" method="post">
                                                        <input type="hidden" name="qnaID" value="${q.qnaID}">
                                                        <input type="hidden" name="courseID" value="${course.courseID}">
                                                        <textarea name="replyMessage" placeholder="Nhập câu trả lời..." required></textarea>
                                                        <div class="reply-actions">
                                                            <button type="submit" class="btn btn-success btn-sm">Gửi</button>
                                                            <button type="button" class="btn btn-light btn-sm" onclick="toggleReplyForm(${q.qnaID})">Hủy</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                    </c:if>




                                    <!-- ===== Trả lời (nếu có) ===== -->
                                    <c:forEach var="r" items="${replyMap[q.qnaID]}">
                                        <div class="qna-reply">
                                            <div class="reply-meta">
                                                <img src="${r.repliedByAvatar}" alt="instructor"
                                                     onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                                <strong>${r.repliedByName}</strong>
                                                <span class="text-muted">(Giảng viên)</span>
                                            </div>
                                            <div class="reply-content">
                                                <c:out value="${r.replyMessage}"/>
                                            </div>
                                            <div class="reply-time">
                                                <fmt:formatDate value="${r.repliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </div>
                                    </c:forEach>


                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="no-qna">Chưa có câu hỏi nào. Hãy là người đầu tiên đặt câu hỏi!</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- ===== Form hỏi câu hỏi mới ===== -->
            <form action="${pageContext.request.contextPath}/qnaQuestion" method="post" class="ask-form">
                <input type="hidden" name="courseID" value="${CourseID}">

                <div class="ask-input-container">
                    <!-- Ảnh đại diện -->
                    <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img" 
                         onerror="this.src='https://i.imgur.com/6VBx3io.png'">

                    <div class="ask-right">
                        <!-- Tên người hỏi -->
                        <div class="ask-username">
                            <strong>${sessionScope.account.name}</strong>
                        </div>

                        <!-- Ô nhập câu hỏi -->
                        <textarea name="question" placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>

                        <!-- Nút gửi -->
                        <div class="qna-actions">
                            <button type="submit" class="btn btn-primary">Gửi câu hỏi</button>
                        </div>
                    </div>
                </div>
            </form>
        </section>


        <!-- footer -->

        <jsp:include page="/components/footer.jsp"/>
        <!--  Script xử lý tick bài học -->
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
                            .then(data => console.log("Update success:", data))
                            .catch(err => console.error("Fetch error:", err));
                });
            });
        </script>
        <!-- Xử lí nút rep -->
        <script>
            function toggleReplyForm(qnaID) {
                const form = document.getElementById("reply-form-" + qnaID);
                if (form.style.display === "none" || form.style.display === "") {
                    form.style.display = "block";
                } else {
                    form.style.display = "none";
                }
            }
        </script>


    </body>
</html>
