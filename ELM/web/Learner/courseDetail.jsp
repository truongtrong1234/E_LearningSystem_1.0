<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${course.title} | SecretCoder</title>
    <link rel="stylesheet" href="${ctx}/assets/css/courseDetail.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="header.jsp" />

    <!-- MAIN CONTENT -->
    <div class="course-detail-container">
        <div class="course-hero">
            <div class="hero-left">
                <h1>${course.title}</h1>
                <p class="desc">${course.description}</p>
                <p class="meta">
                    <i class="bi bi-person-circle"></i> Giảng viên: <strong>${course.instructorName}</strong><br>
                    <i class="bi bi-collection-play"></i> Số bài học: <strong>${totalLessons}</strong> |
                    <i class="bi bi-people"></i> Học viên: <strong>${course.enrolledCount}</strong>
                </p>
                <div class="price">
                    <c:choose>
                        <c:when test="${course.price == 0}">
                            <span class="free">Miễn phí</span>
                        </c:when>
                        <c:otherwise>
                            <span class="amount">${course.price}đ</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="actions">
                    <form action="${ctx}/enroll" method="post">
                        <input type="hidden" name="courseID" value="${course.courseID}">
                        <button type="submit" class="btn-enroll">Đăng ký học ngay</button>
                    </form>
                </div>
            </div>

            <div class="hero-right">
                <img src="${course.thumbnail}" alt="${course.title}">
            </div>
        </div>

        <!-- COURSE CONTENT -->
        <section class="course-content">
            <h2>Nội dung khóa học</h2>
            <c:forEach var="ch" items="${course.chapters}">
                <div class="chapter">
                    <h3>${ch.title}</h3>
                    <ul class="lesson-list">
                        <c:forEach var="ls" items="${ch.lessons}">
                            <li>
                                <i class="bi bi-play-circle"></i>
                                ${ls.title}
                                <span class="duration">${ls.duration}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </section>

        <!-- RELATED COURSES -->
        <section class="related">
            <h2>Khóa học liên quan</h2>
            <div class="related-grid">
                <c:forEach var="rc" items="${relatedCourses}">
                    <a class="course-card" href="${ctx}/courseDetail?id=${rc.courseID}">
                        <img src="${rc.thumbnail}" alt="">
                        <div class="body">
                            <div class="title">${rc.title}</div>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${rc.price == 0}">Miễn phí</c:when>
                                    <c:otherwise>${rc.price}đ</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>
    </div>

    <footer>© 2025 SecretCoder. All rights reserved.</footer>

</body>
</html>
