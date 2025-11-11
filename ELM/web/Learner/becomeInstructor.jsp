<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Đăng ký trở thành Instructor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/becomeInstructor.css?v3">

       <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v3">
 
</head>
<body>
    
        
                <jsp:include page="/components/headerLearner.jsp" />
<div class="instructor-page">
    <div class="instructor-form-wrapper">
        <h2>Đăng ký trở thành Instructor</h2>

        
            <!-- Hiển thị thông báo nếu có -->
    <c:if test="${not empty msg}">
        <div class="success">${msg}</div>
    </c:if>
        

        <form class="instructor-form" action="${pageContext.request.contextPath}/instructorRequest" method="post" enctype="multipart/form-data">


          <div class="form-group">
    <label>Họ và tên</label>
    <input type="text" name="fullName" placeholder="Nhập họ và tên của bạn" required/>
</div>

<div class="form-group">
    <label>Email</label>
    <input type="email" name="email" placeholder="Nhập email liên hệ" required/>
</div>

<div class="form-group">
    <label>Số điện thoại</label>
    <input type="text" name="phone" placeholder="Nhập số điện thoại liên hệ" required/>
</div>


            <div class="form-group">
                <label>Chức danh nghề nghiệp</label>
                <input type="text" name="title" placeholder="Ví dụ: Senior Java Developer" required/>
            </div>

            <div class="form-group full">
                <label>Kinh nghiệm</label>
                <textarea name="experience" rows="3" placeholder="Ví dụ: 5 năm làm lập trình Java, giảng dạy 2 năm"></textarea>
            </div>

            <div class="form-group full">
                <label>Kỹ năng</label>
                <textarea name="skills" rows="3" placeholder="Ví dụ: Java, Spring Boot, SQL, Agile"></textarea>
            </div>

            <div class="form-group full">
                <label>Giới thiệu bản thân</label>
                <textarea name="bio" rows="4" placeholder="Tóm tắt về bản thân và kinh nghiệm giảng dạy"></textarea>
            </div>

            <div class="form-group full">
                <label>Upload CV (PDF)</label>
                <input type="file" name="cvFile" accept=".pdf"/>
            </div>

            <button type="submit" class="submit-btn">Gửi yêu cầu</button>
        </form>
    </div>
        </div>
                    <jsp:include page="/components/footer.jsp" />

</body>
</html>
