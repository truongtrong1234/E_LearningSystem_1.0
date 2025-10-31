<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả đăng ký khóa học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">

    <div class="card shadow-lg p-5 text-center" style="max-width: 500px;">
        <c:choose>
            <c:when test="${status == 'success'}">
                <div class="mb-4 text-success">
                    <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                </div>
                <h2 class="text-success mb-3">Thanh toán thành công!</h2>
                <p class="mb-4">Cảm ơn bạn! Bạn đã đăng ký khóa học thành công.</p>
                <a href="myLearning" class="btn btn-success px-4">Đến khóa học của tôi</a>
            </c:when>
            <c:otherwise>
                <div class="mb-4 text-danger">
                    <i class="bi bi-x-circle-fill" style="font-size: 4rem;"></i>
                </div>
                <h2 class="text-danger mb-3">Thanh toán thất bại!</h2>
                <p class="mb-4">Giao dịch không được xử lý. Vui lòng thử lại.</p>
                <a href="courseList" class="btn btn-danger px-4">Quay lại danh sách khóa học</a>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Bootstrap JS + Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>
