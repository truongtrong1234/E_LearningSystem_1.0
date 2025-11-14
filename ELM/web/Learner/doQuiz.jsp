<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Làm Quiz</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
         <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
        <style>
            /* Đồng hồ đếm ngược bên phải */
            #countdown {
                position: fixed;
                top: 20px;
                right: 20px;
                font-size: 1.2rem;
                background-color: #f8f9fa;
                padding: 10px 15px;
                border-radius: 8px;
                border: 1px solid #dee2e6;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                z-index: 1000;
            }
        </style>
    </head>
    <body class="bg-light">
<!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />
        
     

        <div class="container py-5">
            <h3 class="text-center mb-4 text-primary fw-bold">${quiz.title}</h3>

            <form action="doQuiz" method="post" id="quizForm">
                <input type="hidden" name="quizID" value="${quizID}"/>

                <c:if test="${not empty questions}">
                    <c:forEach var="q" items="${questions}" varStatus="status">
                        <div class="card mb-4 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Câu ${status.index + 1}: ${q.questionText}</h5>
                                <div class="mt-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="answer_${q.questionID}" value="A" id="q${q.questionID}_A" >
                                        <label class="form-check-label" for="q${q.questionID}_A">${q.optionA}</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="answer_${q.questionID}" value="B" id="q${q.questionID}_B">
                                        <label class="form-check-label" for="q${q.questionID}_B">${q.optionB}</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="answer_${q.questionID}" value="C" id="q${q.questionID}_C">
                                        <label class="form-check-label" for="q${q.questionID}_C">${q.optionC}</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="answer_${q.questionID}" value="D" id="q${q.questionID}_D">
                                        <label class="form-check-label" for="q${q.questionID}_D">${q.optionD}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${empty questions}">
                    <h5 class="card-title">Chưa có Quiz nào</h5>
                </c:if>
                <c:if test="${empty myQuizs}">
                    <div class="text-center">
                        <button type="submit" class="btn btn-success px-4">Nộp bài</button>
                        <a href="/ELM/myLearning" class="btn btn-danger px-4">Hủy làm bài</a>
                    </div>
                </c:if>

            </form>
        </div>

        <c:if test="${myQuizs eq 'quizResult'}">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-7">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body">
                                <h2 class="card-title text-center text-warning mb-4">Kết quả Quiz</h2>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="fw-bold">Số câu đúng:</span>
                                    <span class="fw-bold text-warning">${correctCount} / ${totalQuestions}</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="fw-bold">Tổng điểm:</span>
                                    <span class="fw-bold text-warning">${totalScore}</span>
                                </div>
                                <div class="text-center">
                                    <a href="/ELM/myLearning" class="btn btn-warning btn-lg">Quay lại khóa học</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <script>
            // Thời gian quiz: 15 phút = 900 giây
            let timeLeft = 15 * 60;
            const countdown = document.getElementById("countdown");

            function updateCountdown() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                countdown.textContent = `${minutes.toString().padStart(2,'0')}:${seconds.toString().padStart(2,'0')}`;
                        if (timeLeft <= 0) {
                            // Hết giờ → redirect ngay
                            window.location.href = '/ELM/myLearning';
                        } else {
                            timeLeft--;
                            setTimeout(updateCountdown, 1000);
                        }
                    }

                    updateCountdown();
        </script>

    </body>
</html>
