// ==================================================== Courses Creation ====================================================
document.addEventListener("DOMContentLoaded", () => {
  const steps = document.querySelectorAll(".step");
  const stepContents = document.querySelectorAll(".step-content");
  const continueBtn = document.querySelector(".btn-continue");
  const backBtn = document.querySelector(".btn-back");

  let currentStep = 0;

  // ==== Hàm hiển thị step ====
  function showStep(index) {
    steps.forEach((step, i) => {
      step.classList.toggle("active", i === index);
      stepContents[i].style.display = i === index ? "block" : "none";
    });

    backBtn.style.display = index === 0 ? "none" : "inline-block";
    continueBtn.textContent = index === steps.length - 1 ? "Finish" : "Continue";
  }

  // ==== Hàm hiển thị lỗi ====
  function showError(input, message) {
    clearError(input); // tránh lặp lỗi

    const error = document.createElement("div");
    error.className = "error-message";
    error.style.color = "red";
    error.style.fontSize = "14px";
    error.style.marginTop = "4px";
    error.textContent = message;

    // Tìm phần tử cha có class .form-group hoặc .mb-3 (Bootstrap)
    const parent = input.closest(".form-group") || input.closest(".mb-3") || input.parentElement;
    parent.appendChild(error);

    input.classList.add("is-invalid");
  }

  // ==== Hàm xóa lỗi ====
  function clearError(input) {
    input.classList.remove("is-invalid");
    const parent = input.closest(".form-group") || input.closest(".mb-3") || input.parentElement;
    const error = parent.querySelector(".error-message");
    if (error) error.remove();
  }

  // ==== Kiểm tra step 1 ====
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

  // ==== Kiểm tra Step 2 ====
  function checkChapters() {
    const chapters = document.querySelectorAll(".chapter-item");
    return chapters.length > 0;
  }

  // ==== Nút Continue ====
  continueBtn.addEventListener("click", () => {
    if (currentStep === 0) {
      if (!validateStep1()) return; // nếu thiếu thông tin thì dừng
    }

    if (currentStep === 1) {
      if (!checkChapters()) {
        // nếu không có chapter thì bỏ qua step 3 (lesson)
        currentStep = 3;
        showStep(currentStep);
        return;
      }
    }

    if (currentStep < steps.length - 1) {
      currentStep++;
      showStep(currentStep);
    }
  });

  // ==== Nút Back ====
  backBtn.addEventListener("click", () => {
    if (currentStep > 0) {
      currentStep--;
      showStep(currentStep);
    }
  });

  // ==== Hiển thị bước đầu ====
  showStep(currentStep);
});

// =============================== Quiz Creation ===============================
document.addEventListener("DOMContentLoaded", () => {
    const questionsContainer = document.getElementById("questionsContainer");
    const addQuestionBtn = document.getElementById("addQuestionBtn");
    const saveQuizBtn = document.getElementById("saveQuizBtn");
    const cancelBtn = document.getElementById("cancelBtn"); // ✅ nút mới

    let questionCount = 0;

    // ======= Thêm câu hỏi =======
    addQuestionBtn.addEventListener("click", () => {
      questionCount++;
      const questionDiv = document.createElement("div");
      questionDiv.className = "question-item";
      questionDiv.dataset.index = questionCount;

      questionDiv.innerHTML = `
        <div class="d-flex justify-content-between align-items-center mb-2">
          <h5>Question ${questionCount}</h5>
          <button class="btn btn-delete btn-sm">Delete</button>
        </div>
        <input type="text" class="form-control mb-2 question-text" placeholder="Enter question text *">

        <div class="options">
          ${["A", "B", "C", "D"].map(letter => `
            <div class="option-input">
              <input type="radio" name="q${questionCount}" value="${letter}">
              <input type="text" class="form-control option-text" placeholder="Option ${letter}">
            </div>
          `).join('')}
        </div>
      `;

      questionsContainer.appendChild(questionDiv);

      // Nút delete
      questionDiv.querySelector(".btn-delete").addEventListener("click", () => {
        questionDiv.remove();
        updateQuestionNumbers();
      });
    });

    // ======= Cập nhật lại số thứ tự =======
    function updateQuestionNumbers() {
      const items = document.querySelectorAll(".question-item");
      items.forEach((q, i) => {
        q.querySelector("h5").textContent = `Question ${i + 1}`;
        q.dataset.index = i + 1;
      });
  }

  // ======= Hiển thị lỗi =======
  function showError(input, message) {
    clearError(input);
    const err = document.createElement("div");
    err.className = "error-message";
    err.textContent = message;
    input.insertAdjacentElement("afterend", err);
  }

  function clearError(input) {
    const next = input.nextElementSibling;
    if (next && next.classList.contains("error-message")) next.remove();
  }

  // ======= Lưu quiz =======
  saveQuizBtn.addEventListener("click", () => {
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
    // Gửi dữ liệu quiz lên server (nếu cần)
  });

  // ======= Nút Cancel =======
  cancelBtn.addEventListener("click", () => {
    if (confirm("Are you sure you want to cancel quiz creation and return to Dashboard?")) {
      window.location.href = "dashboard.jsp"; // 🔁 đổi nếu trang của bạn tên khác
    }
  });
});

