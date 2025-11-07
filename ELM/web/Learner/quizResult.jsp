<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</div>

<!-- Bootstrap JS + Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
