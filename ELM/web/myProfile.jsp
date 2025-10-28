<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>My Profile | SecretCoder</title>
        <style>
            :root{
                --brand:#ff6600;
                --ink:#202124;
                --sub:#5f6368;
                --bg:#f5f6f8;
                --card:#fff;
                --radius:16px;
                --shadow:0 10px 30px rgba(0,0,0,.10);
            }
            *{
                box-sizing:border-box
            }
            html,body{
                margin:0;
                background:var(--bg);
                font-family:"Segoe UI",Arial,sans-serif;
                color:var(--ink)
            }

            .navbar{
                background:#fff;
                padding:10px 20px;
                box-shadow:0 1px 6px rgba(0,0,0,.05);
                display:flex;
                align-items:center;
                justify-content:space-between;
            }
            .logo{
                font-weight:800;
                font-size:22px
            }
            .logo .s{
                color:var(--brand)
            }
            .logo .c{
                color:#222
            }
            .navbar a{
                color:#333;
                text-decoration:none;
                margin-left:16px
            }
            .navbar a:hover{
                color:var(--brand)
            }

            .sheet-wrap{
                min-height:calc(100vh - 60px);
                display:grid;
                place-items:center;
                padding:24px
            }
            .sheet{
                width: 420px;
                border-radius: var(--radius);
                background: linear-gradient(#eaf1ff,#eaf1ff) padding-box,
                    linear-gradient(#cdd8ff,#cdd8ff) border-box;
                border: 1px solid #cdd8ff;
                box-shadow: var(--shadow);
                padding: 22px 22px 26px;
            }
            .topline{
                text-align:center;
                color:#3c4043;
                font-size:14px;
                margin-bottom:10px;
                word-break:break-all
            }

            .avatar-wrap{
                display:flex;
                justify-content:center;
                position:relative;
                margin:6px 0 8px
            }
            .avatar{
                width:92px;
                height:92px;
                border-radius:50%;
                background:#dfe7ff;
                color:#1a237e;
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:40px;
                font-weight:800;
                border:4px solid #fff;
                box-shadow:0 2px 8px rgba(0,0,0,.12);
                overflow:hidden;
            }
            .avatar img{
                width:100%;
                height:100%;
                object-fit:cover;
                display:block
            }
            .camera-badge{
                position:absolute;
                right:135px;
                bottom:0;
                transform:translate(50%,-10%);
                width:26px;
                height:26px;
                border-radius:50%;
                background:#fff;
                border:1px solid #e0e0e0;
                display:grid;
                place-items:center;
                font-size:14px;
            }

            .hello{
                text-align:center;
                margin:10px 0 6px;
                font-size:24px;
                font-weight:700
            }

            .actions{
                display:flex;
                justify-content:center;
                gap:10px;
                margin:14px 0 16px
            }
            .btn{
                border-radius:999px;
                padding:9px 16px;
                font-weight:600;
                font-size:14px;
                cursor:pointer;
                border:1px solid #dadce0;
                background:#fff;
                color:#1a73e8;
                text-decoration:none;
                display:inline-block;
            }
            .btn:hover{
                background:#f8faff
            }
            .btn.primary{
                background: var(--brand);        /* màu cam chính */
                color: #fff;
                border: 1px solid var(--brand);
                box-shadow: 0 2px 5px rgba(255,102,0,0.3);
                transition: 0.2s ease-in-out;
            }
            .btn.primary:hover{
                background: #e65a00;             /* cam đậm hơn khi hover */
                border-color: #e65a00;
                box-shadow: 0 3px 8px rgba(255,102,0,0.4);
            }

            .card{
                background:var(--card);
                border-radius:12px;
                padding:16px 18px;
                margin-top:12px;
                box-shadow:0 2px 10px rgba(0,0,0,.06)
            }
            .row{
                margin:10px 0;
                line-height:1.7
            }
            .label{
                font-weight:700;
                color:#202124
            }
            .muted{
                color:var(--sub)
            }

            /* 🔵 Style chung cho cả “Khóa học chính” và “Đang học” */
            .course-link{
                display:inline-block;
                background:#eef2ff;
                color:#1a237e;
                border:1px solid #dce3ff;
                border-radius:999px;
                padding:6px 12px;
                text-decoration:none;
                font-weight:600;
                font-size:13px;
                transition:transform .08s ease, box-shadow .12s ease, background .12s ease;
                white-space:nowrap;
            }
            .course-link:hover{
                transform:translateY(-1px);
                box-shadow:0 2px 8px rgba(26,115,232,.18);
                background:#e2e7ff;
            }

            .chips{
                display:flex;
                flex-wrap:wrap;
                gap:8px;
                margin-top:8px
            }

            .back{
                display:inline-block;
                margin-top:16px;
                color:var(--brand);
                text-decoration:none;
                font-weight:700
            }
            .back:hover{
                opacity:.85
            }

            @media (max-width:480px){
                .sheet{
                    width:100%
                }
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

        <div class="topline">${account.email}</div>

        <div class="avatar-wrap">
            <div class="avatar">
                <c:choose>
                    <c:when test="${not empty account.picture}">
                        <img src="${account.picture}" alt="avatar"/>
                    </c:when>
                    <c:otherwise>
                        ${fn:substring(account.name,0,1).toUpperCase()}
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="camera-badge">📷</div>
        </div>

        <div class="hello">Chào ${fn:split(account.name,' ')[fn:length(fn:split(account.name,' '))-1]},</div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/edit_profile.jsp" class="btn">Quản lý hồ sơ</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn primary">Đăng xuất</a>
        </div>

        <div class="card">
            <div class="row"><span class="label">Họ tên: </span><span class="muted">${account.name}</span></div>
            <div class="row"><span class="label">Email: </span><span class="muted">${account.email}</span></div>

            <div class="row">
                <span class="label">Khóa học chính: </span>
                <a class="course-link" href="${pageContext.request.contextPath}/Course/detail?courseId=${courseId}">${course}</a>
            </div>

            <div class="row">
                <span class="label">Đang học:</span>
                <div class="chips">
                    <a class="course-link" href="${pageContext.request.contextPath}/Course/detail?courseId=${learningId}">${learning}</a>
                </div>
            </div>

            <a class="back" href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">← Back to Home</a>
        </div>

    </div>
</div>

</body>

</html>
