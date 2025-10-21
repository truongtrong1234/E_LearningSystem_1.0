<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>My Learning | SecretCoder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mylearning.css">
</head>
<body>

<!-- ===== HEADER ===== -->
<header class="header">
    <div class="logo">
        <span class="orange">Secret</span><span class="dark">Coder</span>
    </div>
    <div class="search-bar">
        <input type="text" placeholder="Tìm khóa học, chủ đề, kỹ năng...">
        <button>🔍</button>
    </div>
    <nav class="nav-links">
        <a href="#">My Course</a>
        <a href="#">Instructor</a>
        <span class="bell">🔔</span>
        <div class="profile">U</div>
    </nav>
</header>

<!-- ===== SUBJECT BAR ===== -->
<div class="subject-bar">
    <a href="#">Toán</a>
    <a href="#">Ngữ Văn</a>
    <a href="#">Tiếng Anh</a>
    <a href="#">Vật Lí</a>
    <a href="#">Hóa học</a>
    <a href="#">Sinh học</a>
    <a href="#">Lịch sử</a>
    <a href="#">Địa lý</a>
    <a href="#">GDCD</a>
</div>

<!-- ===== MAIN LEARNING SECTION ===== -->
<main class="learning-container">
    <h1>My FPTU Fall 2025 Learning</h1>

    <div class="tabs">
        <button class="tab">In Progress</button>
        <button class="tab">Saved</button>
        <button class="tab">Completed</button>
    </div>

    <!-- Course 1 -->
    <div class="course-card">
        <img src="images/ux-course.jpg" alt="UX Course" class="course-image">
        <div class="course-info">
            <h2>User Experience Research and Design</h2>
            <p>Integrate UX Research and UX Design to create great products through understanding user needs, rapidly generating prototypes, and evaluating design concepts.</p>
            <div class="course-steps">
                <span>6 courses</span>
                <div class="steps">
                    <div class="circle">1</div>
                    <div class="circle">2</div>
                    <div class="circle">3</div>
                    <div class="circle">4</div>
                    <div class="circle">5</div>
                    <div class="circle">6</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Course 2 -->
    <div class="course-card completed">
        <img src="images/ux-capstone.jpg" alt="UX Capstone" class="course-image">
        <div class="course-info">
            <h2>UX (User Experience) Capstone</h2>
            <p><span class="done">✔</span> Completed on September 21, 2025</p>
            <a href="#" class="btn-review">Review</a>
        </div>
    </div>

</main>

</body>
</html>
