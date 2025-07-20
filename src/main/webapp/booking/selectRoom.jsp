<%-- 
    Document   : selectRoom
    Created on : Jul 1, 2025, 3:14:36 PM
    Author     : Dương Đinh Thế Vinh CE180441
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Phòng trống</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                padding: 20px;
            }

            .booking-section {
                background: #fff;
                border-radius: 10px;
                padding: 25px 30px;
                margin-bottom: 30px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            .booking-date-form {
                display: flex;
                align-items: flex-end;
                gap: 20px;
                flex-wrap: wrap;
                margin-top: 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                min-width: 250px;
                flex: 1;
            }

            .form-group label {
                font-weight: 600;
                margin-bottom: 6px;
                color: #2c3e50;
            }

            .form-group input[type="date"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
            }

            .form-group-btn {
                display: flex;
                align-items: flex-end;
            }

            .search-room-btn {
                padding: 12px 24px;
                background-color: #3498db;
                color: white;
                border: none;
                font-weight: bold;
                border-radius: 8px;
                font-size: 14px;
                transition: background-color 0.3s ease;
                white-space: nowrap;
            }

            .search-room-btn:hover {
                background-color: #2980b9;
            }



            .date-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-top: 15px;
            }

            .date-form input[type="date"] {
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ccc;
            }

            .search-btn {
                background-color: #3498db;
                color: #fff;
                padding: 10px;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .search-btn:hover {
                background-color: #2980b9;
            }

            .error-message {
                color: red;
                margin-top: 10px;
            }

            .floor-heading {
                margin-top: 30px;
                color: #2c3e50;
                font-size: 20px;
                border-bottom: 1px solid #ccc;
                padding-bottom: 5px;
            }

            .room-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 15px;
            }

            .room-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                width: 260px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            .room-card p {
                margin: 8px 0;
            }

            .confirm-btn {
                background-color: #2ecc71;
                color: white;
                padding: 10px 15px;
                border-radius: 6px;
                border: none;
                margin-top: 10px;
                cursor: pointer;
                font-weight: bold;
                width: 100%;
            }

            .confirm-btn:hover {
                background-color: #27ae60;
            }

        </style>
    </head>
    <body>
        
        
        
        <c:if test="${noRoomTypeAlert}">
            <script>
                window.onload = function () {
                    alert("❌ No rooms of this type are available for the selected date range.");
                };
            </script>
        </c:if>
            <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>
    
        <div class="booking-section">
            <h2>📅 Booking time information</h2>

            <form action="SelectRoom" method="post" class="booking-date-form">
                <input type="hidden" name="bookingId" value="${bookingId}" />
                <input type="hidden" name="roomType" value="${room.roomType}" />


                <div class="form-group">
                    <label for="customStart">📅 <strong>Check-in date:</strong></label>
                    <input type="date" id="customStart" name="customStartDate"
                           value="${not empty customStart ? customStart : startDate}" required />
                </div>

                <div class="form-group">
                    <label for="customEnd">🏁 <strong>Check-out date:</strong></label>
                    <input type="date" id="customEnd" name="customEndDate"
                           value="${not empty customEnd ? customEnd : endDate}" required />
                </div>

                <div class="form-group-btn">
                    <button type="submit" class="search-room-btn">🔍 Find available rooms</button>
                </div>
            </form>



            <c:forEach var="floorEntry" items="${roomsByFloor}">
                <h3 class="floor-heading">Floor ${floorEntry.key}</h3>
                <div class="room-grid">
                    <c:forEach var="room" items="${floorEntry.value}">
                        <div class="room-card">
                            <p><strong>Room:</strong> ${room.roomNumber}</p>
                            <p><strong>Room type:</strong> ${room.roomType}</p>
                            <p><strong>Price:</strong> ${room.price}₫</p>
                            <form action="BookingConfirmation" method="post">
                                <input type="hidden" name="roomId" value="${room.roomId}" />
                                <input type="hidden" name="bookingId" value="${bookingId}" />
                                <input type="hidden" name="actionType" value="confirmBooking" />
                                <button type="submit" class="confirm-btn">✔️ Select Room</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>



    </body>

</html>
