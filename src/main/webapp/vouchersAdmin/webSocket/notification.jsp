<%-- 
    Document   : notification
    Created on : May 29, 2025, 5:19:27 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- WebContent/index.html hoặc src/main/webapp/index.html -->
<!DOCTYPE html>
<html>
<head><title>Gửi Notification</title></head>
<body>
<h2>Gửi Notification (Trang gửi)</h2>
<!-- Admin gửi từ JSP qua Servlet -->
<!--<form action="/Notification" method="post">
    <div>Nội dung</div>
    <input name="msg">
    
    <div>Id</div>
    <input name="receiver">
    <button>Gửi</button>
</form>-->

<input id="msg" placeholder="Nhập tin nhắn"/>
<button onclick="send()">Gửi</button>
<p id="status"></p>

<script>
    let ws = new WebSocket('ws://' + window.location.host + '<%=request.getContextPath()%>/notification');

    ws.onopen = () => document.getElementById('status').innerText = "Đã kết nối WebSocket";
    ws.onclose = () => document.getElementById('status').innerText = "WebSocket đóng";
    ws.onerror = () => document.getElementById('status').innerText = "Lỗi WebSocket";

    function send() {
        const msg = document.getElementById('msg').value;   
        if (ws.readyState === WebSocket.OPEN) {
            ws.send(msg);// gửi đến sever websoket ( endpoint)
            document.getElementById('status').innerText = "Đã gửi: " + msg;
            document.getElementById('msg').value = "";
        } else {
            alert('WebSocket chưa kết nối');
        }
    }
</script>
</body>
</html>
