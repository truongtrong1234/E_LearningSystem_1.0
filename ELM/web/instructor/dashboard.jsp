<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Courses - Nền tảng E-learning</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructorDashboard.css">
    </head>
    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar d-flex flex-column" id="sidebar">
                <div class="sidebar-header p-3 text-white fs-4 fw-bold">
                    <span class="logo-icon">Ú</span>
                </div>
                <ul class="nav nav-pills flex-column mb-auto">
                    <li class="nav-item">
                        <a href="dashboard.jsp" class="nav-link text-white sidebar-link active">
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard 
                        </a>
                    </li>
                    <li>
                        <a href="communication" class="nav-link text-white sidebar-link">
                            <i class="fas fa-comments me-2"></i> Communication
                        </a>
                    </li>
                    <li>
                        <a href="analytics" class="nav-link text-white sidebar-link">
                            <i class="fas fa-chart-bar me-2"></i> Analytics
                        </a>
                    </li>
                    <li>
                        <a href="analytics" class="nav-link text-white sidebar-link">
                            <i class="fas fa-question-circle me-2"></i> Helps
                        </a>
                    </li>
                </ul>
            </div>
            <!-- Main Content -->
            <div class="main-content flex-grow-1 p-0">
                <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom p-3">
                    <div class="container-fluid">
                        <h1 class="h3 mb-0">Dashboard </h1>
                        <div class="mx-auto">
                            <h4 class="fw-semibold mb-0">Xin chào ${sessionScope.account.getName()}</h4>
                        </div>
                        <div class="d-flex align-items-center ms-auto">
                            <a href="../Learner/home_learner.jsp" class="me-3 text-muted nav-profile-text" style="text-decoration:none; cursor:pointer;">
    Learner
