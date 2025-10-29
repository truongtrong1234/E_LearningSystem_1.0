<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Edit Profile | SecretCoder</title>
        <style>
            :root{
                --brand:#ff6600;
                --bg:#f5f6f8;
                --card:#fff;
                --radius:16px;
                --shadow:0 10px 30px rgba(0,0,0,.10);
                --ink:#202124;
            }
            *{
                box-sizing:border-box;
            }
            body{
                margin:0;
                background:var(--bg);
                font-family:"Segoe UI",Arial,sans-serif;
                color:var(--ink);
            }
            .navbar{
                background:#fff;
                padding:10px 20px;
                box-shadow:0 1px 6px rgba(0,0,0,.05);
                display:flex;
                justify-content:space-between;
                align-items:center;
            }
            .logo{
                font-weight:800;
                font-size:22px;
            }
            .logo .s{
                color:var(--brand);
            }
            .logo .c{
                color:#222;
            }
            .sheet-wrap{
                min-height:calc(100vh - 60px);
                display:grid;
                place-items:center;
                padding:24px;
            }
            .sheet{
                width:420px;
                border-radius:var(--radius);
                background:var(--card);
                box-shadow:var(--shadow);
                padding:22px;
            }
            h2{
                text-align:center;
                margin-bottom:20px;
            }
            label{
                display:block;
                margin:10px 0 4px;
                font-weight:600;
            }
            input[type="text"], input[type="file"]{
                width:100%;
                padding:8px 10px;
                border-radius:6px;
                border:1px solid #ccc;
                font-size:14px;
            }
            .btn{
                display:inline-block;
                padding:10px 18px;
                margin-top:16px;
                font-weight:600;
                font-size:14px;
                border-radius:999px;
                text-decoration:none;
                border:1px solid var(--brand);
                background:var(--brand);
                color:#fff;
                cursor:pointer;
            }
            .btn:hover{
                background:#e65a00;
                border-color:#e65a00;
            }
            img.avatar-preview{
                width:80px;
                height:80px;
                border-radius:50%;
                object-fit:cover;
                margin-top:8px;
            }
        </style>
    </head>
    <body>

        <div class="navbar">
            <a class="logo" href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">
                <span class="s">Secret</span><span class="c">Coder</span>
            </a>
            <div>
                <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">Home</a>
            </div>
        </div>

        <div class="sheet-wrap">
            <div class="sheet">
                <h2>Chỉnh sửa hồ sơ</h2>

                <form action="${pageContext.request.contextPath}/editProfile" method="post" enctype="multipart/form-data">

                    <label for="name">Họ và tên:</label>
                    <input type="text" id="name" name="name" value="${account.name}" required>

                    <label for="avatar">Avatar:</label>
                    <input type="file" id="avatar" name="avatar">

                    <c:if test="${not empty account.picture}">
                        <img src="${account.picture}" alt="avatar" class="avatar-preview">
                    </c:if>

                    <button type="submit" class="btn">Lưu thay đổi</button>
                </form>
            </div>
        </div>

    </body>
</html>

