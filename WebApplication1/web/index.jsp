<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In | Validation Checker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: "Poppins", sans-serif;
        }
        .card {
            width: 420px;
            border: none;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }
        .btn-primary {
            background: #667eea;
            border: none;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background: #5563c1;
        }
        .error-text {
            color: #e63946;
            font-size: 13px;
            margin-top: 4px;
        }
    </style>
</head>
<body>

<div class="card p-4 bg-white">
    <div class="text-center mb-4">
        <h3>Sign up</h3>
    </div>

    <form action="validate" method="post">
        <div class="mb-3">
            <label class="form-label">Email address</label>
            <input type="text" name="email" class="form-control" 
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   placeholder="example@gmail.com">
            <p class="error-text"><%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %></p>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" placeholder="••••••••••">
            <p class="error-text"><%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %></p>
        </div>

        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullname" class="form-control" 
                   value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>"
                   placeholder="Nguyen Van A">
            <p class="error-text"><%= request.getAttribute("fullnameError") != null ? request.getAttribute("fullnameError") : "" %></p>
        </div>

        <div class="mb-3">
            <label class="form-label">User ID</label>
            <input type="text" name="id" class="form-control"
                   value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : "" %>"
                   placeholder="SV202501">
            <p class="error-text"><%= request.getAttribute("idError") != null ? request.getAttribute("idError") : "" %></p>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2">Check Validation</button>
    </form>
</div>

</body>
</html>
