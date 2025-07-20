<%-- 
    Document   : notification
    Created on : May 29, 2025, 5:19:27 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- WebContent/index.html hoặc src/main/webapp/index.html -->
<!DOCTYPE html>
<%@ page session="true" %>
<html>
    <head><title>Admin Gửi Notification</title></head>
    <body>
        <h2>Gửi Notification</h2>
        <form id="formNoti" action="Notification" method="post">
            User ID: <input type="text" name="userId" required /><br/>
            Message: <input type="text" name="message" required /><br/>
            <button type="submit">Gửi</button>
        </form>
    </body>
</html>
