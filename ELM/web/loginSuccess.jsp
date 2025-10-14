<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #a0e0ff, #e0f7fa);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        .container {
            text-align: center;
            background: white;
            padding: 40px 60px;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #0077cc;
        }
        p {
            color: #333;
            margin-top: 10px;
        }
        .countdown {
            font-weight: bold;
            color: #ff6600;
        }
    </style>
    <script>
        let seconds = 5;
        function countdown() {
            document.getElementById("timer").innerText = seconds;
            if (seconds === 0) {
                // Redirect sau 5s
                window.location.href = "index.jsp"; // đổi thành trang bạn muốn
            } else {
                seconds--;
                setTimeout(countdown, 1000);
            }
        }
        window.onload = countdown;
    </script>
</head>
<body>
    <div class="container">
        <h1>🎉 Login Successful!</h1>
        <p>Welcome, <strong><%= session.getAttribute("username") %></strong>!</p>
        <p>You will be redirected to the home page in 
           <span class="countdown" id="timer">5</span> seconds...</p>
    </div>
</body>
</html>
