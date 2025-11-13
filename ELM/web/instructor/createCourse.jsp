<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="card shadow-sm p-4 mt-4">
    <div class="step-header mb-4">
        <div class="text-center">
            <div class="circle active">1</div>
            <div class="label">C? b?n</div>
        </div>
        <div class="step-indicator"></div>
        <div class="text-center">
            <div class="circle">2</div>
            <div class="label">Chương</div>
        </div>
        <div class="step-indicator"></div>
        <div class="text-center">
            <div class="circle">3</div>
            <div class="label">Bài giảng</div>
        </div>
        <div class="step-indicator"></div>
        <div class="text-center">
            <div class="circle">4</div>
            <div class="label">Kiểm tra</div>
        </div>
    </div>

    <form id="courseForm" action="createCourse" method="post" enctype="multipart/form-data">
        <h5 class="mb-3">Thông tin cơ bản</h5>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="courseTitle" class="form-label">Tiêu đề khoá học*</label>
                <input type="text" id="courseTitle" name="courseTitle" class="form-control" placeholder="Enter course title" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Danh mục (Môn học) *</label>
                <select id="categorySelect" name="categoryID" class="form-select" required>
                    <option value="" disabled selected>-- Select Category --</option>
                    <c:forEach var="c" items="${categoryList}">
                        <option value="${c.cate_id}">${c.cate_name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea id="description" name="description" class="form-control" rows="3"></textarea>
        </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <label class="form-label">Khối *</label>
                <select id="class" name="class" class="form-select" required>
                    <option value="">-- Chọn khối --</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">Giá (?) *</label>
                <input type="number" id="price" name="price" class="form-control" step="1000" min="10000" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Ảnh bìa</label>
            <input type="file" id="thumbnail" name="thumbnail" class="form-control">
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>L?i:</strong> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between mt-4">
            <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark">
                <i class="fas fa-home"></i>
            </a>
            <button type="submit" class="btn btn-primary">Tiếp theo</button>
        </div>
    </form>
</div>
