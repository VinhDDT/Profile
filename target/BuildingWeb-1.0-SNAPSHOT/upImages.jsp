<%-- 
    Document   : upImages
    Created on : May 1, 2025, 5:23:25 AM
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
     <form action="UpImage" method="post" enctype="multipart/form-data">
        Chọn ảnh: <input type="file" name="image"><br>
        <input type="submit" value="Tải lên">
    </form>
    
    </body>
</html>
