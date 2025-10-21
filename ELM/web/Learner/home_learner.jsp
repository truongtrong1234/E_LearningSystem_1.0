<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SecretCoder | Learner</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/learner.css">
</head>
<body>

<!-- HEADER -->
<header class="header">
    <div class="logo">Secret<span>Coder</span></div>
    <div class="search-bar">
        <input type="text" placeholder="Tìm khóa học, chủ đề, kỹ năng...">
        <button>🔍</button>
    </div>
    <nav class="nav-links">
     
        <a href="/ELM/course">Instructor</a>
    </nav>
    <div class="header-icons">
        <span class="icon">🔔</span>
        <span class="icon">🛒</span>
        <div class="avatar">U</div>
    </div>
</header>

<!-- CATEGORY BAR -->
<section class="category-bar">
    <a href="#">Microsoft Excel</a>
    <a href="#">AWS</a>
    <a href="#">Python</a>
    <a href="#">UI/UX Design</a>
    <a href="#">Web Development</a>
    <a href="#">Marketing</a>
    <a href="#">Finance</a>
</section>

<!-- BANNER -->
<section class="banner">
    <div class="banner-content">
        <h2>Học bất cứ nơi đâu</h2>
        <p>Khám phá hàng trăm khóa học miễn phí & có chứng chỉ cùng SecretCoder</p>
        <button>Bắt đầu học ngay</button>
    </div>
</section>

<!-- COURSE GROUPS -->
<main class="main-content">
    <section class="course-group">
        <h3>Khóa học phổ biến</h3>
        <div class="course-list">
            <div class="course-card">
                <img src="assets/img/python.jpg" alt="Python">
                <h4>Lập trình Python cơ bản</h4>
                <p>Giảng viên: Nguyễn Văn A</p>
                <p>⭐⭐⭐⭐☆ (4.5)</p>
                <span class="price">Miễn phí</span>
            </div>
            <div class="course-card">
                <img src="assets/img/aws.jpg" alt="AWS">
                <h4>Triển khai hệ thống với AWS</h4>
                <p>Giảng viên: Lê Minh B</p>
                <p>⭐⭐⭐⭐⭐ (5.0)</p>
                <span class="price">299.000đ</span>
            </div>
            <div class="course-card">
                <img src="assets/img/excel.jpg" alt="Excel">
                <h4>Excel từ cơ bản đến nâng cao</h4>
                <p>Giảng viên: Trần Thị C</p>
                <p>⭐⭐⭐⭐ (4.0)</p>
                <span class="price">Miễn phí</span>
            </div>
        </div>
    </section>

    <section class="course-group">
        <h3>Khóa học đề xuất cho bạn</h3>
        <div class="course-list">
            <div class="course-card">
                <img src="assets/img/uiux.jpg" alt="UIUX">
                <h4>Thiết kế giao diện với Figma</h4>
                <p>Giảng viên: Nguyễn Hoàng</p>
                <p>⭐⭐⭐⭐☆ (4.3)</p>
                <span class="price">199.000đ</span>
            </div>
            <div class="course-card">
                <img src="assets/img/java.jpg" alt="Java">
                <h4>Học Java Web cơ bản</h4>
                <p>Giảng viên: Phạm Quang</p>
                <p>⭐⭐⭐⭐⭐ (5.0)</p>
                <span class="price">Miễn phí</span>
            </div>
        </div>
    </section>
</main>

<!-- FOOTER -->
<footer class="footer">
    <p>© 2025 SecretCoder E-Learning Platform. All rights reserved.</p>
</footer>

</body>
</html>
