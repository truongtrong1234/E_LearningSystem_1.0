<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

    <div id="material-content" class="tab-content-block ${activeTab != 'material-content' ? 'd-none' : ''}">
        <!-- Material List -->
        <div class="row mt-4">
            <div class="col-12">
                <form action="${pageContext.request.contextPath}/instructor/MaterialListController" method="get" id="filterForm" class="mb-3">
                    <input type="hidden" name="activeTab" value="material-content">
                    <div class="d-flex align-items-center">
                        <label for="courseFilter" class="form-label me-3 mb-0 fw-bold">Lọc theo Khóa học:</label>
                        <select class="form-select w-auto" id="courseFilter" name="courseID" 
                                onchange="document.getElementById('filterForm').submit()">
                            <option value="0">Tất cả Khóa học</option>
                            <c:forEach var="course" items="${courseList}">
                                <option value="${course.courseID}" 
                                        ${param.courseID == course.courseID || selectedCourseID == course.courseID ? 'selected' : ''}>
                                        ${course.title}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
                <c:choose>
                    <c:when test="${not empty materialList}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>STT</th>
                                        <th>Tiêu đề</th>
                                        <th>Loại</th>
                                        <th>Khoá học</th> 
                                        <th>Chương</th> 
                                        <th>Bài giảng</th>
                                        <th class="text-center">Tạo ngày</th>
                                        <th class="text-center">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="m" items="${materialList}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/viewMaterial?url=${m.contentURL}" 
                                                    target="_blank" class="text-decoration-none fw-semibold text-dark">
                                                    ${m.title}
                                                </a>
                                            </td>
                                            <td>${m.materialType}</td>
                                            <td>${m.lessonName}</td>
                                            <td>${m.chapterName}</td>
                                            <td>${m.courseName}</td>
                                            <td class="text-center"><fmt:formatDate value="${m.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/viewMaterial?url=${m.contentURL}" 
                                                    class="btn btn-view btn-sm btn-outline-success me-2" target="_blank">
                                                    <i class="fas fa-eye"></i> Xem
                                                </a>
                                                <button type="button" class="btn btn-delete btn-sm btn-outline-danger" 
                                                        onclick="confirmDeleteMaterial(${m.materialID})">
                                                        <i class="fas fa-trash-alt"></i> Xoá
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info text-center" role="alert">
                            Chưa có tài liệu nào. Hãy ấn
                            <a href="createCourse" style="text-decoration: none; font-weight: bold">"Tạo khoá học mới"</a>
                            để bắt đầu!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>      