<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Quiz - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
<div class="container py-5">
    <h3 class="text-center mb-4 text-primary fw-bold">Chi tiết Quiz: ${quiz.title}</h3>

    <c:choose>
        <c:when test="${not empty questionList}">
            <c:forEach var="q" items="${questionList}" varStatus="loop">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title text-dark">Câu ${loop.index + 1}: ${q.questionText}</h5>

                        <div class="mt-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${q.correctAnswer eq 'A'}">checked</c:if> />
                                <label class="form-check-label ${q.correctAnswer eq 'A' ? 'text-success fw-bold' : ''}">
                                    A. ${q.optionA}
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${q.correctAnswer eq 'B'}">checked</c:if> />
                                <label class="form-check-label ${q.correctAnswer eq 'B' ? 'text-success fw-bold' : ''}">
                                    B. ${q.optionB}
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${q.correctAnswer eq 'C'}">checked</c:if> />
                                <label class="form-check-label ${q.correctAnswer eq 'C' ? 'text-success fw-bold' : ''}">
                                    C. ${q.optionC}
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" disabled
                                       <c:if test="${q.correctAnswer eq 'D'}">checked</c:if> />
                                <label class="form-check-label ${q.correctAnswer eq 'D' ? 'text-success fw-bold' : ''}">
                                    D. ${q.optionD}
                                </label>
                            </div>
                        </div>

                        <p class="mt-3 mb-0"><strong>✅ Đáp án đúng:</strong> ${q.correctAnswer}</p>
                    </div>
                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <div class="alert alert-warning text-center">
                Chưa có câu hỏi nào trong quiz này.
            </div>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/admin/viewCourseDetail?CourseID=${quiz.courseID}" 
           class="btn btn-secondary px-4">
            ← Quay lại khóa học
        </a>
    </div>
</div>
</body>
</html>
