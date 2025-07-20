<%-- 
    Document   : listRoom
    Created on : May 6, 2025, 2:52:12 PM
    Author     : Kiá»u HoÃ ng Máº¡nh Khang - ce180749 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
        <link rel="stylesheet" href="../css/viewRooms.css"/>

    </head>
    <body>


        <div class="SearchHeader">      
            <%@include file="../header/header.jsp" %>
        </div>
        <br>
        <br>
        <div class="form-row">
            <div class="form-group">
                <label for="location">Location</label>
                <select onchange="search()" id="location" name="location">
                    <option value="">-- Select Location --</option>
                    <option value="Can Tho">Cần Thơ</option>
                    <!--                    <option value="Vung Tau">Vũng Tàu</option>-->
                </select>
            </div>

            <div class="form-group">
                <label for="checkIn">Check-in</label>
                <input oninput="search()" type="date" id="checkIn" name="checkIn" >
            </div>

            <div class="form-group">
                <label for="checkOut">Check-out</label>
                <input oninput="search()" type="date" id="checkOut" name="checkOut" >
            </div>

            <div class="form-group">
                <label for="adults">Adults</label>
                <input  oninput="search()" type="number" id="adults" name="adults" min="1" value="1">
            </div>

            <div class="form-group">
                <label for="children">Childrens</label>
                <input  oninput="search()" type="number" id="children" name="children" min="0" value="0">
            </div>

        </div>

        <h1>Hotel Rooms</h1>
        <div class="product-grid" id="product" role="list">
            <c:forEach var="room" items="${list}">
                <a href="ViewRoomDetail?id=${room.roomId}"  style="text-decoration: none;">
                    <article class="card" role="listitem" tabindex="0" aria-label="">
                        <img src="${room.imageUrl}" alt="" />
                        <div class="card-content">
                            <h2 class="room-title">${room.roomType}</h2>
                            <p class="room-desc">${room.description}</p>
                            <div class="price">${room.price} / Night</div>
                            <button class="btn-book" aria-label="">View Details</button>
                        </div>
                    </article>
                </a>
            </c:forEach>
        </div>
        <div>
            <button id="loadmore-btn" onclick="loadMore()">See More ${finalRooms} Rooms</button>
        </div>
        <script src="../js/viewRooms.js"></script>
        <script>

        document.addEventListener('DOMContentLoaded', function () {
            const prices = document.getElementsByClassName("price");
            for (let i = 0; i < prices.length; i++) {
                const raw = prices[i].textContent.trim().replace(/[^\d]/g, '');
                const number = parseInt(raw);
                if (!isNaN(number)) {
                    prices[i].textContent = number.toLocaleString("vi-VN") + " VNĐ / Night";
                }
            }
        });


        function formatAfterAjax() {
            const prices = document.getElementsByClassName("price");
            for (let i = 0; i < prices.length; i++) {
                const raw = prices[i].textContent.trim().replace(/[^\d]/g, '');
                const number = parseInt(raw);
                if (!isNaN(number)) {
                    prices[i].textContent = number.toLocaleString("vi-VN") + " VNĐ / Night";
                }
            }
        }
        </script>

    </body>

</html>
