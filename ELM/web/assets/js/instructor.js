function confirmDeleteQuiz(quizID) {
    if (confirm("Bạn có chắc chắn muốn xóa bài kiểm tra ID: " + quizID + " này không?")) {
        var form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', 'quizList'); 

        // Trường ẩn QuizID
        var idField = document.createElement('input');
        idField.setAttribute('type', 'hidden');
        idField.setAttribute('name', 'quizID');
        idField.setAttribute('value', quizID);

        // Trường ẩn Action
        var actionField = document.createElement('input');
        actionField.setAttribute('type', 'hidden');
        actionField.setAttribute('name', 'action');
        actionField.setAttribute('value', 'delete'); // Gửi action = delete

        form.appendChild(idField);
        form.appendChild(actionField);
        document.body.appendChild(form);
        form.submit();
    }
}

function confirmDeleteMaterial(materialId) {
        if (confirm("Bạn có chắc chắn muốn xóa material này không? Dữ liệu sẽ không thể phục hồi.")) {
            var form = document.createElement('form');
            form.setAttribute('method', 'POST');
            form.setAttribute('action', 'MaterialListController'); 
            
            // Thêm materialID
            var idField = document.createElement('input');
            idField.setAttribute('type', 'hidden');
            idField.setAttribute('name', 'materialID');
            idField.setAttribute('value', materialId);
            form.appendChild(idField);
            
            // Thêm action=delete
            var actionField = document.createElement('input');
            actionField.setAttribute('type', 'hidden');
            actionField.setAttribute('name', 'action');
            actionField.setAttribute('value', 'delete');
            form.appendChild(actionField);

            document.body.appendChild(form);
            form.submit();
        }
    }