<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả Quiz</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card border-0 shadow-sm">
                <div class="card-body">

                    <h2 class="card-title text-center text-warning mb-4">Kết quả Quiz</h2>

                    <!-- Số câu đúng -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="fw-bold">Số câu đúng:</span>
                        <span class="fw-bold text-warning">${correctCount} / ${totalQuestions}</span>
                    </div>

                    <!-- Tổng điểm -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="fw-bold">Tổng điểm:</span>
                        <span class="fw-bold text-warning">${totalScore}</span>
                    </div>
                    <!-- Nút quay lại -->
                    <div class="text-center">
                        <a href="/ELM/myLearning" class="btn btn-warning btn-lg">Quay lại khóa học</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
        <div class="materials-pane">
                <h3>Kết quả bài kiểm tra</h3>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-warning">
                            <tr>
                                <th scope="col">Tên bài kiểm tra</th>
                                <th scope="col" class="text-end">Kết quả</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty QuizMap}">
                                <table class="table table-hover table-bordered align-middle mt-3">
                                    <thead class="table-warning">
                                        <tr>
                                            <th class="ps-3" style="width:65%;">Tên bài kiểm tra</th>
                                            <th class="text-end pe-3" style="width:35%;">Kết quả</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="entry" items="${QuizMap}">
                                            <tr>
                                                <td class="ps-3">${entry.key}</td>
                                                <td class="text-end pe-3">
                                                    <c:choose>
                                                        <c:when test="${entry.value != null}">
                                                            <span class="fw-bold text-dark">${entry.value}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="fst-italic text-muted">Chưa làm</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <!-- Dòng trung bình cộng -->
                                        <tr class="table-success fw-bold">
                                            <td class="ps-3">Tổng điểm trung bình</td>
                                            <td class="text-end pe-3">
                                                ${averangeScore} 
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <!-- Dòng tổng hợp Pass/Fail dưới table -->
                                <div class="mt-2 p-2 text-center fw-bold
                                     ${result == 'Pass' ? 'text-success bg-light' : 'text-danger bg-light'} border rounded">
                                    <span class="fw-bold text-dark">Kết quả cuối cùng: ${result}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="fst-italic text-muted mt-3">Không có bài kiểm tra nào</div>
                            </c:otherwise>
                        </c:choose>

                        </tbody>
                    </table>
                </div>
            </div>
<!-- Bootstrap JS + Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
