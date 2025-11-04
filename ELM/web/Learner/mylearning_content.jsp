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
        <style>

        </style>
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
<section class="comments-section" id="comments" style="max-width:1100px;margin:28px auto 40px;background:#fff;border:1px solid #e9ecef;border-radius:12px;padding:20px;box-shadow:0 6px 16px rgba(0,0,0,.04);">
  <div class="comments-header" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:10px;">
    <h3 style="margin:0;font-size:20px;font-weight:700;color:#333;">Bình luận khóa học</h3>
    <div id="comments-count"><c:out value="${fn:length(comments)}"/> bình luận</div>
  </div>

  <!-- Form bình luận -->
  <form id="commentForm" onsubmit="return false;" style="display:grid;gap:10px;margin-top:10px;">
    <input type="hidden" id="courseId" value="${CourseID}">
    <textarea id="commentContent" placeholder="Viết bình luận của bạn..." maxlength="2000" required
              style="width:100%;min-height:110px;padding:12px 14px;border:1px solid #ddd;border-radius:10px;resize:vertical;font-size:14px;line-height:1.5;"></textarea>
    <div style="display:flex;gap:10px;justify-content:flex-end;">
      <button type="submit" id="submitComment"
              style="background:#ff7f00;color:#fff;border:1px solid transparent;border-radius:10px;padding:10px 14px;font-weight:600;cursor:pointer;">
        Đăng bình luận
      </button>
    </div>
  </form>

  <!-- Danh sách bình luận -->
  <div class="comments-list" id="commentsList" style="margin-top:18px;">
    <c:choose>
      <c:when test="${not empty comments}">
        <c:forEach var="cmt" items="${comments}">
          <div class="comment-item" data-id="${cmt.id}" style="display:flex;gap:12px;padding:14px;border:1px solid #f0f0f0;border-radius:10px;background:#fafafa;margin-bottom:12px;">
            <div class="avatar" style="width:40px;height:40px;border-radius:50%;background:#ffe7d1;display:flex;align-items:center;justify-content:center;font-weight:700;color:#ff7f00;">
              <c:out value="${fn:substring(cmt.authorName,0,1)}"/>
            </div>
            <div class="comment-body" style="flex:1;">
              <div class="comment-meta" style="font-size:13px;color:#666;display:flex;gap:8px;align-items:center;margin-bottom:6px;">
                <strong><c:out value="${cmt.authorName}"/></strong> •
                <span><fmt:formatDate value="${cmt.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
              </div>
              <div class="comment-content" style="white-space:pre-wrap;font-size:14px;color:#222;">
                <c:out value="${cmt.content}"/>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div style="text-align:center;color:#777;background:#fcfcfc;border:1px dashed #e5e5e5;padding:16px;border-radius:10px;">
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
