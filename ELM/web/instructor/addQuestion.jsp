<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Add Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/veCQ.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
      <div class="card p-4 shadow">
        <h2 class="fw-bold text-orange">Add Question</h2>
        <form action="AddQuestionServlet" method="post">
          <input type="hidden" name="quizID" value="${param.quizID}">

          <div class="mb-3">
            <label class="form-label">Question</label>
            <input type="text" class="form-control" name="questionText" required>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Answer A</label>
              <input type="text" class="form-control" name="optionA" required>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Answer B</label>
              <input type="text" class="form-control" name="optionB" required>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Answer C</label>
              <input type="text" class="form-control" name="optionC" required>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Answer D</label>
              <input type="text" class="form-control" name="optionD" required>
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label">Correct Answer</label>
            <select class="form-select" name="correctAnswer" required>
              <option value="">-- Select --</option>
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C">C</option>
              <option value="D">D</option>
            </select>
          </div>

          <div class="d-flex justify-content-between">
            <a href="veQuiz.jsp?quizID=${param.quizID}" class="btn btn-secondary">Hủy</a>
            <button type="submit" class="btn btn-orange">Save</button>
          </div>
        </form>
      </div>
    </div>
</body>
</html>
