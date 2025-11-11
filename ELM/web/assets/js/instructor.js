function confirmDelete(materialId) {
        if (confirm("Bạn có chắc chắn muốn xóa material này không? Dữ liệu sẽ không thể phục hồi.")) {
            // Tạo form động và gửi POST request
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