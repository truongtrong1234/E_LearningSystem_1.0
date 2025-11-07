<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Làm Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h3 class="text-center mb-4 text-primary fw-bold">${quiz.title}</h3>

    <form action="doQuiz" method="post">
        <input type="hidden" name="quizID" value="${quizID}"/>

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

        <div class="text-center">
            <button type="submit" class="btn btn-success px-4">Nộp bài
        </div></button><a href="/ELM/myLearning"><button type="submit" class="btn btn-success px-4">Hủy làm bài</button></a>
    </form>
</div>
</body>
</html>
