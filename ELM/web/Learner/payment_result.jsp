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

                    <div class="container py-5">
                        <div class="card shadow-lg border-0 rounded-4 mx-auto" style="max-width: 700px;">
                            <div class="card-body p-5">

                                <!-- Header -->
                                <div class="text-center border-bottom pb-4 mb-4">
                                    <i class="bi bi-check-circle-fill text-success display-3"></i>
                                    <h2 class="text-success mt-3 mb-2 fw-bold">Thanh toán thành công!</h2>
                                    <p class="text-secondary mb-0">Cảm ơn bạn đã đăng ký khóa học tại E-Learning.</p>
                                </div>

                                <!-- Thông tin hóa đơn -->
                                <h5 class="text-secondary mb-3">Thông tin hóa đơn</h5>
                                <table class="table table-sm table-borderless">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Mã giao dịch:</th>
                                            <td class="text-end fw-semibold">${payment.transactionID}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Số tiền:</th>
                                            <td class="text-end fw-semibold">${payment.amount} VNĐ</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Trạng thái:</th>
                                            <td class="text-end"><span class="badge bg-success">Thành công</span></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Thời gian:</th>
                                            <td class="text-end">${payment.paidAt}
                                    </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Phương thức:</th>
                                        <td class="text-end">VNPay</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="text-center">
                                    <p class="text-success fw-medium mb-3">Chúc bạn học tập hiệu quả và đạt kết quả tốt!</p>
                                    <a href="myLearning" class="btn btn-success btn-lg px-4">
                                        <i class="bi bi-book me-2"></i>Đến khóa học của tôi
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mb-4 text-danger">
                        <i class="bi bi-x-circle-fill" style="font-size: 4rem;"></i>
                    </div>
                    <h2 class="text-danger mb-3">Thanh toán thất bại!</h2>
                    <p class="mb-4">Giao dịch không được xử lý. Vui lòng thử lại.</p>
                    <a href="myLearning" class="btn btn-danger px-4">Quay lại danh sách khóa học</a>
                </c:otherwise>
            </c:choose>

        </div>

        <!-- Bootstrap JS + Icons -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </body>
</html>