</a>

                            <button class="btn btn-sm me-3 notification-btn" type="button">
                                <i class="fas fa-bell"></i>
                            </button>
                            <button class="btn btn-sm me-3 notification-btn" type="button">
                                <i class="fa-solid fa-user-circle fa-2x"><a href="myProfile"></a></i>
                            </button>
                        </div>
                    </div>
                </nav>
                <div class="container-fluid p-4">
                    <ul class="nav nav-tabs custom-tabs mb-4">
                        <li class="nav-item">
                            <a class="nav-link active custom-tab-link" aria-current="page" data-tab="courses-content" href="#course-content">Courses</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link custom-tab-link" data-tab="quiz-content" href="#quiz-content">Quiz</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link custom-tab-link" data-tab="materials-content" href="#materials-content">Materials</a>
                        </li>
                    </ul>
                    <!-- Manage Course -->
                    <div id="courses-content" class="tab-content-block">
                        <!-- Create Course -->
                        <div class="create-cqm-box p-4 rounded shadow-sm border">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fs-5 text-muted">Jump Into Course Creation</span>
                                <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href = 'instructor/createCourse.jsp'">Create Your Course</button>
                            </div>
                        </div>
                        <!-- List Courses -->

                        <div class="row mt-4 course-list">
                            <c:choose>
                                <c:when test="${not empty courseList}">
                                    <c:forEach var="course" items="${courseList}">
                                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                                            <div class="card cqm-card border-0 shadow-sm">
                                                <div class="dropdown cqm-actions">
                                                    <button class="btn p-0 text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item" href="course?id=${course.courseID}"><i class="fas fa-eye me-2"></i> View Course</a></li>
                                                        <li><a class="dropdown-item" href="course?action=edit&id=${course.courseID}"><i class="fas fa-edit me-2"></i> Edit Course</a></li>
                                                        <li><hr class="dropdown-divider"></li>
                                                        <li>
                                                            <a class="dropdown-item text-danger" href="course?action=delete&id=${course.courseID}" onclick="return confirm('Bạn có chắc chắn muốn xóa khóa học ${course.title}?');">
                                                                <i class="fas fa-trash-alt me-2"></i> Delete Course
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="cqm-image-placeholder bg-light rounded-top">
                                                    <i class="fas fa-book-open fa-3x text-secondary"></i>
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
                                    <div class="alert alert-info text-center" role="alert">Chưa có khóa học nào được tạo. Hãy nhấn <a href="instructor/createCourse.jsp">"Create Your Course"</a> để bắt đầu</div>
                                </div>
                            </c:otherwise>
                         </c:choose>
                    </div>
                </div>  
                <!-- Manage Quiz -->    
                <div id="quiz-content" class="tab-content-block" style="display: none;">
                    <!-- Create Quiz -->
                    <div class="create-cqm-box p-4 rounded shadow-sm border mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fs-5 text-muted">Jump Into Quiz Creation</span>
                            <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href = 'instructor/createQuiz.jsp'">Create New Quiz</button>
                        </div>
                    </div>
                    <!-- List Quiz -->
                    <div class="row mt-4 quiz-list">
                        <c:choose>
                            <c:when test="${not empty quizList}">
                                <c:forEach var="quiz" items="${quizList}">
                                    <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                                        <div class="card cqm-card border-0 shadow-sm">
                                            <div class="dropdown cqm-actions">
                                                <button class="btn p-0 text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="quiz?id=${quiz.quizId}"><i class="fas fa-eye me-2"></i> View Quiz</a></li>
                                                    <li><a class="dropdown-item" href="quiz?action=edit&id=${quiz.quizId}"><i class="fas fa-edit me-2"></i> Edit Quiz</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li>
                                                        <a class="dropdown-item text-danger" href="quiz?action=delete&id=${quiz.quizId}" onclick="return confirm('Bạn có chắc chắn muốn xóa bài Quiz này?');">
                                                            <i class="fas fa-trash-alt me-2"></i> Delete Quiz
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="cqm-image-placeholder bg-light rounded-top">
                                                <i class="fas fa-question-circle fa-3x text-secondary"></i> </div>
                                            <div class="card-body">
                                                <a href="quiz?id=${quiz.quizId}" class="text-decoration-none text-dark">
                                                    <h5 class="card-title fw-bold text-truncate" title="${quiz.quizName}">${quiz.quizName}</h5>
                                                </a>
                                                <p class="card-text text-muted mb-2">Questions: ${quiz.totalQuestions}</p>
                                                <span class="badge bg-primary-dark">${quiz.status}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12"><div class="alert alert-info text-center" role="alert">Chưa có bài Quiz nào được tạo. Hãy nhấn "Create New Quiz" để bắt đầu!</div></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!-- Manage Material -->
                <div id="materials-content" class="tab-content-block" style="display: none;">
                    <div class="create-cqm-box p-4 rounded shadow-sm border mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fs-5 text-muted">Upload and Manage Course Materials</span>
                            <button class="btn create-cqm-btn py-2 px-4" onclick="window.location.href = 'uploadMaterial.jsp'">Upload New Material</button>
                        </div>
                    </div>
                    <!-- List Material -->
                    <div class="row mt-4 material-list">
                        <c:choose>
                            <c:when test="${not empty materialList}">
                                <c:forEach var="material" items="${materialList}">
                                    <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                                        <div class="card cqm-card border-0 shadow-sm">
                                            <div class="dropdown cqm-actions">
                                                <button class="btn p-0 text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="material?id=${material.materialId}"><i class="fas fa-download me-2"></i> Download/View</a></li>
                                                    <li><a class="dropdown-item" href="material?action=edit&id=${material.materialId}"><i class="fas fa-edit me-2"></i> Edit Metadata</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li>
                                                        <a class="dropdown-item text-danger" href="material?action=delete&id=${material.materialId}" onclick="return confirm('Bạn có chắc chắn muốn xóa tài liệu ${material.materialName}?');">
                                                            <i class="fas fa-trash-alt me-2"></i> Delete File
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="cqm-image-placeholder bg-light rounded-top">
                                                <i class="fas fa-file-pdf fa-3x text-secondary"></i> </div>
                                            <div class="card-body">
                                                <a href="material?id=${material.materialId}" class="text-decoration-none text-dark">
                                                    <h5 class="card-title fw-bold text-truncate" title="${material.materialName}">${material.materialName}</h5>
                                                </a>
                                                <p class="card-text text-muted mb-2">Type: ${material.fileType}</p>
                                                <span class="badge bg-primary-dark">${material.courseName}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12"><div class="alert alert-info text-center" role="alert">Chưa có tài liệu nào được tải lên. Hãy nhấn "Upload New Material" để bắt đầu!</div></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>       
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/instructorDashboard.js"></script>
</body>
</html>