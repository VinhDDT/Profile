<%-- 
    Document   : takeNotification
    Created on : May 31, 2025, 12:12:57 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Nhận Notification</title></head>
<body>
<h2>Nhận Notification (Trang nhận)</h2>

<div id="notifications" style="border:1px solid #ccc; padding:5px; width:300px; height:200px; overflow:auto;"></div>

<script>
    let ws = new WebSocket('ws://' + window.location.host + '<%=request.getContextPath()%>/notification');
    let notiDiv = document.getElementById('notifications');

    ws.onopen = () => {
        notiDiv.innerHTML += '<p><i>Đã kết nối WebSocket</i></p>';
    };
    ws.onmessage = (e) => {
        notiDiv.innerHTML += '<p>' + e.data + '</p>';
        notiDiv.scrollTop = notiDiv.scrollHeight;
    };
    ws.onclose = () => {
        notiDiv.innerHTML += '<p><i>WebSocket đóng</i></p>';
    };
    ws.onerror = () => {
        notiDiv.innerHTML += '<p><i>Lỗi WebSocket</i></p>';
    };
</script>
</body>
</html>

