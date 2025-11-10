document.addEventListener("DOMContentLoaded", () => {
    const editBtn = document.getElementById("editToggleBtn");
    const saveBtn = document.getElementById("saveBtn");
    const fields = document.querySelectorAll(".editable-field");

    let editing = false;

    editBtn.addEventListener("click", () => {
        editing = !editing;
        fields.forEach(f => {
            if (["INPUT", "SELECT", "TEXTAREA"].includes(f.tagName)) {
                f.readOnly = !editing;
                f.disabled = !editing;
            }
        });

        if (editing) {
            editBtn.textContent = "Huỷ";
            editBtn.classList.replace("btn-warning", "btn-secondary");
            saveBtn.classList.remove("d-none");
        } else {
            editBtn.textContent = "Sửa";
            editBtn.classList.replace("btn-secondary", "btn-warning");
            saveBtn.classList.add("d-none");
        }
    });
});
