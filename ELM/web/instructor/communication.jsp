<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Communication Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        textarea {
            width: 100%;
            height: 120px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            resize: none;
            font-size: 15px;
        }
        button {
            width: fit-content;
            align-self: flex-end;
            background-color: #ff6600;
            color: white;
            font-weight: bold;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #e85500;
        }
        .messages {
            margin-top: 30px;
        }
        .msg {
            background-color: #f2f2f2;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 10px;
        }
        .msg strong {
            color: #ff6600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Communication with Instructor</h2>

        <!-- Form gửi tin nhắn -->
        <form action="CommunicationServlet" method="post">
            <label for="message">Enter your message:</label>
            <textarea name="message" id="message" placeholder="Type your question..."></textarea>
            <button type="submit">Send Message</button>
        </form>

        <!-- Hiển thị tin nhắn -->
        <div class="messages">
            <h3>Previous Messages:</h3>
            <%
                java.util.List<String> msgs = (java.util.List<String>) request.getAttribute("messages");
                if (msgs != null && !msgs.isEmpty()) {
                    for (String m : msgs) {
                        out.println("<div class='msg'><strong>Learner:</strong> " + m + "</div>");
                    }
                } else {
                    out.println("<p>No messages yet.</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
