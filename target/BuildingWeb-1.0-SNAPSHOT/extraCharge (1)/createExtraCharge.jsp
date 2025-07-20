<%-- 
    Document   : createExtraCharge
    Created on : 17 Jul 2025, 01:36:52
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Extra Charge</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            .container {
                max-width: 800px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px 25px;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                border-top: 6px solid #4a6fa5;
                position: relative;
            }

            .back-button {
                position: absolute;
                top: -35px;
                left: 10px;
                background-color: #4a6fa5;
                color: white;
                padding: 6px 10px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #3a5c88;
            }

            h1 {
                text-align: center;
                color: #1a237e;
                font-size: 26px;
                margin-bottom: 25px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
            }

            select,
            input[type="number"],
            input[type="text"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                background-color: #fdfdfd;
                transition: border 0.2s;
            }

            select:focus,
            input:focus {
                border-color: #1a237e;
                outline: none;
            }

            .info-box {
                margin-bottom: 20px;
                font-size: 16px;
            }

            button {
                background-color: #1a237e;
                color: white;
                padding: 12px;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0d154d;
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="content">
            <div class="container">
                <a href="javascript:history.back()" class="back-button"><i class="fa-solid fa-arrow-left"></i> Back</a>
                <h1><i class="fa-solid fa-circle-plus"></i> Create Extra Charge</h1>

                <!-- Alert popup nếu có status -->
                <c:if test="${not empty status}">
                    <script>
                        alert("${status}");
                        window.location.href = "ViewAllExtraCharge";
                    </script>
                </c:if>

                <!-- Form chọn booking -->
                <form method="post" action="CreateExtraCharge">
                    <label>Choose Room:</label>
                    <select name="bookingId" onchange="updateRoomId(this)">
                        <c:forEach var="b" items="${activeBookings}">
                            <option value="${b.bookingId}" data-roomid="${b.roomId}"
                                    <c:if test="${selectedBooking.bookingId == b.bookingId}">selected</c:if>>
                                Room ${b.rooms.roomNumber}
                            </option>
                        </c:forEach>
                    </select>
                    <input type="hidden" id="roomId" name="roomId" value="${selectedBooking.roomId}" />
                    <button type="submit" name="action" value="check"><i class="fa-solid fa-magnifying-glass"></i> Check Extend Limit</button>
                </form>

                <!-- Nếu đã check giới hạn thời gian -->
                <c:if test="${not empty maxExtendDate}">
                    <hr>
                    <div class="info-box">
                        <strong>Max Extend Until:</strong> ${maxExtendDate}
                    </div>

                    <!-- Hiển thị đơn giá -->
                    <div class="info-box">
                        <strong>Unit Prices:</strong><br/>
                        <ul>
                            <li>Per Hour: <strong>${hourlyPrice} VND</strong></li>
                            <li>Per Day: <strong>${roomPrice} VND</strong></li>
                        </ul>
                    </div>

                    <!-- Form tạo extra charge -->
                    <form method="post" action="CreateExtraCharge" onsubmit="return validateHours();">
                        <input type="hidden" name="bookingId" value="${selectedBooking.bookingId}" />
                        <input type="hidden" name="roomId" value="${selectedBooking.roomId}" />
                        <input type="hidden" id="startDate" value="${selectedBooking.endDate}" />
                        <input type="hidden" id="maxDate" value="${maxExtendDate}" />
                        <input type="hidden" id="unitPriceHour" value="${hourlyPrice}" />
                        <input type="hidden" id="unitPriceDay" value="${roomPrice}" />

                        <label>Charge Type:</label>
                        <select name="chargeType" id="chargeType" required>
                            <option value="Late Hour">Late Hour</option>
                            <option value="Extra Hour">Extra Hour</option>
                            <option value="Extra Day">Extra Day</option>
                        </select>

                        <label>Enter hours to extend:</label>
                        <input type="number" id="extendHours" name="extendHours" min="1" step="1" required pattern="\\d+" />

                        <p><strong>Total Price Preview:</strong> <span id="pricePreview">0</span> VND</p>

                        <button type="submit" name="action" value="extend"><i class="fa-solid fa-plus"></i> Create ExtraCharge</button>
                    </form>
                </c:if>
            </div>
        </div>

        <script>
            function updateRoomId(select) {
                const roomId = select.options[select.selectedIndex].getAttribute("data-roomid");
                document.getElementById("roomId").value = roomId;
            }

            function validateHours() {
                const hoursInput = document.getElementById("extendHours");
                const hours = parseInt(hoursInput.value);

                if (isNaN(hours) || hours < 1 || !Number.isInteger(hours)) {
                    alert("Please enter a valid positive whole number for hours.");
                    hoursInput.focus();
                    return false;
                }

                const startDate = new Date(document.getElementById("startDate").value);
                const maxDate = new Date(document.getElementById("maxDate").value);
                const extendedDate = new Date(startDate.getTime() + hours * 60 * 60 * 1000);

                if (extendedDate > maxDate) {
                    alert("You cannot extend past the allowed time limit.");
                    return false;
                }
                return true;
            }


            function updatePriceDisplay() {
                const hours = parseInt(document.getElementById("extendHours").value) || 0;
                const chargeType = document.getElementById("chargeType").value;
                const unitHour = parseInt(document.getElementById("unitPriceHour").value);
                const unitDay = parseInt(document.getElementById("unitPriceDay").value);

                let total = 0;
                if (chargeType === "Extra Day") {
                    const days = Math.ceil(hours / 24);
                    total = unitDay * days;
                } else {
                    total = unitHour * hours;
                }

                document.getElementById("pricePreview").innerText = isNaN(total) ? "0" : total.toLocaleString();
            }

            window.onload = function () {
                const select = document.querySelector("select[name='bookingId']");
                if (select)
                    updateRoomId(select);

                const extendHours = document.getElementById("extendHours");
                const chargeType = document.getElementById("chargeType");

                if (extendHours)
                    extendHours.addEventListener("input", updatePriceDisplay);
                if (chargeType)
                    chargeType.addEventListener("change", updatePriceDisplay);
            };
        </script>
    </body>
</html>
