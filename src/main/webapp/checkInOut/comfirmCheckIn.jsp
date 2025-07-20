<%-- 
    Document   : comfirmCheckIn
    Created on : Jul 3, 2025, 9:17:08 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Confirm Check-In</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

        <style>
            :root {
                --navy: #4a6fa5;
                --white: #ffffff;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f4f8;
                margin: 0;
                padding: 0;
                color: #333;
                transition: 0.3s ease-in-out;
            }
            .navbar {
                background-color: var(--navy);
                color: var(--white);
                padding: 0 30px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 60px;
            }
            .sidebar {
                background-color: var(--navy);
                color: white;
                width: 220px;
                position: fixed;
                top: 60px;
                bottom: 0;
                left: 0;
                padding: 20px 0;
                transition: all 0.3s ease;
            }
            .sidebar a {
                display: block;
                padding: 10px 20px;
                color: white;
                text-decoration: none;
                transition: 0.3s;
            }
            .sidebar a:hover {
                background-color: #3b5c8c;
            }
            .main-content {
                margin-left: 220px;
                padding: 80px 30px 40px;
                transition: margin-left 0.3s ease;
            }
            h2 {
                text-align: center;
                color: #002b5c;
                margin-bottom: 30px;
                font-size: 30px;
            }
            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                max-width: 700px;
                margin: 0 auto;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                margin: 10px 0 4px;
                font-weight: 600;
            }
            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            .extra-fee {
                color: red;
                font-weight: bold;
                margin: 10px 0;
            }
            .btn-submit {
                background-color: #007bff;
                color: #fff;
                padding: 10px 25px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s ease;
                display: inline-block;
                margin-right: 20px;
            }
            .btn-submit:hover {
                background-color: #0056b3;
            }
            .guest-input {
                display: flex;
                gap: 20px;
                align-items: flex-start;
                flex-wrap: wrap;
                margin-bottom: 10px;
            }
            .guest-input > div {
                flex: 1;
                min-width: 200px;
            }
            .guest-input input {
                width: 100%;
            }

            /* Popup error */
            .popup {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                background-color: #f44336;
                color: #fff;
                padding: 12px 24px;
                border-radius: 6px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                display: none;
                z-index: 9999;
                animation: fadeInOut 2.5s ease-in-out forwards;
            }

            @keyframes fadeInOut {
                0% {
                    opacity: 0;
                    transform: translateX(-50%) translateY(-20px);
                }
                10% {
                    opacity: 1;
                    transform: translateX(-50%) translateY(0);
                }
                90% {
                    opacity: 1;
                    transform: translateX(-50%) translateY(0);
                }
                100% {
                    opacity: 0;
                    transform: translateX(-50%) translateY(-20px);
                }
            }
        </style>

        <script>
            function showCCCDInputs() {
                var container = document.getElementById("cccdContainer");
                container.innerHTML = "";

                var maxOccupancy = parseInt(document.getElementById("maxOccupancy").value);
                var numberOfGuests = parseInt(document.getElementById("numberOfGuests").value);

                if (isNaN(numberOfGuests) || numberOfGuests < 1) {
                    numberOfGuests = 1;
                    document.getElementById("numberOfGuests").value = 1;
                }

                var extraFee = 0;
                if (numberOfGuests > maxOccupancy) {
                    extraFee = (numberOfGuests - maxOccupancy) * 100000;
                }
                document.getElementById("extraFeeText").innerText =
                        extraFee > 0 ? "+ Extra fee: " + extraFee.toLocaleString('en-US') + " VND" : "0 VND";

                for (var i = 1; i <= numberOfGuests; i++) {
                    var div = document.createElement("div");
                    div.className = "guest-input";
                    div.innerHTML = "<div><label>Full name of guest " + i + ":</label>" +
                            "<input type='text' name='guestName[]' required maxlength='50' placeholder='Full name (max 50 characters)'></div>" +
                            "<div><label>ID Number of guest " + i + " (CCCD):</label>" +
                            "<input type='text' name='cccd[]' required pattern='\\d{12}' minlength='12' maxlength='12' placeholder='12 digits'></div>";
                    container.appendChild(div);
                }
            }

            function validateUniqueCCCD() {
                const inputs = document.querySelectorAll('input[name^="cccd"]');
                const values = [];

                for (let input of inputs) {
                    const val = input.value.trim();
                    if (val === "")
                        continue;
                    if (values.includes(val)) {
                        showPopup("ID Number (CCCD) must not be duplicated.");
                        input.focus();
                        return false;
                    }
                    values.push(val);
                }
                return true;
            }

            function showPopup(message) {
                const popup = document.getElementById("popup");
                popup.innerText = message;
                popup.style.display = "block";
                setTimeout(() => {
                    popup.style.display = "none";
                }, 2500);
            }

            window.onload = function () {
                showCCCDInputs();
            };
        </script>
    </head>

    <body>
        <div id="popup" class="popup"></div>

        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>    

        <div class="main-content">
            <h2>Confirm Check-In</h2>
            <div class="container">
                <form action="${checkRoom == 0 ? 'SelectAvailableRoom' : 'ComfirmCheckIn'}"
                      method="${checkRoom == 0 ? 'get' : 'post'}"
                      onsubmit="return validateUniqueCCCD();">
                    <input type="hidden" name="bookingId" value="${bookingInfo.bookingId}">

                    <p><strong>Customer (Main Guest):</strong> ${bookingInfo.customers.fullName}</p>
                    <p><strong>Room type:</strong> ${bookingInfo.roomType}</p>

                    <c:choose>
                        <c:when test="${bookingInfo.roomType == 'Standard Room For One'}">
                            <input type="hidden" id="maxOccupancy" value="1">
                            <p><strong>Room maximum occupancy:</strong> 1</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Standard Room For Two'}">
                            <input type="hidden" id="maxOccupancy" value="2">
                            <p><strong>Room maximum occupancy:</strong> 2</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Deluxe Room For Two'}">
                            <input type="hidden" id="maxOccupancy" value="2">
                            <p><strong>Room maximum occupancy:</strong> 2</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Family Room For Three'}">
                            <input type="hidden" id="maxOccupancy" value="3">
                            <p><strong>Room maximum occupancy:</strong> 3</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Family Room For Four'}">
                            <input type="hidden" id="maxOccupancy" value="4">
                            <p><strong>Room maximum occupancy:</strong> 4</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Family Room For Five'}">
                            <input type="hidden" id="maxOccupancy" value="5">
                            <p><strong>Room maximum occupancy:</strong> 5</p>
                        </c:when>
                        <c:when test="${bookingInfo.roomType == 'Twin Room (2 Single Beds)'}">
                            <input type="hidden" id="maxOccupancy" value="2">
                            <p><strong>Room maximum occupancy:</strong> 2</p>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" id="maxOccupancy" value="0">
                            <p><strong>Room maximum occupancy:</strong> Unknown</p>
                        </c:otherwise>
                    </c:choose>


                    <label>Actual number of guests (including main guest):</label>
                    <input type="number" id="numberOfGuests" name="actualGuests"
                           min="1" max="10" required onchange="showCCCDInputs()"
                           value="${bookingInfo.rooms.maxOccupancy}">

                    <p class="extra-fee" id="extraFeeText">0 VND</p>

                    <div id="cccdContainer"></div>

                    <c:choose>
                        <c:when test="${checkRoom == 0}">
                            <button type="submit" class="btn-submit">Chọn phòng</button>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="checkRoom" value="${checkRoom}"/>
                            <button type="submit" class="btn-submit">Confirm Check-In</button>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>  

        </div>  
    </body>
</html>
