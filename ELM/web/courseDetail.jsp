<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${course.title} | E-learning</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/courseDetail.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerGuest.css?v=3">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v=3">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">

</head>

<body>
    <c:choose>
        <%-- Nếu người dùng đã đăng nhập --%>
        <c:when test="${not empty sessionScope.account}">
            <jsp:include page="components/headerLearner.jsp"/>
        </c:when>

        <%-- Nếu là khách chưa đăng nhập --%>
        <c:otherwise>
            <jsp:include page="components/headerGuest.jsp"/>
        </c:otherwise>
    </c:choose>

<div class="container mt-4 mb-5">


    <!--  Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
<li class="breadcrumb-item">
    <c:choose>
        
        <c:when test="${not empty sessionScope.account}">
            <a href="${pageContext.request.contextPath}/Learner/homeLearnerCourse">Home</a>
        </c:when>
        
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/home_Guest">Home</a>
        </c:otherwise>
    </c:choose>
</li>
        <li class="breadcrumb-item">
    <a href="searchCourse?cats=${category.cate_id}">${category.cate_name}</a>
</li>

            <li class="breadcrumb-item active" aria-current="page">${course.title}</li>
        </ol>
    </nav>

    <!--  Thông tin khóa học -->
    <div class="row mb-4 bg-white p-3 rounded shadow-sm">
        <div class="col-md-4">
            <img src="${course.thumbnail}" alt="${course.title}" class="course-thumbnail">
        </div>

        <div class="col-md-8">
            <h2>${course.title}</h2>
          <p class="mb-1">
    Giảng viên:
       ${instructor.name}
</p>

           
            <hr>

            <div class="course-price">
                <c:choose>
                    <c:when test="${course.price == 0}">
                        Miễn phí
                    </c:when>
                    <c:otherwise>
                        ${course.price} đ
                    </c:otherwise>
                </c:choose>
            </div>

   <div class="mt-3">
    <c:choose>
        
        <c:when test="${isEnrolled}">
            <a href="myContent?CourseID=${course.courseID}" class="btn btn-success">
                <i class="fa-solid fa-play"></i> Tiếp tục học
            </a>
        </c:when>

        
        <c:otherwise>
            <c:choose>
            <c:when test="${ empty sessionScope.account}">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Đăng ký học</a>
            </c:when>
            <c:otherwise>       
            <form action="vnpay" method="post" style="display:inline;">
                <input type="hidden" name="courseID" value="${course.courseID}">
                <input type="hidden" name="amount" value="${course.price}">
                <button type="submit" class="btn btn-primary">
                     Đăng ký học
                </button>
            </form>
                </c:otherwise>
                    </c:choose>  
        </c:otherwise>
    </c:choose>
</div>

        </div>
    </div>

    <!--  Mô tả tổng quan -->
    <div class="bg-white p-4 rounded shadow-sm mb-4">
        

        <div class="mb-3">
            <h6 class="fw-bold">Mô tả khóa học</h6>
            <p>${course.description}</p>
        </div>

       
    </div>

<!-- 📖 Mục lục khóa học -->
<div class="bg-white p-4 rounded shadow-sm">
    <h4><i class="fa-solid fa-list-ul me-2"></i>Mục lục khóa học</h4>

    <c:forEach var="ch" items="${chapters}" varStatus="loop">
        <div class="chapter-title">${loop.index + 1}. ${ch.title}</div>
        <ul class="list-unstyled">
            <c:forEach var="lesson" items="${lessons[ch.chapterID]}">
                
                <li class="lesson-item">
                    <i class="fa-regular fa-circle-play me-2"></i> ${lesson.title} 
                </li>
            </c:forEach>
        </ul>
    </c:forEach>
</div>


</div>
        <!-- FOOTER -->
        <jsp:include page="components/footer.jsp"/>

</body>
</html>

