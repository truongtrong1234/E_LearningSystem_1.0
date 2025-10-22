<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Material</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/createCQM.css"> 
</head>
<body>
    <div class="create-cqm-container" data-page="material">
        <div class="form-wrapper shadow-lg p-5 rounded-4 bg-white">
            <h2 class="mb-4 fw-bold text-center text-primary">Upload Material</h2>
            <form id="uploadMaterialForm">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Title <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="materialTitle" placeholder="Enter material title" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Description</label>
                    <textarea class="form-control" id="materialDescription" rows="3"
                              placeholder="Optional description..."></textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Upload File</label>
                    <input type="file" class="form-control" id="materialFile"
                           accept=".pdf,.doc,.docx,.ppt,.pptx,.jpg,.jpeg,.png,.mp4,.avi,.mov">
                    <div class="form-text">Supported: PDF, DOC, PPT, IMG, Video...</div>
                </div>

                <div class="d-flex justify-content-between">
                    <button type="button" class="btn btn-secondary px-4" id="cancelBtn">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4">Upload Material</button>
                </div>
            </form>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/uploadMaterial.js" defer></script>
</body>
</html>
