<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>Kết quả tìm kiếm cho "${keyword}"</h2>

<c:if test="${empty courses}">
    <p>Không tìm thấy khóa học nào.</p>
</c:if>

<c:forEach var="course" items="${courses}">
    <div class="course-item">
        <img src="${course.thumbnail}" alt="${course.title}" width="120"/>
        <h3>${course.title}</h3>
        <p>${course.description}</p>
        <p>Price: ${course.price}</p>
    </div>
</c:forEach>
