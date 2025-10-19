<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Course" %>
<%@ page import="java.util.Base64" %>
<%
    Course course = (Course) request.getAttribute("course");
    String instructorName = (String) request.getAttribute("instructorName"); 
    if (course == null) {
        out.println("<h2>Course not found!</h2>");
        return;
    }
    String base64Image = "";
    if (course.getThumbnail() != null) {
        base64Image = Base64.getEncoder().encodeToString(course.getThumbnail());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= course.getTitle() %> | E-Learning</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        /* ----- Layout tổng thể ----- */
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: #f7f7f7;
        }
        header {
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 50px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .logo {
            font-weight: bold;
            font-size: 22px;
            color: #007bff;
        }
        .search-bar input {
            width: 300px;
            padding: 7px 10px;
            border: 1px solid #ccc;
            border-radius: 20px;
        }
        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .nav-right a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        /* ----- Banner ----- */
        .banner {
            background: linear-gradient(90deg, #007bff, #00b4d8);
            color: white;
            text-align: center;
            padding: 40px 0;
            font-size: 24px;
            font-weight: 600;
        }

        /* ----- Chi tiết khóa học ----- */
        .course-container {
            display: flex;
            gap: 40px;
            padding: 40px 80px;
            background: white;
            margin: 30px auto;
            width: 85%;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .course-left img {
            width: 420px;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
        .course-right {
            flex: 1;
        }
        .course-title {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .instructor {
            font-size: 15px;
            color: gray;
            margin-bottom: 15px;
        }
        .price {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 25px;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-enroll {
            background-color: #007bff;
            color: white;
            margin-right: 10px;
        }
        .btn-cart {
            background-color: #f0f0f0;
        }

        /* ----- Tabs (Description, Curriculum, Instructor) ----- */
        .tabs {
            width: 85%;
            margin: 20px auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .tabs h3 {
            border-left: 4px solid #007bff;
            padding-left: 10px;
            font-size: 20px;
        }
        .tabs p {
            line-height: 1.7;
            color: #444;
        }

        /* ----- Related Courses ----- */
        .related {
            width: 85%;
            margin: 40px auto;
        }
        .related h3 {
            font-size: 22px;
            margin-bottom: 15px;
        }
        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }
        .related-item {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            overflow: hidden;
            text-align: center;
            transition: transform .2s;
        }
        .related-item:hover { transform: scale(1.03); }
        .related-item img {
            width: 100%;
            height: 140px;
            object-fit: cover;
        }
        .related-item h4 {
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>

    <!-- ===== HEADER ===== -->
    <header>
        <div class="logo">E-Learning</div>
        <div class="search-bar">
            <input type="text" placeholder="Search courses...">
        </div>
        <div class="nav-right">
            <a href="#">Learner</a>
            <a href="#">Instructor</a>
            <a href="#">🔔</a>
            <a href="#">🛒</a>
            <a href="#">👤</a>
        </div>
    </header>

    <!-- ===== BANNER ===== -->
    <div class="banner">Course Detail</div>

    <!-- ===== COURSE DETAIL ===== -->
    <div class="course-container">
        <div class="course-left">
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Course Thumbnail">
        </div>
        <div class="course-right">
            <div class="course-title"><%= course.getTitle() %></div>
            <div class="instructor">By <%= instructorName != null ? instructorName : "Unknown Instructor" %></div>
            <div class="price">$<%= course.getPrice() %></div>
            <button class="btn btn-enroll">Enroll Now</button>
            <button class="btn btn-cart">Add to Cart</button>
            <p style="margin-top:20px;"><%= course.getDescription() %></p>
        </div>
    </div>

    <!-- ===== TABS ===== -->
    <div class="tabs">
        <h3>Course Description</h3>
        <p><%= course.getDescription() %></p>

        <h3>Curriculum</h3>
        <p>Coming soon: list of lessons...</p>

        <h3>Instructor</h3>
        <p>Instructor details and other courses will appear here.</p>
    </div>

    <!-- ===== RELATED COURSES ===== -->
    <div class="related">
        <h3>Related Courses</h3>
        <div class="related-grid">
            <div class="related-item">
                <img src="assets/img/sample1.jpg" alt="Course 1">
                <h4>Java for Beginners</h4>
            </div>
            <div class="related-item">
                <img src="assets/img/sample2.jpg" alt="Course 2">
                <h4>Advanced Python</h4>
            </div>
            <div class="related-item">
                <img src="assets/img/sample3.jpg" alt="Course 3">
                <h4>Web Development Bootcamp</h4>
            </div>
        </div>
    </div>

</body>
</html>
