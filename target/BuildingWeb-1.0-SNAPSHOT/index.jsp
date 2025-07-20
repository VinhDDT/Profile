<%-- 
    Document   : index
    Created on : Apr 29, 2025, 4:23:56 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>

        <%@ include file="header/header.jsp" %>

        <!-- banner -->
        <section class="hero">
            <div class="overlay"></div>
            <div class="content">
                <h2>Away from monotonous life.</h2>
                <h1>Big Resort</h1>
                <p>If you are looking at blank cassettes on the web, you may be very confused <br>
                   at the difference in price. You may see some for as low as $.17 each.</p>
                <br>
                <a href="ViewRooms" class="btn">Booking</a>
            </div>
        </section>
        <!-- end banner -->

        <%@ include file="footer/footer.jsp" %>

        <script src="script.js"></script>
    </body>
</html>
