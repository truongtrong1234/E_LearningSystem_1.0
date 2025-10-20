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
    <div class="page-wrap">
      <div class="create-cqm-container" data-page="quiz">
        <h2 class="cqm-title">Create New Quiz</h2>

        <form action="createQuizServlet" method="post" id="createForm">
          <div class="cqm-grid">
            <div class="cqm-card">
              <!-- Quiz title -->
              <label class="cqm-label">Quiz Title <span class="required">*</span></label>
              <input type="text" name="quizTitle" class="cqm-input" placeholder="Enter quiz name..." required>

              <!-- Related course -->
              <label class="cqm-label">Related Course</label>
              <select name="courseId" class="cqm-select">
                <option value="">Select Course</option>
                <!-- load DB -->
              </select>

              <!-- Description -->
              <label class="cqm-label">Description</label>
              <textarea name="quizDesc" class="cqm-textarea" placeholder="Short description for this quiz..."></textarea>

              <hr style="margin:20px 0; border:1px dashed #eee;">

              <!-- Question section -->
              <h3 style="font-size:20px; margin-bottom:10px;">Questions</h3>
              <div id="questionContainer"></div>
              <button type="button" class="btn-primary cqm-btn small-btn" id="addQuestionBtn">➕ Add Question</button>

              <div class="cqm-actions">
                <p class="helper-text">You can add multiple question types and edit them dynamically.</p>
                <div class="action-buttons">
                  <button type="submit" class="btn-primary cqm-btn">Save Quiz</button>
                  <button type="submit" class="btn-secondary cqm-btn" onclick="window.location.href='course'">Cancel</button>
                </div>
              </div>
            </div>

            <!-- Tips -->
            <aside class="cqm-aside">
              <h4 style="margin-bottom:10px;">Quiz Tips</h4>
              <ul style="font-size:14px; color:#555; line-height:1.6;">
                <li>Mix different question types for better engagement.</li>
                <li>Provide clear answer options for MCQ or checkbox types.</li>
                <li>Short Answer questions allow open-ended responses.</li>
              </ul>
            </aside>
          </div>
        </form>
      </div>
    </div>

    <script src="../assets/js/createCQM.js"></script>
</body>
</html>
