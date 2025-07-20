<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Notification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        .status {
            font-weight: bold;
            margin-bottom: 15px;
            color: green;
        }

        .notification {
            background-color: #eef;
            padding: 12px;
            border-left: 4px solid #2196f3;
            border-radius: 6px;
            color: #333;
        }
    </style>
</head>
<body>
    <h2>🔔 Chào bạn, đang lắng nghe thông báo...</h2>
    <p id="status" class="status">🟡 Đang kết nối tới máy chủ...</p>
    <p id="notification" class="notification">Chưa có thông báo nào.</p>

    <script>
        const status = document.getElementById("status");
        const noti = document.getElementById("notification");

        const socket = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/notification");

        socket.onopen = function () {
             console.log("✅ WebSocket connection opened");
            status.textContent = "🟢 Đã kết nối WebSocket!";
            status.style.color = "green";
        };

        socket.onerror = function (error) {
            status.textContent = "🔴 Lỗi WebSocket!";
            status.style.color = "red";
        };

        socket.onclose = function () {
            status.textContent = "⚠️ Kết nối đã đóng.";
            status.style.color = "orange";
        };

        socket.onmessage = function (event) {
            noti.textContent = "🔔 " + event.data;
               console.log(event.data);
        };
    </script>
</body>
</html>
