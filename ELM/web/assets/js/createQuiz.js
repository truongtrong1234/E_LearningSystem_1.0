$(document).ready(function () {
    // Khi chọn Course → load Chapter bằng AJAX
    $("#courseSelect").on("change", function () {
        let courseId = $(this).val();
        let chapterSelect = $("#chapterSelect");
        chapterSelect.html('<option value="">-- Loading Chapters... --</option>');

        if (courseId) {
            $.ajax({
                url: contextPath + "/instructor/getChapters",
                type: "GET",
                data: { courseId: courseId },
                success: function (data) {
                    chapterSelect.empty();
                    chapterSelect.append('<option value="">-- Chọn chương --</option>');
                    data.forEach(ch => {
                        chapterSelect.append('<option value="' + ch.chapterID + '">' + ch.title + '</option>');
                    });
                },
                error: function () {
                    chapterSelect.html('<option value="">-- Error loading chapters --</option>');
                }
            });
        } else {
            chapterSelect.html('<option value="">-- Choose Chapter --</option>');
        }
    });

    // Thêm câu hỏi mới
    $("#addQuestionBtn").click(function (e) {
        e.preventDefault();
        const qCount = $(".question-item").length + 1;
        const qHTML = `
            <div class="question-item border p-3 rounded mt-3 position-relative bg-light">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <label class="fw-bold mb-0">Question ${qCount}</label>
                    <button type="button" class="btn btn-sm btn-outline-danger remove-question">
                        <i class="fas fa-trash-alt"></i> Remove
                    </button>
                </div>
                <input type="text" name="question${qCount}" class="form-control mb-2" placeholder="Enter question text" required>
                <div class="d-flex gap-2">
                    <input type="text" name="optionA_${qCount}" class="form-control" placeholder="Option A" required>
                    <input type="text" name="optionB_${qCount}" class="form-control" placeholder="Option B" required>
                    <input type="text" name="optionC_${qCount}" class="form-control" placeholder="Option C" required>
                    <input type="text" name="optionD_${qCount}" class="form-control" placeholder="Option D" required>
                </div>
                <input type="text" name="answer${qCount}" class="form-control mt-2" placeholder="Correct answer (A/B/C/D)" required>
            </div>`;
        $("#questionsContainer").append(qHTML);
    });

    // Xóa câu hỏi khi nhấn nút Remove
    $(document).on("click", ".remove-question", function () {
        $(this).closest(".question-item").remove();

        // Đánh số lại các câu hỏi còn lại
        $(".question-item").each(function (index) {
            $(this).find("label.fw-bold").text("Question " + (index + 1));
        });
    });
});
