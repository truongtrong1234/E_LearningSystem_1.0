<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Yêu cầu Instructor thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/requestSuccess.css?v3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v3">

</head>
<body>
     <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />

    <div class="container">
        <h2> Yêu cầu Instructor đã được gửi thành công!</h2>

        <div class="field">
            <label>Họ và tên:</label>
            <span>${request.fullName}</span>
        </div>

        <div class="field">
            <label>Email:</label>
            <span>${request.email}</span>
        </div>

        <div class="field">
            <label>Số điện thoại:</label>
            <span>${request.phone}</span>
        </div>

        <div class="field">
            <label>Chức danh nghề nghiệp:</label>
            <span>${request.title}</span>
        </div>

        <div class="field">
            <label>Kinh nghiệm:</label>
            <span>${request.experience}</span>
        </div>

        <div class="field">
            <label>Kỹ năng:</label>
            <span>${request.skills}</span>
        </div>

        <div class="field">
            <label>Giới thiệu bản thân:</label>
            <span>${request.bio}</span>
        </div>

        <div class="field">
            <label>CV:</label>
            <c:if test="${not empty request.cvFile}">
                <a href="viewMaterial?url=${request.cvFile}" target="_blank"> Xem CV</a>
            </c:if>
            <c:if test="${empty request.cvFile}">
                <span>Không có CV</span>
            </c:if>
        </div>

        <a href="/ELM/Learner/homeLearnerCourse" class="btn"> Về trang chủ</a>
    </div>
        
            <jsp:include page="/components/footer.jsp" />
</body>
</html>
