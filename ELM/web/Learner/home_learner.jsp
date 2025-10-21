<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) username = "Learner";
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>SecretCoder | Learner</title>
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
                white-space:nowrap;
                text-decoration:none;
                color:#000
            }
            .logo span{
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
            .icon-btn, .header-icons .icon{
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

            /* ===== CATEGORY BAR (giống Udemy) ===== */
            .category-wrap{
                position:sticky;
                top:64px;
                z-index:900; /* bám dưới header */
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
            /* ===== BANNER (nền cam full width, giống home_Guest) ===== */
            .hero{
                background: linear-gradient(90deg, #ff6600, #ff8533);
                color:#fff;
                margin:24px 20px 0;
                border-radius:12px;
                min-height:360px;
                display:grid;
                grid-template-columns: 1fr 460px;
                gap:24px;
                align-items:center;
                overflow:hidden;
            }
            .hero-left{
                padding:28px
            }
            .hero-card{
                background:#fff;
                color:#1c1d1f;
                width: 360px;
                max-width: 100%;
                border-radius:12px;
                padding:24px;
                box-shadow:0 6px 20px rgba(0,0,0,.12);
            }
            .hero-card h2{
                margin:0 0 8px;
                font-size:28px;
                line-height:1.25
            }
            .hero-card p{
                margin:0 0 16px;
                color:#2d2f31
            }
            .hero-card .btn-primary{
                background-color: #ff6600;
                border:0;
                color:#fff;
                font-weight:700;
                border-radius:6px;
                padding:10px 14px;
                cursor:pointer;
                text-decoration: none;
            }
            .hero-right{
                align-self:stretch;
                display:flex;
                align-items:center;
                justify-content:center;
                padding-right:16px;
            }
            .hero-right img{
                max-width:100%;
                height:auto
            }
            /* ===== COURSE SECTION ===== */
            .section{
                max-width:1240px;
                margin:24px auto;
                padding:0 16px
            }
            .section h3{
                font-size:22px;
                margin:0 0 16px
            }
            .grid{
                display:grid;
                gap:16px;
                grid-template-columns:repeat(4,minmax(0,1fr))
            }
            @media (max-width:1100px){
                .grid{
                    grid-template-columns:repeat(3,1fr)
                }
            }
            @media (max-width:820px){
                .grid{
                    grid-template-columns:repeat(2,1fr)
                }
                .banner{
                    grid-template-columns:1fr
                }
            }
            @media (max-width:520px){
                .grid{
                    grid-template-columns:1fr
                }
            }

            .course-card{
                border:1px solid #d1d7dc;
                border-radius:8px;
                overflow:hidden;
                background:#fff;
                transition:transform .1s, box-shadow .15s
            }
            .course-card:hover{
                transform:translateY(-2px);
                box-shadow:0 8px 18px rgba(0,0,0,.08)
            }
            .thumb{
                aspect-ratio:16/9;
                background:#f0f2f5
            }
            .thumb img{
                width:100%;
                height:100%;
                object-fit:cover
            }
            .body{
                padding:12px
            }
            .title{
                font-weight:700;
                font-size:15px;
                margin-bottom:6px
            }
            .meta{
                color:var(--muted);
                font-size:13px
            }
            .price{
                margin-top:8px;
                font-weight:800;
                color:var(--orange)
            }

            /* ===== FOOTER ===== */
            footer{
                border-top:1px solid var(--line);
                padding:18px;
                text-align:center;
                color:#6a6f73;
                margin-top:28px
            }
        </style>
    </head>
    <body>

        <!-- HEADER -->
        <header class="header">
            <a class="logo" href="<%=ctx%>/home_Guest.jsp">
                <span class="s">Secret</span><span class="c">Coder</span>
            </a>

            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search for anything">
                <button title="Search"><i class="bi bi-arrow-return-left"></i></button>
            </div>

            <nav class="nav-links">
                <a href="/ELM/my_cours">My Course</a>
                <a href="/ELM/course">Instructor</a>

            </nav>

            <div class="header-icons">
                <button class="icon-btn" title="Wishlist"><i class="bi bi-heart"></i></button>
                <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
                <button class="icon-btn" title="Notifications"><i class="bi bi-bell"></i></button>
                <a href="<%=ctx%>/myProfile.jsp" class="avatar" title="Profile">U</a>
            </div>
        </header>

        <!-- CATEGORY BAR (không Explore/Teach/Business) -->
        <div class="category-wrap">
            <nav class="category-bar">
                <a href="#">Toán</a>
                <a href="#">Ngữ Văn</a>
                <a href="#">Tiếng Anh</a>
                <a href="#">Vật Lí</a>
                <a href="#">Hóa học</a>
                <a href="#">Sinh học</a>
                <a href="#">Lịch sử</a>
                <a href="#">Địa lý</a>
                <a href="#">GDCD</a>
            </nav>
        </div>
        <!-- BANNER -->
        <section class="hero">
            <div class="hero-left">
                <div class="hero-card">
                    <h2>Master tomorrow's skills today</h2>
                    <p>Power up your AI, career, and life skills with the most up-to-date, expert-led learning.</p>
                    <div>
                        <a href="<%=ctx%>/register.jsp" class="btn-primary">Get started</a>
                    </div>
                </div>
            </div>
            <div class="hero-right">
                <!-- thay ảnh minh hoạ của bạn tại đây -->
                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=1200&auto=format&fit=crop" alt="Hero">
            </div>
        </section>


        <!-- COURSES -->
        <section class="section">
            <h3>Let’s start learning</h3>
            <div class="grid">
                <a class="course-card" href="#">
                    <div class="thumb"><img src="https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1000&auto=format&fit=crop" alt=""></div>
                    <div class="body">
                        <div class="title">Lập trình Python cơ bản</div>
                        <div class="meta">Nguyễn Văn A • 4.5 ⭐ • 20h</div>
                        <div class="price">Miễn phí</div>
                    </div>
                </a>

                <a class="course-card" href="#">
                    <div class="thumb"><img src="https://images.unsplash.com/photo-1518779578993-ec3579fee39f?q=80&w=1000&auto=format&fit=crop" alt=""></div>
                    <div class="body">
                        <div class="title">Triển khai hệ thống với AWS</div>
                        <div class="meta">Lê Minh B • 5.0 ⭐ • 12h</div>
                        <div class="price">299.000đ</div>
                    </div>
                </a>

                <a class="course-card" href="#">
                    <div class="thumb"><img src="https://images.unsplash.com/photo-1551281044-8d8d0d8c9df8?q=80&w=1000&auto=format&fit=crop" alt=""></div>
                    <div class="body">
                        <div class="title">Excel từ cơ bản đến nâng cao</div>
                        <div class="meta">Trần Thị C • 4.0 ⭐ • 9h</div>
                        <div class="price">Miễn phí</div>
                    </div>
                </a>

                <a class="course-card" href="#">
                    <div class="thumb"><img src="https://images.unsplash.com/photo-1553484771-371a605b060b?q=80&w=1000&auto=format&fit=crop" alt=""></div>
                    <div class="body">
                        <div class="title">UI/UX Design với Figma</div>
                        <div class="meta">Phạm D • 4.8 ⭐ • 18h</div>
                        <div class="price">399.000đ</div>
                    </div>
                </a>
            </div>
        </section>

        <footer>© 2025 SecretCoder. All rights reserved.</footer>
    </body>
</html>
