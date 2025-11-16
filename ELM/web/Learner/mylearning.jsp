<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>My Learning</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="assets/css/headerLearner.css?v3">
        <style>
            body {
                background: #fafafa;
                font-family: 'Inter', sans-serif;
                margin: 0;
                padding: 0;
            }

            main.learning-container {
                max-width: 1100px;
                margin: 40px auto;
                padding: 0 20px;
            }

            h1 {
                font-size: 28px;
                font-weight: 700;
                color: #222;
                margin-bottom: 24px;
            }

            /* ===== COURSE CARD ===== */
            .course-card {
                display: flex;
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                margin-bottom: 20px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.06);
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .course-card {
                display: flex;
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                margin-bottom: 20px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.06);
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .course-thumb {
                flex: 0 0 260px;
                height: 172px;
                overflow: hidden;
            }

            .course-thumb img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* vừa khung */
            }


            .course-info {
                flex: 1;
                padding: 18px 20px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .course-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .course-header h2 {
                font-size: 20px;
                color: #222;
                margin: 0;
            }

            .course-instructor {
                font-size: 14px;
                color: #666;
                margin: 4px 0 10px 0;
            }

            /* ===== PROGRESS ===== */
            .progress-container {
                margin-top: 12px;
            }

            .progress-bar {
                width: 100%;
                height: 8px;
                background: #eee;
                border-radius: 5px;
                overflow: hidden;
            }

            .progress-fill {
                height: 100%;
                background: #28a745; /* xanh lá */
                width: var(--progress, 0%);
                transition: width 0.5s ease;
            }

            .progress-text {
                font-size: 14px;
                color: #444;
                margin-top: 6px;
            }

            /* ===== NÚT ===== */
            .course-actions {
                text-align: right;
                margin-top: 12px;
            }

            .btn-continue {
                background: #ff6b00; /* màu cam */
                border: none;
                padding: 8px 16px;
                color: #fff;
                font-weight: 600;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-continue:hover {
                background: #ff8800;
            }
        </style>

    </head>
    <body>

        <jsp:include page="/components/headerLearner.jsp"/>

        <main class="learning-container">
            <c:choose>
                <c:when test="${empty myResults}">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <!-- Title -->
                        <h1 class="m-0 display-5 fw-bold">My Learning</h1>

                        <a href="myLearning?myResult=checkQuiz" class="btn btn-warning text-white rounded-pill shadow-sm d-inline-flex align-items-center">
                            <i class="bi bi-bar-chart-line me-2" aria-hidden="true"></i>
                            Xem điểm
                        </a>
                    </div>

                    <c:if test="${empty myLearningCourse}">
                        <p>Bạn chưa đăng ký khóa học nào.</p>
                    </c:if>

                    <c:forEach var="course" items="${myLearningCourse}">
                        <div class="course-card">
                            <div class="course-thumb">
                                <img src="${course.thumbnail}" alt="${course.title}" />
                            </div>

                            <div class="course-info">
                                <div class="course-header">
                                    <h2>${course.title}</h2>
                                </div>
                                <p class="course-instructor">${course.instructorName}</p>

                                <div class="progress-container">
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="--progress: ${courseProgressMap[course.courseID]}%;"></div>
                                    </div>
                                    <span class="progress-text">${courseProgressMap[course.courseID]}% completed</span>
                                </div>

                                <div class="course-actions">
                                    <a href="myContent?CourseID=${course.courseID}">
                                        <button class="btn-continue">Tiếp tục học</button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:when test="${myResults eq 'checkQuiz'}">
                    <div class="mb-3">
                        <h6 class="fw-bold mb-3">Kết quả bài kiểm tra</h6>

                        <table class="table table-bordered table-hover">
                            <thead class="table-warning">
                                <tr>
                                    <th scope="col">Tên bài kiểm tra</th>
                                    <th scope="col">Điểm</th>
                                    <th scope="col">Ngày làm bài</th>
                                    <th scope="col">Trạng thái</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="qr" items="${listResult}">
                                    <tr>
                                        <td>${qr.quizName}</td>

                                        <td>${qr.totalScore}
                                        </td>

                                        <td>${qr.takenDate}
                                        </td>
                                        <td><c:if test="${qr.totalScore > 5}">
                                              <span class="badge bg-success">Pass </span>
                                        </c:if>
                                                <c:if test="${qr.totalScore < 5}">
                                               <span class="badge bg-danger">Fail</span>
                                        </c:if>
                                                
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </c:when>
            </c:choose>

        </main>

    </body>
</html>
