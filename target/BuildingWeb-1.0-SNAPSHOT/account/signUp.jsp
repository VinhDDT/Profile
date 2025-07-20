<%-- 
    Document   : signUp
    Created on : Apr 30, 2025, 4:21:41 PM
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
        <form action="SignUp" method="post">
            <label  >Name</label>
            <br>
            <input name="tk" type="text"> 
            <br>
            <label>Email</label>
            <br>
            <input name="email" type="text" 
                   pattern="[a-zA-Z0-9._%+-]+@gmail\.com" 
                   required 
                   title="Vui lòng nhập địa chỉ Gmail hợp lệ (ví dụ: example@gmail.com)">

            <br>
            <label>password</label>
            <br>
            <input name="pas" type="password"> 
            <br>
            <input  name="sub" type="submit"/>
        </form>
    </body>
</html>
