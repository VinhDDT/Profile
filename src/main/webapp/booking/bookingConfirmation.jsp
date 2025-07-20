<%-- 
    Document   : bookingConfirmation
    Created on : Jun 18, 2025, 1:00:51 AM
    Author     : Dương Đinh Thế Vinh CE180441
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking List</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
                color: #333;
            }
            .content-wrapper {
                padding: 20px;
                transition: margin 0.3s ease, transform 0.3s ease;
            }
            #sidebar.open ~ .content-wrapper {
                margin-left: 200px;
                transform: scale(0.95);
            }
            #navbar.open ~ .content-wrapper {
                margin-top: 60px;
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            form {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }
            input, select, button {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 14px;
                background-color: #fff;
                box-sizing: border-box;
            }
            button {
                border: none;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            button[type="submit"] {
                background-color: #3498db;
                color: #fff;
            }
            button[type="submit"]:hover {
                background-color: #2980b9;
            }
            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
                border-radius: 10px;
                overflow: hidden;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background: #000080;
                color: #fff;
                font-weight: 600;
            }
            tr.hidden-row {
                display: none;
            }
            /* Cancel modal styling */
            .cancel-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 10000;
            }
            .cancel-modal.active {
                display: flex;
            }
            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                width: 350px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }
            .modal-content textarea {
                width: 100%;
                border-radius: 6px;
                border: 1px solid #ccc;
                resize: none;
                font-size: 14px;
            }
            .modal-actions {
                margin-top: 15px;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }
            .modal-actions button:first-child {
                background-color: #e74c3c;
                color: #fff;
            }
            .modal-actions button:last-child {
                background-color: #bdc3c7;
                color: #fff;
            }
            .waiting {
                background-color: #f1c40f;
                color: #fff;
            }
            .confirmed {
                background-color: #2ecc71;
                color: #fff;
                padding: 5px;
                border-radius: 8px;
            }
            .cancel {
                background: #e74c3c;
                color: #fff;
            }
            .cancel:hover {
                background: #c0392b;
            }
            @media(max-width:768px){
                form{
                    flex-direction:column;
                }
                th,td{
                    font-size:13px;
                }
            }
            @media(max-width:600px){
                .table-responsive table{
                    min-width:0;
                }
                thead{
                    display:none;
                }
                tr,td{
                    display:block;
                    width:100%;
                }
                td{
                    padding-left:50%;
                    position:relative;
                    text-align:right;
                }
                td::before{
                    content:attr(data-label);
                    position:absolute;
                    left:15px;
                    width:45%;
                    padding-right:10px;
                    white-space:nowrap;
                    font-weight:bold;
                    text-align:left;
                }
            }

            .load-more-wrapper {
                text-align: center;
                margin-top: 20px;
            }

            .popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .popup-box {
                background: #fff;
                padding: 25px 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.3);
                text-align: center;
                font-size: 16px;
                max-width: 400px;
                width: 90%;
            }


            .popup-box p {
                margin-bottom: 15px;
            }

            .popup-box button {
                padding: 8px 16px;
                background-color: #3498db;
                border: none;
                color: white;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .popup-box button:hover {
                background-color: #2980b9;
            }


            .popup-close {
                background-color: #bdc3c7;
                color: white;
            }
            .popup-close:hover {
                background-color: #95a5a6;
            }


        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const rows = document.querySelectorAll('tbody tr');
                const btn = document.getElementById('loadMoreBtn');
                const initial = 10;
                rows.forEach((row, idx) => {
                    if (idx >= initial)
                        row.classList.add('hidden-row');
                });
                if (rows.length <= initial)
                    btn.style.display = 'none';
                btn.addEventListener('click', () => {
                    rows.forEach(row => row.classList.remove('hidden-row'));
                    btn.style.display = 'none';
                });
            });


            function openCancelModal(bookingId) {
                const modal = document.getElementById("cancelModal-" + bookingId);
                if (modal) {
                    modal.style.display = "flex";
                } else {
                    console.error("Modal not found for ID: " + bookingId);
                }
            }

            function closeCancelModal(bookingId) {
                const modal = document.getElementById("cancelModal-" + bookingId);
                if (modal) {
                    modal.style.display = "none";
                }
            }

            function confirmReason(bookingId) {
                const reason = document.getElementById("notesTextarea-" + bookingId).value.trim();
                if (!reason) {
                    alert("Please enter a reason for cancellation.");
                    return;
                }

                document.getElementById("notesInput-" + bookingId).value = reason;
                document.getElementById("cancelForm-" + bookingId).submit();
            }

            function showNoResultsPopup() {
                document.getElementById("noResultsPopup").style.display = "flex";
            }
            function closePopup() {
                document.getElementById("noResultsPopup").style.display = "none";
            }

            function removeNumbers(input) {
                input.value = input.value.replace(/[0-9]/g, ''); // Xóa toàn bộ chữ số
            }


            function openConfirmationPopup(bookingId) {
                document.getElementById("popup-confirm-" + bookingId).style.display = "flex";
            }
            function closePopup(bookingId) {
                document.getElementById("popup-confirm-" + bookingId).style.display = "none";
            }


            //sử lý seclect room
            function submitSelectRoom(bookingId) {
                const form = document.getElementById("selectRoomForm-" + bookingId);
                if (form)
                    form.submit();
            }
        </script>
    </head>
    <body>
        <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="content-wrapper">
            <c:if test="${sessionScope.bookingConfirmed}"><script>window.onload = () => alert('Booking confirmed!');</script><c:remove var="bookingConfirmed" scope="session"/></c:if>

                <h1>Booking Confirmation List</h1>

                <!-- báo lỗi hết loại phòng -->
            <c:if test="${noRoomTypeAlert}">
                <script>
                    alert("❌ There are no more rooms of this type available during the selected period!");
                </script>
            </c:if>

            <c:if test="${searched and noResult}"><script>window.onload = showNoResultsPopup;</script></c:if>
                <form action="BookingConfirmation" method="post">
                    Room Type: <input type="text" name="roomType" maxlength="30" title="Only letters" oninput="removeNumbers(this)" />
                    Full Name: <input type="text" name="fullName" maxlength="30" title="Only letters" oninput="removeNumbers(this)" />
                    Start Date: <input type="date" name="startDate" value="${startDate}" />
                End Date: <input type="date" name="endDate" value="${endDate}" />
                Status: <select name="status"><option value="">-- All --</option><option value="Waiting for processing" ${status=='Waiting for processing'?'selected':''}>Waiting</option><option value="Confirmed" ${status=='Confirmed'?'selected':''}>Confirmed</option></select>
                <button type="submit">Search</button>
            </form>
            <div class="table-responsive">
                <table>
                    <thead><tr><th>Room Type</th><th>Full Name</th><th>Start Date</th><th>End Date</th><th>Status</th><th>Cancel</th></tr></thead>
                    <tbody>
                        <c:forEach var="booking" items="${booking}">
                            <tr>
                                <td data-label="Room Number">${booking.roomType}</td>
                                <td data-label="Full Name">${booking.customers.fullName}</td>
                                <td data-label="Start Date">${booking.formattedStartDate}</td>
                                <td data-label="End Date">${booking.formattedEndDate}</td>

                                <td data-label="Status">
                                    <c:if test="${booking.status eq 'Waiting for processing'}">
                                        <button class="waiting" onclick="openConfirmationPopup(${booking.bookingId})">Waiting</button>

                                        <div id="popup-confirm-${booking.bookingId}" class="popup-overlay">
                                            <div class="popup-box">
                                                <p>How would you like to confirm this booking?</p>
                                                <!-- 2 nút xác nhận đơn chọn phòng -->
                                                <form method="post" action="BookingConfirmation">
                                                    <input type="hidden" name="actionType" value="goToSelectRoom" />
                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                    <button type="submit">🛏️ Select room</button>
                                                </form>

                                                <form method="post" action="BookingConfirmation">
                                                    <input type="hidden" name="actionType" value="confirmBooking" />
                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                    <button type="submit">✅ Confirm no room selection</button>
                                                </form>
                                                <button onclick="closePopup(${booking.bookingId})" class="popup-close">Close</button>
                                            </div>
                                        </div>

                                    </c:if>

                                    <c:if test="${booking.status eq 'Confirmed'}">
                                        <span class="confirmed">Confirmed</span>
                                    </c:if>
                                </td>

                                <!-- hủy booking -->
                                <td data-label="Cancel" style="text-align:center;">
                                    <!-- Form cancel -->
                                    <form id="cancelForm-${booking.bookingId}" action="BookingCancel" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                        <input type="hidden" name="notes" id="notesInput-${booking.bookingId}" />

                                        <!-- Nút Cancel duy nhất -->
                                        <button type="button" class="cancel" onclick="openCancelModal('${booking.bookingId}')">Cancel</button>
                                    </form>

                                    <!-- Modal nhập lý do -->
                                    <div id="cancelModal-${booking.bookingId}" class="cancel-modal">
                                        <div class="modal-content">
                                            <label for="notesTextarea-${booking.bookingId}">Reason for cancellation:</label>
                                            <textarea id="notesTextarea-${booking.bookingId}" placeholder="Enter reason..." rows="4"></textarea>
                                            <div class="modal-actions">
                                                <button type="button" onclick="confirmReason('${booking.bookingId}')">OK</button>
                                                <button type="button" onclick="closeCancelModal('${booking.bookingId}')">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="load-more-wrapper">
                <button id="loadMoreBtn" style="padding:8px 16px;">See more</button>
            </div>

            <div id="noResultsPopup" class="popup-overlay" style="display:none;"><div class="popup-box"><p>🔍 No matching results found!</p><button onclick="closePopup()">OK</button></div></div>
        </div>

    </body>
</html>
