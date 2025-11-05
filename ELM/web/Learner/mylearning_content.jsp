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
<!-- ====== BÌNH LUẬN KHOÁ HỌC (no edit/delete) ====== -->
<section class="comments-section" id="comments">
    <div class="comments-header">
        <h3>Bình luận khóa học</h3>
        <div id="comments-count"><c:out value="${fn:length(comments)}"/> bình luận</div>
    </div>

    <!-- Form bình luận -->
    <form id="commentForm" onsubmit="return false;">
        <input type="hidden" id="courseId" value="${CourseID}">
        <textarea id="commentContent" placeholder="Viết bình luận của bạn..." maxlength="2000" required></textarea>
        <div class="comment-actions">
            <button type="submit" id="submitComment">Đăng bình luận</button>
        </div>
    </form>

    <!-- Danh sách bình luận -->
    <div class="comments-list" id="commentsList">
        <c:choose>
            <c:when test="${not empty comments}">
                <c:forEach var="cmt" items="${comments}">
                    <div class="comment-item" data-id="${cmt.id}">
                        <div class="avatar">
                            <c:out value="${fn:substring(cmt.authorName,0,1)}"/>
                        </div>
                        <div class="comment-body">
                            <div class="comment-meta">
                                <strong><c:out value="${cmt.authorName}"/></strong> •
                                <span><fmt:formatDate value="${cmt.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                            </div>
                            <div class="comment-content">
                                <c:out value="${cmt.content}"/>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-comments">
                    Chưa có bình luận nào. Hãy là người đầu tiên!
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>


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
