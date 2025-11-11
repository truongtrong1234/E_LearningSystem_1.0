<%-- Sign up (Udemy-like) for SecretCoder --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String ctx = request.getContextPath();  // /ELM
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Sign up | SecretCoder</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            :root{
                --brand:#ff6600;           /* cam SecretCoder */
                --brand-hover:#e55b00;
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
                font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif;
                color:var(--ink);
                background:#fff;
            }

            /* Top bar */
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
                max-width:1120px;
                margin:0 auto;
                padding:32px 24px 56px;
                display:grid;
                grid-template-columns:1fr 460px;
                gap:60px;
            }
            @media (max-width:992px){
                .wrap{
                    grid-template-columns:1fr;
                }
            }

            .illu{
                display:flex;
                align-items:center;
                justify-content:center;
            }
            .illu img{
                max-width:100%;
                width:500px;
            }

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
                background:#fff;
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
        <script>
            function validateForm() {
                const pw = document.getElementById("password").value.trim();
                const cf = document.getElementById("confirm").value.trim();
                if (pw !== cf) {
                    alert("Mật khẩu xác nhận không khớp!");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>

        <!-- Top nav -->
        <div class="topbar">
            <a class="logo" href="<%= ctx %>/home_Guest">
                <span class="s">Secret</span><span class="c">Coder</span>
            </a>
            <div>
                <a href="<%=ctx%>/login.jsp">Log in</a>
            </div>
        </div>

        <!-- Main -->
        <div class="wrap">

            <!-- Illustration -->
            <div class="illu">
                <img src="https://frontends.udemycdn.com/components/auth/desktop-illustration-x1.webp" alt="Learning illustration">
            </div>

            <!-- Form -->
            <div class="panel">
                <h1>Create your SecretCoder account</h1>

                <form action="<%=ctx%>/register" method="post" onsubmit="return validateForm();">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" class="ud-input" required />

                    <div style="height:12px"></div>

                    <label for="fullname">Full name</label>
                    <input id="fullname" name="fullname" type="text" class="ud-input" required />

                    <div style="height:12px"></div>

                    <label for="workplace">Nơi công tác</label>
                    <input id="workplace" name="workplace" type="text" class="ud-input" placeholder="VD: Đại học Bách Khoa Hà Nội" required />

                    <div style="height:12px"></div>

                    <label for="phone">Số điện thoại</label>
                    <input id="phone" name="phone" type="tel" class="ud-input" placeholder="VD: 0901234567" pattern="[0-9]{9,11}" required />

                    <div style="height:12px"></div>

                    <label for="dateofbirth">Ngày sinh</label>
                    <input id="dateofBirth" name="dateofBirth" type="date" class="ud-input" required />

                    <div style="height:12px"></div>

                    <label for="gender">Giới tính</label>
                    <select id="gender" name="gender" class="ud-input" required>
                        <option value="">-- Chọn giới tính --</option>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>

                    <div style="height:12px"></div>

                    <label for="address">Địa chỉ</label>
                    <input id="address" name="address" type="text" class="ud-input" placeholder="VD: 123 Nguyễn Trãi, Hà Nội" required />

                    <div style="height:12px"></div>

                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" class="ud-input" required />

                    <div style="height:12px"></div>

                    <label for="confirm">Confirm password</label>
                    <input id="confirm" name="confirm" type="password" class="ud-input" required />

                    <!-- JSTL error -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error">${errorMessage}</div>
                    </c:if>

                    <div style="height:14px"></div>
                    <button type="submit" class="btn-primary">Sign up</button>
                </form>

                <div class="hr"><span>Or continue with</span></div>

                <div class="socials">
                    <a class="social-btn"
                       href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/ELM/loginGoogle&response_type=code&client_id=952221177325-4o9tk9nid7sgplqeejtrv9opbv57ugu3.apps.googleusercontent.com&approval_prompt=force">
                        <img src="https://www.gstatic.com/images/branding/product/1x/gsa_64dp.png" alt="G"> Google
                    </a>
                </div>

                <div class="foot">
                    Already have an account? <a href="<%=ctx%>/login.jsp">Log in</a>
                </div>
            </div>
        </div>
    </body>
</html>
