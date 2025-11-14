<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String ctx = request.getContextPath();  // /ELM
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng nhập </title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerGuest.css?v3">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            :root{
                --brand: #ff6600;
                --brand-hover: #e55b00;
                --ink:#1c1d1f;
                --muted:#6a6f73;
                --line:#d1d7dc;
                --bg:#fff;
            }
            *{
                box-sizing:border-box
            }
            html,body{
                height:100%
            }
            body{
                margin:0;
                font-family: system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
                color:var(--ink);
                background:#fff;
            }

            /* Header */
            .topbar{
                height:64px;
                display:flex;
                align-items:center;
                justify-content:space-between;
                padding:0 32px;
                border-bottom:1px solid var(--line);
            }
            .logo{
                font-weight:800;
                font-size:24px;
            }
            .logo .s{
                color:var(--brand)
            }
            .logo .c{
                color:#000
            }
            .topbar a{
                color:#2d2f31;
                text-decoration:none;
                font-weight:600;
                margin-left:20px;
            }
            .topbar a:hover{
                color:var(--brand)
            }

            /* Layout */
            .wrap{
                max-width: 1120px;
                margin: 0 auto;
                padding: 32px 24px 56px;
                display: grid;
                grid-template-columns: 1fr 460px;
                gap: 60px;
            }
            @media (max-width: 992px){
                .wrap{
                    grid-template-columns: 1fr;
                }
            }

            /* Left illustration */
            .illu{
                display:flex;
                align-items:center;
                justify-content:center;
            }
            .illu img{
                max-width:100%;
                width:500px;
            }

            /* Form */
            .panel{
                max-width:460px;
                margin:auto;
            }
            .panel h1{
                font-size:26px;
                font-weight:700;
                margin-bottom:16px;
            }

            label{
                font-size:14px;
                font-weight:600;
            }
            .ud-input{
                width:100%;
                height:48px;
                border:1px solid #d1d7dc;
                border-radius:4px;
                padding:0 12px;
                font-size:16px;
                outline:none;
            }
            .ud-input:focus{
                border-color:var(--brand);
                box-shadow:0 0 0 2px rgba(255,102,0,.2);
            }

            .btn-primary{
                width:100%;
                height:48px;
                border:0;
                border-radius:4px;
                background:var(--brand);
                color:#fff;
                font-weight:700;
                cursor:pointer;
            }
            .btn-primary:hover{
                background:var(--brand-hover)
            }

            .hr{
                display:flex;
                align-items:center;
                gap:12px;
                margin:24px 0;
                color:var(--muted);
            }
            .hr::before,.hr::after{
                content:"";
                flex:1;
                height:1px;
                background:var(--line);
            }

            .socials{
                display:flex;
                gap:12px;
            }
            .social-btn{
                flex:1;
                height:44px;
                border:1px solid var(--line);
                border-radius:4px;
                background:#fff;
                display:flex;
                align-items:center;
                justify-content:center;
                gap:10px;
                text-decoration:none;
                color:#2d2f31;
                font-weight:600;
            }
            .social-btn:hover{
                background:#f7f9fa
            }
            .social-btn img{
                width:18px;
                height:18px;
            }

            .error{
                background:#faebea;
                border:1px solid #f3c5c3;
                color:#7a1f10;
                padding:10px 12px;
                border-radius:4px;
                font-size:14px;
                margin:10px 0;
            }

            .foot{
                margin-top:20px;
                font-size:14px;
                color:var(--muted);
            }
            .foot a{
                color:var(--brand);
                text-decoration:none;
                font-weight:700;
            }
            .foot a:hover{
                text-decoration:underline
            }
        </style>
    </head>
    <body>

       <!-- HEADER -->
        <jsp:include page="/components/headerGuest.jsp" />

        <!-- Main -->
        <div class="wrap">

            <!-- Illustration -->
            <div class="illu">
                <img src="https://frontends.udemycdn.com/components/auth/desktop-illustration-x1.webp" alt="Learning illustration">
            </div>

            <!-- Form -->
            <div class="panel">
                <h1>Log in to continue your learning journey</h1>
                <form action="${pageContext.request.contextPath}/login" method="post" autocomplete="off">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" class="ud-input"
                           placeholder="Enter your email" required
                           autocomplete="new-email"
                           value="${emailValue != null ? emailValue : ''}">

                    <div style="height:12px"></div>

                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" class="ud-input"
                           placeholder="Enter your password" required autocomplete="new-password">

                    <div style="margin:10px 0 5px; text-align:right;">

                    </div>

                    <c:if test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:if>

                    <button type="submit" class="btn-primary">Continue</button>
                </form>


                <div class="hr"><span>Other login options</span></div>

                <div class="socials">
                    <a class="social-btn"
                       href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/ELM/loginGoogle&response_type=code&client_id=952221177325-4o9tk9nid7sgplqeejtrv9opbv57ugu3.apps.googleusercontent.com&approval_prompt=force">
                        <img src="https://www.gstatic.com/images/branding/product/1x/gsa_64dp.png" alt="G"> Google
                    </a>
                </div>

                <div class="foot">
                    Don't have an account? <a href="<%=ctx%>/register.jsp">Sign up</a>
                </div>
            </div>
        </div>

    </body>
</html>
