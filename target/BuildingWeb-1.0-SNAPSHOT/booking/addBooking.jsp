<%-- 
    Document   : addBooking
    Created on : Jun 25, 2025, 4:01:02 PM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Room Booking</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
        <link rel="stylesheet" href="../css/viewRooms.css"/>
    </head>
    <body>

        <div class="SearchHeader">      
            <%@include file="../header/header.jsp" %>
        </div>
        <br><br>

        <div class="form-row">
            <div class="form-group">
                <label for="location">Location</label>
                <select onchange="search()" id="location" name="location">
                    <option value="">-- Select Location --</option>
                    <option value="Can Tho">Cần Thơ</option>
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
                <input oninput="search()" type="number" id="adults" name="adults" min="1" value="1">
            </div>

            <div class="form-group">
                <label for="children">Children</label>
                <input oninput="search()" type="number" id="children" name="children" min="0" value="0">
            </div>
        </div>

        <h1>Available Hotel Rooms (Staff Mode)</h1>
        <div class="product-grid" id="product" role="list">
            <!-- Nội dung phòng sẽ được load bằng Ajax -->
        </div>

        <script>
            function search() {
                const location = $('#location').val();
                const checkIn = $('#checkIn').val();
                const checkOut = $('#checkOut').val();
                const adults = $('#adults').val();
                const children = $('#children').val();

                $.ajax({
                    url: '../staff/searchRooms',
                    method: 'GET',
                    data: {
                        location,
                        checkIn,
                        checkOut,
                        adults,
                        children
                    },
                    success: function (rooms) {
                        let html = '';
                        rooms.forEach(room => {
                            html += `
                            <a href="ViewRoomDetail?id=${room.roomId}" style="text-decoration: none;">
                                <article class="card" role="listitem" tabindex="0">
                                    <img src="${room.imageUrl}" alt="Room image" />
                                    <div class="card-content">
                                        <h2 class="room-title">${room.roomType}</h2>
                                        <p class="room-desc">${room.description}</p>
                                        <div class="price">${room.price} / Night</div>
                                        <button class="btn-book">Book Now</button>
                                    </div>
                                </article>
                            </a>`;
                        });
                        $('#product').html(html);
                        formatAfterAjax();
                    },
                    error: function () {
                        alert("Không thể tải dữ liệu phòng. Vui lòng kiểm tra đăng nhập hoặc dữ liệu nhập.");
                    }
                });
            }

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

