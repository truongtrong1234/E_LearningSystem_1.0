// ==================================================== Shared Utilities ====================================================
document.addEventListener("DOMContentLoaded", () => {
  console.log("createCQM.js loaded");

  // ==== Hàm hiển thị lỗi chung ====
  function showError(input, message) {
    clearError(input);
    const error = document.createElement("div");
    error.className = "error-message text-danger mt-1 small";
    error.textContent = message;
    const parent = input.closest(".form-group") || input.closest(".mb-3") || input.parentElement;
    parent.appendChild(error);
    input.classList.add("is-invalid");
  }

  // ==== Hàm xóa lỗi chung ====
  function clearError(input) {
    input.classList.remove("is-invalid");
    const parent = input.closest(".form-group") || input.closest(".mb-3") || input.parentElement;
    const err = parent.querySelector(".error-message");
    if (err) err.remove();
  }

  // ==================================================== COURSE CREATION ====================================================
  const steps = document.querySelectorAll(".step");
  if (steps.length > 0) {
    const stepContents = document.querySelectorAll(".step-content");
    const continueBtn = document.querySelector(".btn-continue");
    const backBtn = document.querySelector(".btn-back");
    let currentStep = 0;

    function showStep(index) {
      steps.forEach((step, i) => {
        step.classList.toggle("active", i === index);
        stepContents[i].style.display = i === index ? "block" : "none";
      });
      backBtn.style.display = index === 0 ? "none" : "inline-block";
      continueBtn.textContent = index === steps.length - 1 ? "Finish" : "Continue";
    }

    function validateStep1() {
      const title = document.getElementById("courseTitle");
      const category = document.getElementById("category");
      const level = document.getElementById("level");
      let valid = true;

      [title, category, level].forEach((input) => clearError(input));
      if (title.value.trim() === "") {
        showError(title, "Course title is required");
        valid = false;
      }
      if (category.value.trim() === "") {
        showError(category, "Category is required");
        valid = false;
      }
      if (level.value.trim() === "") {
        showError(level, "Level is required");
        valid = false;
      }
      return valid;
    }

    function checkChapters() {
      const chapters = document.querySelectorAll(".chapter-item");
      return chapters.length > 0;
    }

    continueBtn?.addEventListener("click", () => {
      if (currentStep === 0 && !validateStep1()) return;
      if (currentStep === 1 && !checkChapters()) {
        currentStep = 3;
        showStep(currentStep);
        return;
      }
      if (currentStep < steps.length - 1) {
        currentStep++;
        showStep(currentStep);
      }
    });

    backBtn?.addEventListener("click", () => {
      if (currentStep > 0) {
        currentStep--;
        showStep(currentStep);
      }
    });

    showStep(currentStep);
  }

  // ==================================================== QUIZ CREATION ====================================================
  const questionsContainer = document.getElementById("questionsContainer");
  if (questionsContainer) {
    const addQuestionBtn = document.getElementById("addQuestionBtn");
    const saveQuizBtn = document.getElementById("saveQuizBtn");
    const cancelBtn = document.getElementById("cancelBtn");

    let questionCount = 0;

    addQuestionBtn?.addEventListener("click", () => {
      questionCount++;
      const questionDiv = document.createElement("div");
      questionDiv.className = "question-item";
      questionDiv.dataset.index = questionCount;

      questionDiv.innerHTML = `
        <div class="d-flex justify-content-between align-items-center mb-2">
          <h5>Question ${questionCount}</h5>
          <button class="btn btn-delete btn-sm btn-outline-danger">Delete</button>
        </div>
        <input type="text" class="form-control mb-2 question-text" placeholder="Enter question text *">

        <div class="options">
          ${["A", "B", "C", "D"].map(letter => `
            <div class="option-input d-flex align-items-center gap-2 mb-1">
              <input type="radio" name="q${questionCount}" value="${letter}">
              <input type="text" class="form-control option-text" placeholder="Option ${letter}">
            </div>
          `).join('')}
        </div>
      `;
      questionsContainer.appendChild(questionDiv);

      questionDiv.querySelector(".btn-delete").addEventListener("click", () => {
        questionDiv.remove();
        updateQuestionNumbers();
      });
    });

    function updateQuestionNumbers() {
      const items = document.querySelectorAll(".question-item");
      items.forEach((q, i) => {
        q.querySelector("h5").textContent = `Question ${i + 1}`;
        q.dataset.index = i + 1;
      });
    }

    saveQuizBtn?.addEventListener("click", () => {
      const quizTitle = document.getElementById("quizTitle");
      clearError(quizTitle);
      if (quizTitle.value.trim() === "") {
        showError(quizTitle, "Quiz title is required");
        return;
      }

      const allQuestions = document.querySelectorAll(".question-item");
      if (allQuestions.length === 0) {
        alert("Please add at least one question before creating the quiz.");
        return;
      }

      let valid = true;
      allQuestions.forEach(q => {
        const questionText = q.querySelector(".question-text");
        clearError(questionText);
        if (questionText.value.trim() === "") {
          showError(questionText, "Question text is required");
          valid = false;
        }
      });

      if (!valid) return;
      alert("Quiz created successfully!");
      window.location.href = "instructorDashboard.jsp?page=quiz";
    });

    cancelBtn?.addEventListener("click", () => {
      if (confirm("Cancel and return to Dashboard?")) {
        window.location.href = "instructorDashboard.jsp?page=quiz";
      }
    });
  }

  // ==================================================== MATERIAL UPLOAD ====================================================
  const materialForm = document.getElementById("uploadMaterialForm");
  if (materialForm) {
    const cancelBtn = document.getElementById("cancelBtn");

    materialForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const title = document.getElementById("materialTitle").value.trim();
      const file = document.getElementById("materialFile").files[0];

      if (!title) {
        alert("Please enter the material title.");
        return;
      }

      if (!file) {
        if (!confirm("No file selected. Upload anyway?")) return;
      }

      alert("Material uploaded successfully!");
      window.location.href = "instructorDashboard.jsp?page=materials";
    });

    cancelBtn?.addEventListener("click", () => {
      if (confirm("Cancel upload and return to Dashboard?")) {
        window.location.href = "instructorDashboard.jsp?page=materials";
      }
    });
  }
});
