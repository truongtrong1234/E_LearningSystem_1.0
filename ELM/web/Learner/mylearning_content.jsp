<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- CSS cũ -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/comments.css?v=3">

    <style>
        body {
            background: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        h1 {
            margin: 30px;
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            overflow: hidden;
            padding: 0 0px;
        }

        /* Cột trái - toàn bộ nội dung */
        .main-pane {
            flex: 1;
            background: #fff;
            padding: 0px;
            border-radius: 0px;
            box-shadow: 0 0 6px rgba(0,0,0,0.08);
            overflow-y: auto;
            margin-right: 380px; /* chừa chỗ sidebar */
            
        }
        .materials-pane{
            min-height: 400px;
        }

        /* Sidebar bên phải */
        .lessons-pane {
            position: fixed;
            right: 0;
            top: 70px;
            bottom: 0;
            width: 400px;
            overflow-y: auto;
            background: #fff;
            border-left: 1px solid #dee2e6;
            padding: 0px;
        }

        .lessons-pane h3 {
            padding-left: 20px;
            padding-top: 15px;
            font-size: 20px;
        }
        .lessons-pane h4 {
            font-weight: 600;
            font-size: 1.1rem;
            margin-top: 15px;
        }

        .lessons-pane ul {
            padding-left: 15px;
        }

        .lessons-pane li {
            list-style: none;
            margin-bottom: 6px;
        }

        .lessons-pane a.active {
            color: #0d6efd;
            font-weight: 600;
        }

        /* Q&A */
        .qna-section {
            margin-top: 50px;
        }

        .qna-item {
            display: flex;
            gap: 10px;
            background: #f9f9f9;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 15px;
        }

        .avatar-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .qna-body {
            flex: 1;
        }

        .reply-form textarea {
            width: 100%;
            min-height: 80px;
            resize: vertical;
        }

        .qna-reply {
            margin-top: 10px;
            padding-left: 50px;
            border-left: 2px solid #e0e0e0;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .lessons-pane {
                position: relative;
                width: 100%;
                border-left: none;
                border-top: 1px solid #dee2e6;
                top: 0;
                margin-top: 20px;
            }
            .main-pane {
                margin-right: 0;
            }
        }
    </style>
</head>

<body>
    <!-- HEADER -->
    <jsp:include page="/components/headerLearner.jsp"/>

    <h3>${course.title}</h3>

    <div class="content-wrapper">
        <!-- CỘT TRÁI: Toàn bộ nội dung -->
        <div class="main-pane">

            <!-- ====== Tài liệu ====== -->
            <div class="materials-pane mb-4">

                
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
                        <p>Hãy chọn một bài học ở bên phải để xem tài liệu.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- ====== Hỏi & Đáp ====== -->
            <section class="qna-section" id="qna">
                <div class="qna-header">
                    <h3>Hỏi & Đáp khóa học</h3>
                </div>

                <!-- Danh sách câu hỏi -->
                <div class="qna-list">
                    <c:choose>
                        <c:when test="${not empty qnaList}">
                            <c:forEach var="q" items="${qnaList}">
                                <div class="qna-item">
                                    <div class="avatar">
                                        <img src="${q.askedByAvatar}" class="avatar-img"
                                             onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                    </div>
                                    <div class="qna-body">
                                        <div class="qna-meta">
                                            <strong>${q.askedByName}</strong>
                                            <span class="time text-muted small">
                                                <fmt:formatDate value="${q.askedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                        </div>
                                        <div class="qna-question">
                                            <c:out value="${q.question}"/>
                                        </div>

                                        <!-- Nút Reply -->
                                        <c:if test="${account.role eq 'instructor' && account.accountId == course.instructorID }">
                                            <div class="qna-actions mt-1">
                                                <a href="javascript:void(0);" class="reply-link text-primary small"
                                                   onclick="toggleReplyForm(${q.qnaID})">Reply</a>
                                            </div>

                                            <!-- Form trả lời -->
                                            <div class="reply-form" id="reply-form-${q.qnaID}" style="display:none; margin-top:8px;">
                                                <div class="reply-input-container d-flex gap-2">
                                                    <img src="${sessionScope.account.picture}" class="avatar-img"
                                                         onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                                    <div class="flex-grow-1">
                                                        <div class="reply-username"><strong>${sessionScope.account.name}</strong></div>
                                                        <form action="${pageContext.request.contextPath}/qnaReply" method="post">
                                                            <input type="hidden" name="qnaID" value="${q.qnaID}">
                                                            <input type="hidden" name="courseID" value="${course.courseID}">
                                                            <textarea name="replyMessage" placeholder="Nhập câu trả lời..." required></textarea>
                                                            <div class="reply-actions mt-2 d-flex gap-2">
                                                                <button type="submit" class="btn btn-success btn-sm">Gửi</button>
                                                                <button type="button" class="btn btn-light btn-sm"
                                                                        onclick="toggleReplyForm(${q.qnaID})">Hủy</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <!-- Trả lời -->
                                        <c:forEach var="r" items="${replyMap[q.qnaID]}">
                                            <div class="qna-reply">
                                                <div class="reply-meta mb-1">
                                                    <img src="${r.repliedByAvatar}" class="avatar-img"
                                                         onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                                                    <strong>${r.repliedByName}</strong>
                                                    <span class="text-muted small">(Giảng viên)</span>
                                                </div>
                                                <div class="reply-content"><c:out value="${r.replyMessage}"/></div>
                                                <div class="reply-time text-muted small">
                                                    <fmt:formatDate value="${r.repliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-qna text-muted">Chưa có câu hỏi nào. Hãy là người đầu tiên đặt câu hỏi!</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Form hỏi mới -->
                <form action="${pageContext.request.contextPath}/qnaQuestion" method="post" class="ask-form mt-4">
                    <input type="hidden" name="courseID" value="${CourseID}">
                    <div class="ask-input-container d-flex gap-3">
                        <img src="${sessionScope.account.picture}" class="avatar-img"
                             onerror="this.src='https://i.imgur.com/6VBx3io.png'">
                        <div class="flex-grow-1">
                            <div class="ask-username"><strong>${sessionScope.account.name}</strong></div>
                            <textarea name="question" placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>
                            <div class="qna-actions mt-2">
                                <button type="submit" class="btn btn-primary">Gửi câu hỏi</button>
                            </div>
                        </div>
                    </div>
                </form>
            </section>

            <!-- FOOTER -->
            <jsp:include page="/components/footer.jsp"/>

        </div>

       <!-- CỘT PHẢI: Danh sách chương/bài -->
