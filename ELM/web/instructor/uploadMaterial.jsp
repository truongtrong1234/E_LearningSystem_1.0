<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Material</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/createCQM.css">
</head>
<body>
    <div class="page-wrap">
        <div class="create-cqm-container">
            <h2 class="cqm-title">Upload New Material</h2>

            <form action="CreateMaterialServlet" method="post" enctype="multipart/form-data">
                <div class="cqm-grid">

                    <!-- Main form -->
                    <div class="cqm-card">
                        <!-- Material Title -->
                        <label class="cqm-label">Material Title <span class="required">*</span></label>
                        <input type="text" name="materialTitle" class="cqm-input" placeholder="e.g. Introduction to JSP" required>

                        <!-- Description -->
                        <label class="cqm-label">Description</label>
                        <textarea name="description" class="cqm-textarea" placeholder="Short description about this material..."></textarea>

                        <!-- Related Course -->
                        <label class="cqm-label">Related Course</label>
                        <select name="courseId" class="cqm-select">
                            <option value="">Select Course</option>
                            <!-- Load from DB -->
                        </select>

                        <!-- File upload -->
                        <label class="cqm-label">Upload File <span class="required">*</span></label>
                        <div class="thumbnail-wrap">
                            <input type="file" name="materialFile" class="file-input" accept=".pdf,.ppt,.pptx,.doc,.docx,.zip,.mp4" required>
                            <div class="thumb-preview" id="material-preview">No file</div>
                        </div>

                        <!-- Tags -->
                        <label class="cqm-label">Tags</label>
                        <div class="tag-input">
                            <input type="text" id="tagInput" class="cqm-input small" placeholder="Add tag (press Enter)">
                        </div>
                        <div class="tags-container" id="tagsContainer"></div>

                        <!-- Actions -->
                        <div class="cqm-actions">
                            <p class="helper-text">Make sure your file is under 50MB and clearly named.</p>
                            <div class="action-buttons">
                                <button type="submit" class="btn-primary cqm-btn">Upload Material</button>
                                <a href="course" class="btn-secondary cqm-btn">Cancel</a>
                            </div>
                        </div>
                    </div>

                    <!-- Aside -->
                    <aside class="cqm-aside">
                        <h4 style="margin-bottom:10px;">Upload Tips</h4>
                        <ul style="font-size:14px; color:#555; line-height:1.6;">
                            <li>Ensure the file format is supported (PDF, DOCX, MP4...)</li>
                            <li>Include clear titles and tags to make it searchable.</li>
                            <li>For videos, consider providing a thumbnail or short intro.</li>
                        </ul>
                    </aside>
                </div>
            </form>
        </div>
    </div>

    <script src="../assets/js/createCQM.js"></script>
</body>
</html>
