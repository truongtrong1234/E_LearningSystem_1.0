<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String ctx = request.getContextPath(); // /ELM
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>SecretCoder | Learn Anything</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Icons (cho cart/user nếu cần) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            :root{
                --ud-purple: #5624d0;        /* tím Udemy */
                --ud-purple-dark:#4a1eb8;
                --ink:#1c1d1f;
                --muted:#6a6f73;
                --line:#d1d7dc;
                --bg:#fff;
                --radius:10px;
            }
            *{
                box-sizing:border-box
            }
            html,body{
                margin:0;
                font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif;
                color:var(--ink);
                background:#fff
            }

            /* ======= TOPBAR (no Explore) ======= */
            .topbar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 100;
                height: 64px;
                padding: 0 20px;
                background: #fff;
                border-bottom: 1px solid #e5e7eb;
            }

            /* Logo SecretCoder */
            .logo {
                font-weight: 800;
                font-size: 24px;
                font-family: "Poppins", sans-serif;
            }
            .logo .s {
                color: #ff6600;   /* Secret: cam */
            }
            .logo .c {
                color: #000;      /* Coder: đen */
            }

            /* Search bar */
            .search {
                flex: 1;
                max-width: 720px;  /* điều chỉnh chiều rộng search bar */
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto; /* ĐẨY RA GIỮA */
                background: #f7f9fa;
                border: 1px solid #e5e7eb;
                border-radius: 999px;
                padding: 10px 14px;
            }
            .search i {
                color: #666;
                margin-right: 8px;
            }
            .search input {
                flex: 1;
                border: none;
                background: transparent;
                outline: none;
                font-size: 15px;
            }

            /* Right side (Cart + Login + Signup) */
            .rightbar {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-left: auto;
            }
            .icon-btn {
                display: grid;
                place-items: center;
                width: 36px;
                height: 36px;
                border-radius: 6px;
                border: 1px solid #d1d7dc;
                background: #fff;
                cursor: pointer;
            }
            .icon-btn:hover {
                background: #f7f9fa;
            }
            .btn-outline, .btn-fill{
                display: inline-flex;            /* quan trọng: dùng flex để căn giữa */
                align-items: center;             /* căn giữa theo chiều dọc */
                justify-content: center;         /* căn giữa theo chiều ngang */
                height: 36px;
                padding: 0 16px;                 /* bỏ padding trên/dưới để không lệch */
                line-height: 1;                  /* tránh đẩy chữ lệch lên/xuống */
                border-radius: 6px;
                font-weight: 700;
                font-size: 14px;
                cursor: pointer;
                text-decoration: none;
                vertical-align: middle;          /* hỗ trợ vài trình duyệt */
            }

            /* giữ màu như cũ */
            .btn-outline{
                border: 1px solid #000;
                color: #000;
                background: #fff;
            }
            .btn-outline:hover{
                background:#f9fafb;
            }

            .btn-fill{
                border: 1px solid #ff6600;
                background: #ff6600;
                color: #fff;
            }
            .btn-fill:hover{
                background: #e85500;
                border-color: #e85500;
            }
            /* ======= HERO ======= */
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

            /* ======= COURSE GRID ======= */
            .section{
                padding:28px 20px
            }
            .section h3{
                font-size:24px;
                margin:0 0 14px
            }
            .grid{
                display:grid;
                gap:16px;
                grid-template-columns: repeat(4, minmax(0,1fr));
            }
            @media (max-width: 1100px){
                .grid{
                    grid-template-columns: repeat(3,1fr)
                }
            }
            @media (max-width: 800px){
                .hero{
                    grid-template-columns:1fr;
                    padding-bottom:16px
                }
                .hero-right{
                    order:-1;
                    padding:12px
                }
                .grid{
                    grid-template-columns: repeat(2,1fr)
                }
            }
            @media (max-width: 540px){
                .grid{
                    grid-template-columns:1fr
                }
            }

            .card{
                border:1px solid var(--line);
                border-radius:8px;
                overflow:hidden;
                background:#fff;
                transition:transform .1s ease, box-shadow .15s ease;
                cursor:pointer;
                text-decoration: none;
            }
            .card:hover{
                transform:translateY(-2px);
                box-shadow:0 6px 18px rgba(0,0,0,.12)
            }
            .thumb{
                aspect-ratio:16/9;
                background:#f0f2f5;
                display:grid;
                place-items:center
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
                margin-bottom:6px;
                line-height:1.3
            }
            .meta{
                color:var(--muted);
                font-size:13px
            }
            .price{
                margin-top:8px;
                font-weight:800
            }

            /* ======= FOOTER ======= */
            footer{
                border-top:1px solid var(--line);
                padding:24px 20px;
                color:var(--muted);
                font-size:14px
            }
            footer a{
                color:var(--ud-purple);
                text-decoration:none;
                font-weight:700
            }
            footer a:hover{
                text-decoration:underline
            }
        </style>
    </head>
    <body>

        <!-- TOPBAR -->
        <header class="topbar">
            <div class="logo">
                <span class="s">Secret</span><span class="c">Coder</span>
            </div>

            <div class="search">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search for anything" />
            </div>

            <div class="rightbar">
                <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
                <a class="btn-outline" href="<%=ctx%>/login.jsp">Log in</a>
                <a class="btn-fill" href="<%=ctx%>/register.jsp">Sign up</a>
            </div>
        </header>

    </header>

    <!-- HERO -->
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

    <!-- COURSE GRID -->
    <section class="section">
        <h3>Learn essential career and life skills</h3>
        <div class="grid">

            <!-- Card 1 -->
            <a href="<%=ctx%>/Course/detail?courseId=PY-101" class="card">
                <div class="thumb">
                    <img src="https://vted.vn/upload/tintuc/637206406197278769ckKaEGpLaBp.png" alt="">
                </div>
                <div class="body">
                    <div class="title">10th grade Math course</div>
                    <div class="meta">Eric Nguyen • 4.6 ⭐ • 20h</div>
                    <div class="price">Free</div>
                </div>
            </a>

            <!-- Card 2 -->
            <a href="<%=ctx%>/Course/detail?courseId=AWS-201" class="card">
                <div class="thumb">
                    <img src="https://images.tuyensinh247.com/picture/picture/learning/live_event/0628-1656411707.png" alt="">
                </div>
                <div class="body">
                    <div class="title">12th grade Literature course</div>
                    <div class="meta">Le Minh • 5.0 ⭐ • 12h</div>
                    <div class="price">299.000đ</div>
                </div>
            </a>

            <!-- Card 3 -->
            <a href="<%=ctx%>/Course/detail?courseId=EX-101" class="card">
                <div class="thumb">
                    <img src="https://media.zim.vn/650411eadda8dd49f1d2da99/tieng-anh-12-moi.jpg?w=1200&q=75" alt="">
                </div>
                <div class="body">
                    <div class="title">10th grade English course</div>
                    <div class="meta">Tran Thi C • 4.0 ⭐ • 9h</div>
                    <div class="price">Free</div>
                </div>
            </a>

            <!-- Card 4 -->
            <a href="<%=ctx%>/Course/detail?courseId=UI-UX" class="card">
                <div class="thumb">
                    <img src="https://hanoigrapevine.com/wp-content/uploads/2018/05/lich-su-van-hoa-viet-nam-lespace-683x357.jpg" alt="">
                </div>
                <div class="body">
                    <div class="title">12th grade History course</div>
                    <div class="meta">Pham D • 4.8 ⭐ • 18h</div>
                    <div class="price">399.000đ</div>
                </div>
            </a>

        </div>
    </section>

    <!-- FOOTER -->
    <footer>
        © 2025 SecretCoder. Need help? <a href="<%=ctx%>/contact.jsp">Contact us</a>
    </footer>

</body>
</html>
