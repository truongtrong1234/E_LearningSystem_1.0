<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

    <div id="courses-content" class="tab-content-block ${activeTab == 'course-content' || activeTab == 'quiz-content' ? 'd-none' : '' || activeTab == 'material-content' ? 'd-none' : ''}">
        <!-- Create Course Box -->
        <div class="create-cqm-box p-4 rounded shadow-sm border mb-4 d-flex justify-content-between align-items-center">
            <span class="fs-5 text-muted">Ấn tạo khoá học mới ở bên phải</span>
            <a href="${pageContext.request.contextPath}/instructor/dashboard?actionCourse=createCourse" class="btn create-cqm-btn py-2 px-4">Tạo khoá học mới</a>
        </div>

        <!-- Course List -->
        <div class="row mt-4 course-list">
            <c:choose>
                <c:when test="${not empty courseList}">
                    <c:forEach var="course" items="${courseList}">
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4" onclick="window.location='/ELM/myContent?CourseID=${course.courseID}'">
                            <div class="card cqm-card border-0 shadow-sm">
                                <div class="dropdown cqm-actions" onclick="event.stopPropagation()">
                                    <button class="btn p-0 text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="/ELM/instructor/dashboard?actionCourse=editCourse&id=${course.courseID}"><i class="fas fa-edit me-2"></i> Sửa khoá học </a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form action="/ELM/instructor/dashboard" method="post">
                                                <button type="submit" class="dropdown-item" value="${course.courseID}" name="action">Xoá khoá học</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                                <div class="cqm-image-placeholder bg-light rounded-top">
                                    <img src="${course.thumbnail}" alt="alt"/>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title fw-bold text-truncate" title="${course.title}">${course.title}</h5>
                                    <p class="card-text text-muted mb-2">${course.price} VND</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="alert alert-info text-center" role="alert">
                            Chưa có khoá học nào được tạo. Hãy ấn
                            <a href="createCourse" style="text-decoration: none; font-weight: bold">"Tạo khoá học mới"</a> 
                            để bắt đầu!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>