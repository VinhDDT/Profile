<%-- 
    Document   : selectRoom
    Created on : Jul 16, 2025, 5:32:46 AM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chọn Phòng Cho Check-In</title>


        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %></head>
    <style>

        body
        {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .main-content {
            max-width: 900px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        table thead {
            background-color: #4a6fa5;
            color: white;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .btn-submit {
            display: inline-block;
            padding: 10px 25px;
            margin: 10px;
            background-color: #4a6fa5;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s ease;
            font-size: 16px;
        }

        .btn-submit:hover {
            background-color: #3a5c88;
        }

        input[type="radio"] {
            transform: scale(1.3);
        }
    </style>

    <body>
        <div class="main-content">
            <h2>Select Room for Check-In</h2>
            <form action="SelectAvailableRoom" method="post">
                <input type="hidden" name="bookingId" value="${bookingId}">
                <input type="hidden" name="actualGuests" value="${actualGuests}">
                <table border="1" style="width: 100%; text-align: center;">
                    <thead>
                        <tr>

                            <th>Floor</th>
                            <th>Room Type</th>

                            <th>Price</th>
                            <th>Select</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="room" items="${availableRooms}">
                            <tr>

                                <td>${room.floorNumber}</td>
                                <td>${room.roomType}</td>

                                <td>${room.price} VND</td>
                                <td>
                                    <input type="radio" name="roomId" value="${room.roomId}" required>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <button type="submit" class="btn-submit">Confirm Room Selection</button>
                <a href="ViewAllCheckInOutDashboard" class="btn-submit" style="background-color: #dc3545;">Cancel</a>
            </form>
        </div>
    </body>
</html>
