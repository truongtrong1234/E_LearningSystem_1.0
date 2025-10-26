<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) username = "Learner";
    String ctx = request.getContextPath();
%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("/ELM/login");
        return;
    }
    
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>SecretCoder | My Learning</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <style>
            :root{
                --orange:#ff6600;
                --orange-dark:#e85500;
                --line:#eaeaea;
                --ink:#1c1d1f;
                --muted:#6a6f73;
                --bg:#fff;
            }
            *{
                box-sizing:border-box
            }
            html,body{
                margin:0;
                background:#fff;
                color:var(--ink);
                font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif
            }

            /* ===== HEADER ===== */
            header.header{
                position:sticky;
                top:0;
                z-index:1000;
                display:flex;
                align-items:center;
                gap:20px;
                padding:10px 24px;
                background:#fff;
                border-bottom:1px solid var(--line);
            }
            .logo{
                font-weight:800;
                font-size:24px;
                text-decoration:none;
                color:#000
            }
            .logo .s{
                color:var(--orange)
            }
            .logo .c{
                color:#000
            }

            .search-bar{
                flex:1;
                max-width:760px;
                margin:0 auto;
                display:flex;
                align-items:center;
                gap:8px;
                background:#f7f9fa;
                border:1px solid #d1d7dc;
                border-radius:999px;
                padding:10px 14px;
            }
            .search-bar input{
                flex:1;
                border:0;
                outline:none;
                background:transparent;
                font-size:15px
            }
            .search-bar button{
                border:0;
                background:transparent;
                font-size:18px;
                color:#667;
                cursor:pointer
            }

            .nav-links{
                display:flex;
                gap:16px
            }
            .nav-links a{
                color:#333;
                text-decoration:none;
                font-weight:600
            }
            .nav-links a:hover{
                color:var(--orange)
            }

            .header-icons{
                display:flex;
                align-items:center;
                gap:10px;
                margin-left:auto
            }
            .icon-btn{
                width:36px;
                height:36px;
                display:grid;
                place-items:center;
                border:1px solid #d1d7dc;
                border-radius:6px;
                background:#fff;
                cursor:pointer
            }
            .icon-btn:hover{
                background:#f7f9fa
            }
            .avatar{
                width:36px;
                height:36px;
                border-radius:50%;
                display:grid;
                place-items:center;
                background:var(--orange);
                color:#fff;
                font-weight:700
            }

            /* ===== CATEGORY BAR ===== */
            .category-wrap{
                position:sticky;
                top:64px;
                z-index:900;
                background:#fff;
                border-bottom:1px solid var(--line);
            }
            .category-bar{
                max-width:1240px;
                margin:0 auto;
                padding:12px 16px;
                display:flex;
                gap:28px;
                justify-content:center;
                align-items:center;
                overflow-x:auto;
                scrollbar-width:none;
            }
            .category-bar::-webkit-scrollbar{
                display:none
            }
            .category-bar a{
                color:#2d2f31;
                text-decoration:none;
                font-weight:600;
                white-space:nowrap;
                padding:6px 0;
                border-bottom:2px solid transparent;
                transition:color .2s, border-color .2s, transform .2s;
            }
            .category-bar a:hover{
                color:var(--orange);
                border-color:var(--orange);
                transform:translateY(-1px)
            }

            /* ===== MY LEARNING CONTENT ===== */
            main.learning-container{
                max-width:1200px;
                margin:32px auto;
                padding:0 16px;
            }
            main h1{
                font-size:28px;
                margin-bottom:24px;
            }
            .tabs{
                display:flex;
                gap:12px;
                margin-bottom:24px;
            }
            .tab{
                border:1px solid var(--line);
                background:#fff;
                padding:8px 14px;
                border-radius:6px;
                cursor:pointer;
                font-weight:600;
            }
            .tab:hover{
                background:#f7f9fa;
            }
            .course-card{
                display:flex;
                align-items:flex-start;
                gap:16px;
                border:1px solid #d1d7dc;
                border-radius:8px;
                padding:16px;
                margin-bottom:16px;
            }
            .course-card img{
                width:180px;
                height:100px;
                object-fit:cover;
                border-radius:6px;
            }
            .course-info h2{
                margin:0 0 6px;
                font-size:18px
            }
            .course-info p{
                margin:0 0 10px;
                color:#555
            }
            .course-steps{
                display:flex;
                align-items:center;
                gap:8px;
            }
            .steps{
                display:flex;
                gap:6px
            }
            .circle{
                width:20px;
                height:20px;
                border-radius:50%;
                background:#eee;
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:12px;
                font-weight:600;
                color:#666
            }
            .done{
                color:green;
                font-weight:bold
            }
            .btn-review{
                background:var(--orange);
                color:#fff;
                padding:8px 12px;
                text-decoration:none;
                border-radius:6px;
                font-weight:600;
            }
            .btn-review:hover{
                background:var(--orange-dark)
            }

            footer{
                border-top:1px solid var(--line);
                padding:18px;
                text-align:center;
                color:#6a6f73;
                margin-top:28px
            }
            .course, .chapter {
                cursor: pointer;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .course-title {
                font-size: 20px;
                color: #333;
            }
            .course-info, .course-desc {
                margin-left: 20px;
                font-style: italic;
                font-weight: normal;
            }
            .chapters, .lessons {
                margin-left: 20px;
                display: none;
            }
            .lesson {
                margin-left: 20px;
                font-weight: normal;
                margin-bottom: 3px;
            }
            .course-card {
    display: flex;
    flex-direction: column; /* nếu muốn thumbnail trên info, hoặc row nếu muốn ngang */
    border: 1px solid #ddd;
    border-radius: 10px;
    overflow: hidden;
    margin: 15px 0;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    transition: transform 0.2s;
    cursor: pointer;
}

.course-card:hover {
    transform: translateY(-3px);
}

.course-card iframe {
    width: 100%;
    height: 180px; /* tùy chỉnh chiều cao */
    border: none;
}

.course-info {
    padding: 15px;
    display: flex;
    flex-direction: column;
    gap: 10px; /* khoảng cách giữa các dòng */
}

.course-info h2 {
    margin: 0;
    font-size: 1.5em;
    color: #333;
}

.course-info .details {
    display: flex;
    justify-content: space-between;
    font-style: italic;
    color: #555;
    font-size: 0.9em;
    flex-wrap: wrap; /* nếu quá dài thì xuống dòng */
}

.course-info p {
    margin: 0;
    color: #666;
    line-height: 1.4em;
}

.course-info .class-info {
    font-style: italic;
    color: #777;
    font-size: 0.85em;
}

        </style>
    </head>
    <body>
       <script>
function toggleChapters(courseId) {
    const div = document.getElementById(`chapters-${courseId}`);
    if (div.style.display === "none") {
        fetch(`chapters?courseId=${courseId}`)
            .then(res => res.json())
            .then(data => {
                let html = "<ul style='list-style:none; padding-left:0;'>";
                data.forEach(ch => {
                    html += `<li style="background:#eaeaea; padding:8px 12px; border-radius:4px; margin-bottom:6px;">
                                <strong>${ch.title}</strong>
                             </li>`;
                });
                html += "</ul>";
                div.innerHTML = html;
                div.style.display = "block";
            })
            .catch(err => {
                div.innerHTML = "<p style='color:red;'>Không tải được chương.</p>";
                div.style.display = "block";
            });
    } else {
        div.style.display = "none";
    }
}
</script>
        <!-- HEADER -->
        <header class="header">
            <a class="logo" href="<%=ctx%>/home_learner.jsp">
                <span class="s">Secret</span><span class="c">Coder</span>
            </a>

            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search for anything">
                <button title="Search"><i class="bi bi-arrow-return-left"></i></button>
            </div>

            <nav class="nav-links">
                <a href="<%=ctx%>/course">Instructor</a>
            </nav>

            <div class="header-icons">
                <button class="icon-btn" title="Wishlist"><i class="bi bi-heart"></i></button>
                <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
                <button class="icon-btn" title="Notifications"><i class="bi bi-bell"></i></button>
                <a href="<%=ctx%>/myProfile.jsp" class="avatar" title="Profile">U</a>
            </div>
        </header>



      <main class="learning-container">
    <h1>Chapter</h1>
    <!-- Danh sách course -->
    <c:forEach var="course" items="${chapterList}">
        <div class="course-card" onclick="toggleChapters()" style="cursor:pointer;">
            <a href="myLesson?ChapterID=${course.chapterID}">
            <div class="course-info">
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <h2>${course.title}</h2>
                </div>
            </div>
            </a>
        </div>
    </c:forEach>
</main>

        <footer>© 2025 SecretCoder. All rights reserved.</footer>
    </body>
</html>
