<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <!-- thêm ?v=3 để phá cache -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home_learner.css?v=3">
           <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/homeGuest.css?v=3">
        <title>SecretCoder | Guest</title>

        
        
    </head>
    <body>

        <!-- HEADER -->
        <jsp:include page="components/homeGuest.jsp"/>

        <!-- CATEGORY BAR -->
        <div class="category-wrap">
            <div class="category-bar">
                <c:forEach var="cat" items="${listOfCategories}">
                    <a href="${pageContext.request.contextPath}/searchCourse?cats=${cat.cate_id}">
                        ${cat.cate_name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- BANNER -->
        <section class="hero">
            <div class="hero-left">
                <div class="hero-card">
                    <h2>Welcome to SecretCoder</h2>
                    <p>Learn coding, AI, and more with expert-led online courses. Join our learning community today!</p>
                    <div>
                        <a href="<%=ctx%>/login.jsp" class="btn-primary">Get started for free</a>
                    </div>
                </div>
            </div>
            <div class="hero-right">
                <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?q=80&w=1200&auto=format&fit=crop" alt="Learning">
            </div>
        </section>

        <!-- COURSES -->
        <section class="section">
            <h3>Popular Courses</h3>
            <div class="grid">
                <c:forEach var="c" items="${listCourse}">
                    <a class="course-card" href="${pageContext.request.contextPath}/courseDetail?id=${c.courseID}">
                        <div class="thumb">
                            <img src="${c.thumbnail}" alt="${c.title}">
                        </div>
                        <div class="body">
                            <div class="title">${c.title}</div>
                            <div class="meta">Instructor ID: ${c.instructorID}</div>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${c.price == 0}">
                                        Miễn phí
                                    </c:when>
                                    <c:otherwise>
                                        ${c.price}đ
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>

        <!-- FOOTER -->
        <footer class="footer">
            <div class="footer-container">
                <!-- Logo + mô tả -->
                <div class="footer-about">
                    <div class="footer-logo">
                        <div class="logo-icon">E</div>
                        <span class="logo-text">E Learning</span>
                    </div>
                    <p>
                        Nền tảng học tập trực tuyến hàng đầu Việt Nam,
                        giúp bạn phát triển kỹ năng và thăng tiến trong sự nghiệp.
                    </p>
                    <div class="footer-socials">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-twitter"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>

                <!-- Liên kết nhanh -->
                <div class="footer-links">
                    <h4>LIÊN KẾT NHANH</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home_Guest">Trang chủ</a></li>
                        <li><a href="#">Khóa học</a></li>
                        <li><a href="#">Bài viết</a></li>
                        <li><a href="#">Về chúng tôi</a></li>
                        <li><a href="#">Liên hệ</a></li>
                    </ul>
                </div>

                <!-- Hỗ trợ -->
                <div class="footer-support">
                    <h4>HỖ TRỢ</h4>
                    <ul>
                        <li><a href="#">Trung tâm trợ giúp</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>© 2025 E Learning. Tất cả quyền được bảo lưu.</p>
                <p>Được phát triển với <span class="heart">❤</span> tại Việt Nam</p>
            </div>
        </footer>

    </body>
</html>
