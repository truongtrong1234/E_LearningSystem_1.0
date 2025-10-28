<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>My Profile | SecretCoder</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myProfile.css">
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
