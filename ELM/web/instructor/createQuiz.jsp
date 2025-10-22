<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Quiz</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/createCQM.css">
</head>
<body>
    <div class="create-quiz-container">
        <h3>Create New Quiz</h3>
        <div class="mb-3">
            <label class="form-label">Quiz Title *</label>
            <input type="text" id="quizTitle" class="form-control" placeholder="Enter quiz title">
        </div>
        <div id="questionsContainer"></div>
        <div class="d-flex justify-content-between mt-4 gap-3">
            <button class="btn btn-cancel" id="cancelBtn">Cancel</button>
            <button class="btn btn-add" id="addQuestionBtn">+ Add Question</button>
            <button class="btn btn-save" id="saveQuizBtn">Create Quiz</button>
        </div>
      </div>
    <script src="${pageContext.request.contextPath}/assets/js/createCQM.js"></script>
</body>
</html>
