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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/courseDetail.css">

   
</head>

<body>
<div class="container mt-4 mb-5">

    <!-- 🧭 Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/${homePage}">Home</a></li>
        <li class="breadcrumb-item">
    <a href="category?id=${category.cate_id}">${category.cate_name}</a>
</li>

            <li class="breadcrumb-item active" aria-current="page">${course.title}</li>
        </ol>
    </nav>

    <!-- 🏫 Thông tin khóa học -->
    <div class="row mb-4 bg-white p-3 rounded shadow-sm">
        <div class="col-md-4">
            <img src="${course.thumbnail}" alt="${course.title}" class="course-thumbnail">
        </div>

        <div class="col-md-8">
            <h2>${course.title}</h2>
          <p class="mb-1">
    Giảng viên:
    <a href="instructorDetail?id=${course.instructorID}" class="text-decoration-none fw-semibold text-primary">
       ${instructor.name}
    </a>
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
                <button class="btn btn-outline-primary me-2">
                    <i class="fa-solid fa-cart-plus"></i> Thêm giỏ hàng
                </button>

                <button class="btn-heart me-2">
                    <i class="fa-regular fa-heart"></i>
                </button>

                <c:choose>
                    <c:when test="${isEnrolled}">
                        <a href="learnCourse?id=${course.courseID}" class="btn btn-success">Tiếp tục học</a>
                    </c:when>
                    <c:otherwise>
                        <a href="enrollCourse?id=${course.courseID}" class="btn btn-primary">Đăng ký học</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 📘 Mô tả tổng quan -->
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

</body>
</html>

