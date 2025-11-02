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
    <h1>Nội dung khóa học</h1>

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
                    <h4>
                        <input type="checkbox" disabled
                               <c:if test="${chapterCompletedMap[entry.key]}">checked</c:if> />
                        Chương ${entry.key}
                    </h4>
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

    <!-- footer -->
    
        <jsp:include page="/components/footer.jsp"/>
    <!-- 🔹 Script xử lý tick bài học -->
<script>
document.querySelectorAll(".lesson-check").forEach(chk => {
  chk.addEventListener("change", function() {
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
      if (!res.ok) throw new Error("Network response was not ok");
      return res.text();
    })
    .then(data => console.log("✅ Update success:", data))
    .catch(err => console.error("❌ Fetch error:", err));
  });
});
</script>

</body>
</html>
