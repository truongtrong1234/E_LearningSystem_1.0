// ==================================================== Courses Creation ====================================================
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
