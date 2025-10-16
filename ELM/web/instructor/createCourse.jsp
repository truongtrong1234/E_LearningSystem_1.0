<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Create New Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/createCQM.css">
</head>
<body>
  <main class="page-wrap">
    <section class="create-cqm-container" aria-labelledby="pageTitle">
      <h1 id="pageTitle" class="cqm-title">Create New Course</h1>

      <!-- Form gửi đến Servlet CreateCourseServlet (thay đường dẫn nếu khác) -->
      <form id="createCourseForm" class="create-cqm" action="<%=request.getContextPath()%>/CreateCourseServlet"
            method="post" enctype="multipart/form-data" novalidate>

        <!-- Left column main inputs -->
        <div class="cqm-grid">

          <div class="cqm-card">
            <label for="title" class="cqm-label">Course Title <span class="required">*</span></label>
            <input id="title" name="title" type="text" class="cqm-input" placeholder="Ví dụ: Lập trình Java cơ bản" required
                   aria-required="true" />

            <label for="subtitle" class="cqm-label">Subtitle</label>
            <input id="subtitle" name="subtitle" type="text" class="cqm-input" placeholder="Mô tả ngắn, 1 dòng" />

            <label for="description" class="cqm-label">Description <span class="required">*</span></label>
            <textarea id="description" name="description" class="cqm-textarea" rows="7"
                      placeholder="Viết mô tả chi tiết cho khóa học..." required aria-required="true"></textarea>

            <label class="cqm-label">What students will learn (bullet points)</label>
            <div id="outcomesWrap" class="outcomes-wrap">
              <input type="text" class="cqm-input small" placeholder="Ví dụ: Hiểu cấu trúc OOP" />
              <button type="button" id="addOutcomeBtn" class="btn small-btn">Add</button>
            </div>
            <ul id="outcomesList" class="outcomes-list" aria-live="polite"></ul>
          </div>

          <aside class="cqm-card cqm-aside" aria-label="Course Metadata">
            <label for="category" class="cqm-label">Category <span class="required">*</span></label>
            <select id="category" name="category" class="cqm-select" required>
              <option value="">-- Chọn danh mục --</option>
              <!-- TODO: load options từ DB bằng JSP/Servlet -->
              <option value="web">Web Development</option>
              <option value="mobile">Mobile</option>
              <option value="data">Data Science</option>
            </select>

            <label for="level" class="cqm-label">Level</label>
            <select id="level" name="level" class="cqm-select">
              <option value="">Any</option>
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="advanced">Advanced</option>
            </select>

            <label for="language" class="cqm-label">Language</label>
            <input id="language" name="language" type="text" class="cqm-input" placeholder="e.g. Vietnamese" />

            <label for="price" class="cqm-label">Price (VND)</label>
            <input id="price" name="price" type="number" class="cqm-input" min="0" step="1000" placeholder="0 = free" />

            <label for="duration" class="cqm-label">Estimated Duration (hours)</label>
            <input id="duration" name="duration" type="number" class="cqm-input" min="0" step="1" placeholder="e.g. 15" />

            <label for="startDate" class="cqm-label">Start Date</label>
            <input id="startDate" name="startDate" type="date" class="cqm-input" />

            <label class="cqm-label">Tags</label>
            <div class="tag-input" id="tagInputWrap">
              <input id="tagInput" type="text" class="cqm-input small" placeholder="Add tag and press Enter" />
            </div>
            <div id="tagsContainer" class="tags-container" aria-live="polite"></div>

            <label class="cqm-label">Thumbnail</label>
            <div class="thumbnail-wrap">
              <input id="thumbnail" name="thumbnail" type="file" accept="image/*" class="file-input" />
              <div id="thumbPreview" class="thumb-preview" aria-hidden="true">No image</div>
            </div>

            <label class="cqm-label">Course Materials (optional)</label>
            <input id="materials" name="materials" type="file" accept=".pdf,.ppt,.pptx,.docx,.zip" multiple class="file-input" />

          </aside>
        </div>

        <!-- Action buttons & helper -->
        <div class="cqm-actions">
          <div class="helper-text">Các trường có <span class="required">*</span> là bắt buộc.</div>
          <div class="action-buttons">
            <button type="submit" class="btn btn-primary cqm-btn">Create Course</button>
            <a href="<%=request.getContextPath()%>/instructor/dashboard.jsp" class="btn btn-secondary cqm-btn">Cancel</a>
          </div>
        </div>

      </form>
    </section>
  </main>

  <!-- JS: client-side behaviors (preview, tags, validation) -->
  <script src="../assets/js/createCQM.js"></script>
  <!-- Bootstrap JS optional -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
