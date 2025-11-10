<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${course.title} | Course Detail (Admin View)</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/courseDetail.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">

    <style>
        body {
            background-color: #f4f6f9;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            transition: 0.3s;
            text-decoration: none;
        }
        .btn-back:hover {
            background-color: #5a6268;
            color: #fff;
        }
        .chapter-title {
            font-weight: 600;
            margin-top: 10px;
        }
        .lesson-item {
            margin-left: 20px;
            color: #444;
        }
    </style>
</head>

<body>

<!-- 🧭 Breadcrumb -->
<div class="container mt-4 mb-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
            <li class="breadcrumb-item"><a href="adminIndex">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="manageCourse">Manage Courses</a></li>
            <li class="breadcrumb-item active" aria-current="page">${course.title}</li>
        </ol>
    </nav>

    <!-- 🏫 Thông tin khóa học -->
<div class="row mb-4 bg-white p-3 rounded shadow-sm">
    <!-- Ảnh thumbnail -->
    <div class="col-md-4">
        <img src="${pageContext.request.contextPath}/assets/images/${course.thumbnail}" 
             alt="${course.title}" class="img-fluid rounded">
    </div>

    <!-- Thông tin khóa học -->
    <div class="col-md-8">
        <h2 class="fw-bold">${course.title}</h2>

        <p class="mb-1"><strong>Giảng viên:</strong> 
            <a href="${pageContext.request.contextPath}/instructorDetail?id=${instructor.instructorID}"
               class="text-primary text-decoration-none">
               ${instructor.instructorName}
            </a>
        </p>

        <p class="mb-1"><strong>Danh mục:</strong> ${course.categoryName}</p>
        <p class="mb-1"><strong>Lớp học:</strong> ${course.courseclass}</p>
        <p class="mb-1"><strong>Giá:</strong> 
            <c:choose>
                <c:when test="${course.price == 0}">Miễn phí</c:when>
                <c:otherwise>$${course.price}</c:otherwise>
            </c:choose>
        </p>

        <hr>

        <h6 class="fw-bold">Mô tả khóa học</h6>
        <p>${course.description}</p>

        <a href="manageCourse" class="btn btn-secondary mt-3">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
        </a>
    </div>
</div>


    <!-- 📖 Mục lục khóa học -->
    <div class="bg-white p-4 rounded shadow-sm mb-4">
        <h4><i class="fa-solid fa-list-ul me-2"></i>Mục lục khóa học</h4>
        <c:if test="${not empty chapters}">
            <c:forEach var="ch" items="${chapters}" varStatus="loop">
                <div class="chapter-title">${loop.index + 1}. ${ch.title}</div>
                <ul class="list-unstyled">
                    <c:forEach var="lesson" items="${lessons[ch.chapterID]}">
                        <li class="lesson-item">
                            <i class="fa-regular fa-circle-play me-2"></i>${lesson.title}
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </c:if>
        <c:if test="${empty chapters}">
            <p>Chưa có chương học nào.</p>
        </c:if>
    </div>

    <c:forEach var="ch" items="${course.chapters}" varStatus="chStatus">
    <h5>${chStatus.index + 1}. ${ch.title}</h5>

    <c:forEach var="quiz" items="${quizzesMap[ch.chapterID]}" varStatus="qStatus">
        <h6>Quiz ${qStatus.index + 1}: ${quiz.title}</h6>

        <div class="accordion" id="quizAccordion${quiz.quizID}">
            <c:forEach var="q" items="${questionsMap[quiz.quizID]}" varStatus="st">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="heading${st.index}">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse${st.index}" aria-expanded="false"
                                aria-controls="collapse${st.index}">
                            Câu hỏi ${st.index + 1}: ${q.questionText}
                        </button>
                    </h2>
                    <div id="collapse${st.index}" class="accordion-collapse collapse"
                         aria-labelledby="heading${st.index}" data-bs-parent="#quizAccordion${quiz.quizID}">
                        <div class="accordion-body">
                            <ul>
                                <li>A. ${q.optionA}</li>
                                <li>B. ${q.optionB}</li>
                                <li>C. ${q.optionC}</li>
                                <li>D. ${q.optionD}</li>
                            </ul>
                            <strong>Đáp án đúng:</strong> ${q.correctAnswer}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </c:forEach>
</c:forEach>
        <c:if test="${empty quizzes}">
            <p>Chưa có câu hỏi quiz nào cho khóa học này.</p>
        </c:if>
    </div>

</div>
</body>
</html>
