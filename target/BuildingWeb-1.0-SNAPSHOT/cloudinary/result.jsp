<%-- 
    Document   : result
    Created on : Jun 17, 2025, 8:40:32 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <h2>Ảnh đã tải lên:</h2>
    <img src="${imageUrl}" alt="Ảnh từ Cloudinary" style="max-width:400px;">
    <br><a href="upload.jsp">Upload ảnh khác</a>
</body>
</html>
