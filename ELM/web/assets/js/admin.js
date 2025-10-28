// Xử lý xoá báo cáo
document.querySelectorAll('.btn-delete').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        const id = this.dataset.id;
        if (confirm("Delete this report?")) {
            fetch("deleteReport.jsp?id=" + id)
            .then(() => location.reload());
        }
    });
});