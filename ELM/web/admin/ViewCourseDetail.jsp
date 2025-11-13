<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/comments.css">


<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login");
        return;
    }
%>
<style>
    .page-header {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #007bff; /* xanh biển đậm */
        color: white;
        padding: 15px 20px;
        position: relative;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    /* đảm bảo không bị nền khác đè */
    .page-header h1 {
        margin: 0;
        font-size: 24px;
        font-weight: 600;
        color: white;
        background: none !important;
        border: none !important;
    }

    /* nút quay lại */
    .back-button {
        position: absolute;
        left: 20px;
        color: white;
        background-color: rgba(255, 255, 255, 0.2);
        padding: 8px 14px;
        border-radius: 6px;
        text-decoration: none;
        transition: background-color 0.2s ease;
        font-weight: 500;
    }

    .back-button:hover {
        background-color: rgba(255, 255, 255, 0.4);
    }

</style>
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
        <div class="page-header">
            <a href="${pageContext.request.contextPath}/admin/manageCourse"class="back-button">← Quay lại</a>
            <h1>${course.title}</h1>
        </div>


        <div class="content-wrapper">
            <!-- CỘT TRÁI: TÀI LIỆU -->
            <div class="materials-pane" >
                <h3>Tài liệu bài học</h3>
                <c:choose>
                    <c:when test="${not empty materials}">
                        <ul>
                            <c:forEach var="m" items="${materials}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/viewMaterial?url=${m.contentURL}" target="_blank">
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
                                    <a href="${pageContext.request.contextPath}/admin/viewCourseDetail?CourseID=${CourseID}&LessonID=${lesson.lessonID}"
                                       class="${lesson.lessonID == selectedLessonID ? 'active' : ''}">
                                        ${lesson.title}
                                    </a>

                                </li>
                            </c:forEach>
                        </ul>

                        <ul>
                            <c:forEach var="quiz" items="${chapterQuizMap[entry.key]}">
                                <li style="margin-bottom:15px;">
                                    <a  href="${pageContext.request.contextPath}/admin/quizDetail?QuizID=${quiz.quizID}"
                                        class="btn btn-primary btn-sm">
                                        <i class="bi bi-question-circle me-1"></i> ${quiz.title}
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                        <p>Bài kiểm tra</p>
                        <ul>

                            <c:forEach var="quiz" items="${chapterQuizMap[entry.key]}">
                                <li>
                                    <a  href="${pageContext.request.contextPath}/admin/quizDetail?QuizID=${quiz.quizID}"
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



        <!-- Q&A -->
        <section class="qna-section" id="qna">
            <h3>Hỏi & Đáp khóa học</h3>

            <div class="qna-list">
                <c:choose>
                    <c:when test="${not empty qnaList}">
                        <c:forEach var="q" items="${qnaList}">
                            <div class="qna-item">
                                <img src="${q.askedByAvatar}" class="avatar-img" alt="avatar"
                                     onerror="this.src='https://i.imgur.com/6VBx3io.png'">

                                <div class="qna-body">
                                    <div class="qna-meta">
                                        <strong>${q.askedByName}</strong> •
                                        <fmt:formatDate value="${q.askedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>

                                    <div class="qna-question">${q.question}</div>

                                    <!-- Form trả lời (chỉ hiển thị cho giảng viên) -->
                                   
                                        <a href="javascript:void(0)" onclick="toggleReplyForm(${q.qnaID})"
                                           class="btn btn-sm btn-outline-primary">Trả lời</a>

                                        <div class="reply-form" id="reply-form-${q.qnaID}" style="display:none; margin-top:8px;">
                                            <form action="${pageContext.request.contextPath}/qnaReply" method="post">
                                                <input type="hidden" name="qnaID" value="${q.qnaID}">
                                                <input type="hidden" name="courseID" value="${course.courseID}">
                                                <textarea name="replyMessage" placeholder="Nhập câu trả lời..." required></textarea>
                                                <div class="qna-actions">
                                                    <button type="submit" class="btn btn-success btn-sm">Gửi</button>
                                                    <input type="hidden" name="redirectURL" value="/ELM/admin/viewCourseDetail?CourseID=${course.courseID}">
                                                    <button type="button" class="btn btn-light btn-sm"
                                                            onclick="toggleReplyForm(${q.qnaID})">Hủy</button>
                                                </div>
                                            </form>
                                        </div>
                                   

                                    <!-- Các câu trả lời -->
                                    <c:forEach var="r" items="${replyMap[q.qnaID]}">
                                        <div class="qna-reply">
                                            <div class="reply-meta">
                                                <strong>${r.repliedByName}</strong>
                                            </div>
                                            <div class="reply-content">${r.replyMessage}</div>
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

            <!-- Form đặt câu hỏi -->
            <form action="${pageContext.request.contextPath}/qnaQuestion" method="post" class="ask-form">
                <input type="hidden" name="courseID" value="${course.courseID}">
                <input type="hidden" name="redirectURL" value="/ELM/admin/viewCourseDetail?CourseID=${course.courseID}">


                <div class="ask-input-container">
                    <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img"
                         onerror="this.src='https://i.imgur.com/6VBx3io.png'">

                    <div class="ask-right">
                        <div><strong>${sessionScope.account.name}</strong></div>
                        <textarea name="question" placeholder="Nhập câu hỏi của bạn..." maxlength="2000" required></textarea>
                        <button type="submit" class="btn btn-primary mt-2">Gửi câu hỏi</button>
                    </div>
                </div>
            </form>
        </section>
    </div>

    <footer>© 2025 E-Learning System</footer>

    <script>
        function toggleReplyForm(id) {
            const f = document.getElementById('reply-form-' + id);
            f.style.display = f.style.display === 'none' || f.style.display === '' ? 'block' : 'none';
        }
    </script>
</body>
</html>
