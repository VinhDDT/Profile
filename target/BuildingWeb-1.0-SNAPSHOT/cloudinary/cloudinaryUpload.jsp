<%-- 
    Document   : cloudinaryUpload
    Created on : Jun 17, 2025, 8:36:17 PM
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
        <form action="CloudinaryUpload" method="post" enctype="multipart/form-data">
            <p>Chọn ảnh upload (tùy chọn):</p>
            <input type="file" name="imageFile" /><br><br>

            <p>Hoặc nhập URL ảnh (tùy chọn):</p>
            <input type="text" name="imageUrl" /><br><br>

            <button type="submit">Upload</button>
        </form>


    </body>
</html>
