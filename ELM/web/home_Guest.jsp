<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SecretCoder | Learn Online Free</title>

    <!-- Bootstrap & Google Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --main-orange: #ff6600;
            --dark-orange: #e85500;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Navbar */
        .navbar {
            background-color: #fff !important;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .navbar-brand span {
            color: var(--main-orange);
        }

        .nav-link {
            color: #333 !important;
            font-weight: 500;
            margin-right: 1rem;
            transition: color 0.3s;
        }

        .nav-link:hover,
        .nav-link.active {
            color: var(--main-orange) !important;
        }

        /* Hero Section */
        .hero {
            position: relative;
            background: url('assets/images/banner-bg.jpg') center center/cover no-repeat;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: left;
        }

        .hero::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.55);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
            padding: 20px;
        }

        .hero p.lead {
            color: var(--main-orange);
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 1rem;
            letter-spacing: 1px;
        }

        .hero h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            line-height: 1.3;
        }

        .hero p.description {
            font-size: 1rem;
            margin-bottom: 2rem;
            color: #eee;
        }

        /* Buttons */
        .btn-orange {
            background-color: var(--main-orange);
            color: white;
            font-weight: 600;
            border: none;
            padding: 0.8rem 1.8rem;
            border-radius: 50px;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn-orange:hover {
            background-color: var(--dark-orange);
            transform: translateY(-2px);
        }

        .btn-outline-light {
            border-radius: 50px;
            font-weight: 600;
            padding: 0.8rem 1.8rem;
        }

        footer {
            background-color: #111;
            color: #ccc;
            padding: 1.5rem 0;
            text-align: center;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#"><strong>Secret<span>Coder</span></strong></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Courses</a></li>
                <li class="nav-item"><a class="nav-link" href="#">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="login">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-person-circle"></i></a></li>
                
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <p class="lead">Best E-Learning Platform</p>
        <h1>Learn Job-Ready Skills from <br> Free Online Courses with Certificates</h1>
        <p class="description">Explore a wide range of courses designed to enhance your expertise
            in technology, business, arts, and more. Start learning today!</p>
        <div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>© 2025 SecretCoder. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