<div class="lessons-pane">
    <h3>Tất cả bài học</h3>

    <div class="accordion" id="chapterAccordion">
        <c:forEach var="entry" items="${chapterLessonMap}" varStatus="loop">
            <div class="accordion-item mb-2">
                <c:forEach var="chapter" items="${chapterList}">
                    <c:if test="${chapter.chapterID == entry.key}">
                        <h2 class="accordion-header" id="heading${loop.index}">
                            <button class="accordion-button collapsed d-flex align-items-center gap-2"
                                    
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${loop.index}"
                                    aria-expanded="false"
                                    aria-controls="collapse${loop.index}">
                                <input type="checkbox" disabled
                                       <c:if test="${chapterCompletedMap[chapter.chapterID]}">checked</c:if> />
                                <span>${chapter.title}</span>
                            </button>
                        </h2>
                    </c:if>
                </c:forEach>

                <div id="collapse${loop.index}" class="accordion-collapse collapse"
                     aria-labelledby="heading${loop.index}" >
                    <div class="accordion-body">
                        <!-- Danh sách bài học -->
                        <ul class="list-group list-group-flush mb-2">
                            <c:forEach var="lesson" items="${entry.value}">
                                <li class="list-group-item d-flex align-items-center gap-2">
                                    <input type="checkbox" class="lesson-check"
                                           data-lessonid="${lesson.lessonID}"
                                           data-courseid="${CourseID}"
                                           <c:if test="${lessonCompletedMap[lesson.lessonID]}">checked</c:if> />
                                    <a href="myContent?CourseID=${CourseID}&LessonID=${lesson.lessonID}"
                                       class="${lesson.lessonID == selectedLessonID ? 'fw-bold text-primary' : ''}">
                                        ${lesson.title}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>

                        <!-- Danh sách quiz -->
                        <ul class="list-group list-group-flush">
                            <c:forEach var="quiz" items="${chapterQuizMap[entry.key]}">
                                <li class="list-group-item d-flex align-items-center gap-2">
                                    <input type="checkbox" class="quiz-check"
                                           data-quizid="${quiz.quizID}"
                                           data-courseid="${CourseID}"
                                           <c:if test="${quizCompletedMap[quiz.quizID]}">checked</c:if> />
                                    <a href="Learner/doQuiz?CourseID=${CourseID}&ChapterID=${entry.key}&QuizID=${quiz.quizID}"
                                       class=" ${quiz.quizID == selectedQuizID ? 'active' : ''}">
                                        <i class="bi bi-question-circle me-1"></i> ${quiz.title}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

    </div>

    <!-- Tick bài học -->
    <script>
        document.querySelectorAll(".lesson-check").forEach(chk => {
            chk.addEventListener("change", function () {
                const bodyData = "lessonID=" + encodeURIComponent(this.dataset.lessonid)
                    + "&courseID=" + encodeURIComponent(this.dataset.courseid)
                    + "&isCompleted=" + this.checked;

                fetch("updateLessonProgress", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: bodyData
                }).then(res => res.text())
                  .then(data => console.log("Update:", data))
                  .catch(err => console.error("Fetch error:", err));
            });
        });

        function toggleReplyForm(qnaID) {
            const form = document.getElementById("reply-form-" + qnaID);
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
    </script>
</body>
</html>
