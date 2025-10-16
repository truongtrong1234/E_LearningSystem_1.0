/* createCQM.js - shared logic for Create Course / Quiz / Material */

document.addEventListener("DOMContentLoaded", () => {
  console.log("createCQM.js loaded");

  const container = document.querySelector(".create-cqm-container");
  const form = document.getElementById("createForm");
  const pageType = container?.dataset.page; // "course", "quiz", hoặc "material"
  console.log("pageType:", pageType);

  // 1. Cảnh báo khi rời khỏi trang mà chưa lưu
  let formChanged = false;
  form?.addEventListener("input", () => (formChanged = true));
  window.addEventListener("beforeunload", (e) => {
    if (formChanged) {
      e.preventDefault();
      e.returnValue = "";
    }
  });

  // 2. Preview thumbnail (nếu có)
  const thumbInput = document.querySelector("#thumbnailInput");
  const thumbPreview = document.querySelector("#thumbPreview");
  if (thumbInput && thumbPreview) {
    thumbInput.addEventListener("change", (e) => {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (ev) => (thumbPreview.src = ev.target.result);
        reader.readAsDataURL(file);
      }
    });
  }

  // 3. Validate form cơ bản
  form?.addEventListener("submit", (e) => {
    const requiredInputs = form.querySelectorAll("[required]");
    let valid = true;
    requiredInputs.forEach((inp) => {
      if (!inp.value.trim()) {
        inp.classList.add("error");
        valid = false;
      } else {
        inp.classList.remove("error");
      }
    });
    if (!valid) {
      e.preventDefault();
      alert("Please fill in all required fields.");
    }
  });

  // ======================
  // Logic riêng từng trang
  // ======================
  if (pageType === "quiz") {
    initQuizBuilder();
  } else if (pageType === "course") {
    initCoursePage();
  } else if (pageType === "material") {
    initMaterialPage();
  }

  // =========================================================
  // QUIZ BUILDER — Tạo nhiều loại câu hỏi (MCQ / Essay)
  // =========================================================
  function initQuizBuilder() {
    console.log("Quiz builder initialized");

    const questionsContainer = document.getElementById("questionsContainer");
    const addQuestionBtn = document.getElementById("addQuestionBtn");
    if (!questionsContainer || !addQuestionBtn) {
      console.warn("Missing #questionsContainer hoặc #addQuestionBtn");
      return;
    }

    let questionCount = 0;

    addQuestionBtn.addEventListener("click", () => {
      questionCount++;
      const qDiv = document.createElement("div");
      qDiv.className = "question-block";
      qDiv.dataset.index = questionCount;

      qDiv.innerHTML = `
        <hr>
        <label class="question-title">Question ${questionCount}</label>
        <input type="text" name="question_${questionCount}" class="cqm-input" placeholder="Enter question text..." required>
        
        <label class="cqm-label">Question Type</label>
        <select name="type_${questionCount}" class="cqm-select question-type">
          <option value="mcq">Multiple Choice</option>
          <option value="essay">Essay (Short Answer)</option>
        </select>

        <div class="options-container" id="options_${questionCount}">
          ${[1, 2, 3, 4]
            .map(
              (i) => `
            <div class="option-input">
              <input type="radio" name="correct_${questionCount}" value="${i}" required>
              <input type="text" name="option_${questionCount}_${i}" placeholder="Option ${i}" class="cqm-input small" required>
            </div>`
            )
            .join("")}
        </div>

        <div class="essay-container hidden" id="essay_${questionCount}">
          <textarea name="essay_${questionCount}" class="cqm-textarea" placeholder="Student will write answer here..."></textarea>
        </div>

        <button type="button" class="remove-question-btn small-btn">Remove Question</button>
      `;

      questionsContainer.appendChild(qDiv);

      // Sự kiện đổi loại câu hỏi
      const selectType = qDiv.querySelector(".question-type");
      const optionsDiv = qDiv.querySelector(`#options_${questionCount}`);
      const essayDiv = qDiv.querySelector(`#essay_${questionCount}`);

      selectType.addEventListener("change", () => {
        if (selectType.value === "mcq") {
          optionsDiv.classList.remove("hidden");
          essayDiv.classList.add("hidden");
        } else {
          optionsDiv.classList.add("hidden");
          essayDiv.classList.remove("hidden");
        }
      });

      // Xóa câu hỏi
      qDiv.querySelector(".remove-question-btn").addEventListener("click", () => {
        qDiv.remove();
      });
    });
  }

  // =========================================================
  // COURSE BUILDER
  // =========================================================
  function initCoursePage() {
    console.log("Course page initialized");
  }

  // =========================================================
  // MATERIAL BUILDER
  // =========================================================
  function initMaterialPage() {
    console.log("Material page initialized");
  }
});
