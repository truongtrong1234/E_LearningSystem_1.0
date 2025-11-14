<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    %>

    <head>
        <title>My Profile </title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myProfile.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
        <style>
            /* --- Tổng thể --- */
            body {
                background: #f5f7fb;
                font-family: 'Inter', sans-serif;
            }

            .sheet-wrap {
                display: flex;
                justify-content: center;
                margin-top: 40px;
                padding: 20px;
            }

            .sheet {
                background: #ffffff;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.08);
                width: 80%;
                max-width: 1000px;
                padding: 40px 50px;
            }

            .avatar-wrap {
                display: flex;
                justify-content: center;
                position: relative;
                margin-bottom: 16px;
            }

            .avatar img {
                width: 110px;
                height: 110px;
                border-radius: 50%;
                border: 4px solid #fff;
                box-shadow: 0 3px 10px rgba(0,0,0,0.15);
            }

            .hello {
                text-align: center;
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 10px;
                color: #1a1a1a;
            }

            .actions {
                text-align: center;
                margin-bottom: 30px;
            }

            .btn {
                display: inline-block;
                padding: 10px 18px;
                border-radius: 25px;
                background: #fff;
                border: 1px solid #ccc;
                color: #333;
                margin-right: 10px;
                text-decoration: none;
                transition: 0.3s;
            }

            .btn.primary {
                background: #ff6600;
                color: #fff;
                border: none;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 3px 6px rgba(0,0,0,0.15);
            }

            /* --- Khung thông tin chia 2 cột --- */
            .profile-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
                margin-top: 30px;
            }

            .info-box {
                background: #f9fbff;
                border: 1px solid #e0e4f1;
                border-radius: 14px;
                padding: 24px 28px;
            }

            .info-box h3 {
                font-size: 18px;
                font-weight: 600;
                color: #003366;
                margin-bottom: 16px;
                border-bottom: 2px solid #e2e6f0;
                padding-bottom: 6px;
            }

            .info-item {
                margin-bottom: 10px;
            }

            .info-item .label {
                font-weight: 600;
                color: #1a3e72;
            }

            .info-item .muted {
                color: #333;
                font-size: 15px;
                display: block;
                margin-top: 4px;
            }

            ul.course-list {
                list-style: disc;
                margin-left: 22px;
                color: #333;
                line-height: 1.6;
            }

            .back {
                display: inline-block;
                margin-top: 30px;
                color: #ff6600;
                text-decoration: none;
                font-weight: 600;
            }

            @media (max-width: 768px) {
                .profile-container {
                    grid-template-columns: 1fr;
                }
                .sheet {
                    width: 95%;
                    padding: 20px;
                }
            }
        </style>
    </head>

    <body>
        <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />

        <div class="sheet-wrap">
            <div class="sheet">

                <div class="avatar-wrap">
                    <div class="avatar">
                        <c:choose>
                            <c:when test="${not empty account.picture}">
                                <img src="${account.picture}" alt="avatar"/>
                            </c:when>
                            <c:otherwise>
                                <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="avatar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="hello">Chào ${fn:split(account.name,' ')[fn:length(fn:split(account.name,' '))-1]},</div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/edit_profile.jsp" class="btn">Quản lý hồ sơ</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn primary">Đăng xuất</a>
                </div>

                <!-- ======= CHIA 2 KHUNG RÕ RÀNG ======= -->
                <div class="profile-container">
                    <!-- Cột 1 -->
                    <div class="info-box">
                        <h3>Thông tin cá nhân</h3>
                        <div class="info-item"><span class="label">Họ tên:</span> <span class="muted">${account.name}</span></div>
                        <div class="info-item"><span class="label">Email:</span> <span class="muted">${account.email}</span></div>
                        <div class="info-item"><span class="label">Giới tính:</span> <span class="muted">${account.gender}</span></div>
                        <div class="info-item"><span class="label">Ngày sinh:</span> <span class="muted">${account.dateOfBirth}</span></div>
                        <div class="info-item"><span class="label">Số điện thoại:</span> <span class="muted">${account.phone}</span></div>
                        <div class="info-item"><span class="label">Địa chỉ:</span> <span class="muted">${account.address}</span></div>
                        <div class="info-item"><span class="label">Nơi công tác:</span> <span class="muted">${account.workplace}</span></div>
                    </div>

                    <!-- Cột 2 -->
                    <div class="info-box">
                        <h3>Khóa học</h3>
                        <div class="info-item">
                            <span class="label">Khóa học đã tạo:</span>
                            <c:choose>
                                <c:when test="${empty createdCourses}">
                                    <span class="muted">Chưa tạo khóa học nào.</span>
                                </c:when>
                                <c:otherwise>
                                    <ul class="course-list">
                                        <c:forEach var="course" items="${createdCourses}">
                                            <li>${course.title}</li>
                                            </c:forEach>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="info-item" style="margin-top: 15px;">
                            <span class="label">Khóa học đang học:</span>
                            <c:choose>
                                <c:when test="${empty enrolledCourses}">
                                    <span class="muted">Chưa tham gia khóa học nào.</span>
                                </c:when>
                                <c:otherwise>
                                    <ul class="course-list">
                                        <c:forEach var="course" items="${enrolledCourses}">
                                            <li>${course.title}</li>
                                            </c:forEach>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <a class="back" href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">← Back to Home</a>
            </div>
        </div>
    </body>
</html>
