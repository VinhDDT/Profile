<%-- 
    Document   : confirmBooking
    Created on : Jun 14, 2025, 5:27:50 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Xác nhận đặt phòng - MyHotel</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"rel="stylesheet"/>


        <link  href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap"rel="stylesheet"/>
        <link rel="stylesheet" href="../css/confirmBooking.css"/>
    </head>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: whitesmoke;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #111827;
            margin: 0;
        }

        /* Header */
        header {
            background-color: #001f3f; /* navy blue */
            box-shadow: 0 4px 6px -1px rgba(0, 31, 63, 0.3), 0 2px 4px -1px rgba(0, 31, 63, 0.2);
            padding: 1.5rem 0;
        }

        header h1 {
            text-align: center;
            color: white;
            font-size: 1.875rem;
            font-weight: 800;
            letter-spacing: 0.025em;
            user-select: none;
            margin: 0;
        }

        /* Main content */
        main {
            padding: 3rem 10%;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 3rem;
        }

        /* Sections */
        .section-card {
            background-color: white;
            border-radius: 1.5rem;
            box-shadow: 0 20px 25px -5px rgba(0, 31, 63, 0.15), 0 10px 10px -5px rgba(0, 31, 63, 0.07);
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            box-sizing: border-box;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .section-title {
            font-size: 1.875rem;
            font-weight: 700;
            color: #001f3f; /* navy blue */
            margin-bottom: 2rem;
            border-bottom: 4px solid #003366; /* darker navy */
            padding-bottom: 0.75rem;
            user-select: none;
            display: flex;
            justify-content: center;
            transition: color 0.3s ease, letter-spacing 0.3s ease;
        }

        /* Room info grid */
        .room-info-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 4rem;
            align-items: center;
        }

        .room-info-item {
            margin-bottom: 1rem;
        }

        .room-info-label {
            font-size: 1.25rem;
            font-weight: 600;
            color: #001f3f; /* navy blue */
        }

        .room-info-value {
            font-weight: 400;
        }
        .img{
            display: flex;
            justify-content: center;
        }
        /* Room image */
        .room-image {
            border-radius: 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 31, 63, 0.15), 0 4px 6px -2px rgba(0, 31, 63, 0.07);
            object-fit: cover;
            width: 70%;
            margin-top: 3rem;
            height: 25rem;
            transition: transform 0.3s ease;
        }

        /* Form styles */
        #bookingForm {
            display: flex;
            flex-direction: column;
            gap: 2.5rem;
            flex-grow: 1;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(1, minmax(0, 1fr));
            gap: 2.5rem;
        }

        @media (min-width: 640px) {
            .form-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        .form-group {
            margin-bottom: 0.75rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.8rem;
            font-weight: 600;
            color: #001f3f; /* navy blue */
            font-size: 1.125rem;
            transition: color 0.3s ease;
        }

        .form-select, .form-textarea {
            width: 100%;
            border-radius: 1rem;
            border: 1px solid #99aabb; /* soft blue-gray */
            padding: 1.25rem 1.5rem;
            color: #001f3f; /* navy blue */
            font-weight: 600;
            box-sizing: border-box;
            background-color: #f0f4f8; /* very light blue */
            transition: all 0.3s ease;
        }

        .form-select:focus, .form-textarea:focus {
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 51, 102, 0.5); /* navy focus */
            border-color: #003366;
        }

        .form-textarea {
            resize: vertical;
            min-height: 6rem;
        }

        /* Services list */
        #servicesList {
            max-height: 15rem;
            overflow-y: auto;
            border-radius: 1rem;
            border: 1px solid #99aabb; /* soft blue-gray */
            background-color: #f0f4f8; /* very light blue */
            padding: 2rem;
            color: #001f3f; /* navy blue */
            font-weight: 600;
            font-size: 1.125rem;
        }

        #servicesList::-webkit-scrollbar {
            width: 8px;
        }

        #servicesList::-webkit-scrollbar-thumb {
            background-color: #003366; /* darker navy */
            border-radius: 4px;
        }

        .services-placeholder {
            font-style: italic;
            color: #003366; /* darker navy */
            user-select: text;
        }

        /* Buttons */
        .btn {
            font-weight: 700;
            padding: 1.25rem;
            border-radius: 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 31, 63, 0.15), 0 4px 6px -2px rgba(0, 31, 63, 0.07);
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            border: none;
            cursor: pointer;
        }

        .btn-services {
            background-color: #003366; /* darker navy */
            color: white;
            margin-bottom: 2rem;
        }

        .btn-services:hover {
            background-color: #001f3f; /* navy */
        }

        .btn-submit {
            background-color: #001f3f; /* navy */
            color: white;
            font-size: 1.5rem;
            padding: 1.5rem;
        }

        .btn-submit:hover {
            background-color: #000d1a; /* very dark navy */
        }

        /* Summary */
        #summary {
            background-color: #e6f0ff; /* very light blue */
            border-radius: 1.5rem;
            padding: 2.5rem;
            color: #001f3f; /* navy blue */
            font-weight: 800;
            font-size: 1.5rem;
            box-shadow: inset 0 2px 4px 0 rgba(0, 31, 63, 0.1);
            user-select: text;
        }

        .summary-item {
            margin-bottom: 1.25rem;
        }

        .summary-price {
            color: #003366; /* darker navy */
        }

        .summary-discount {
            color: #001f3f; /* navy blue */
        }

        .summary-total {
            margin-top: 2rem;
            color: #00264d; /* dark navy */
            font-size: 2.25rem;
            font-weight: 800;
        }

        /* Footer */
        footer {
            background-color: #001f3f; /* navy blue */
            color: white;
            text-align: center;
            padding: 1.25rem 0;
            user-select: none;
            font-size: 0.875rem;
            box-shadow: 0 -4px 6px -1px rgba(0, 31, 63, 0.3);
        }

        /* Dialog */
        dialog {
            border-radius: 1.5rem;
            padding: 2rem;
            max-width: 28rem;
            width: 100%;
            box-shadow: 0 25px 50px -12px rgba(0, 31, 63, 0.25);
            border: none;
        }

        .dialog-title {
            color: #001f3f; /* navy blue */
            font-size: 1.5rem;
            font-weight: 700;
            user-select: none;
            margin-bottom: 1.5rem;
        }

        .dialog-fieldset {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
            border: none;
            padding: 0;
            margin: 0;
        }

        .dialog-label {
            display: flex;
            align-items: center;
            gap: 1rem;
            cursor: pointer;
            user-select: none;
            color: #001f3f; /* navy blue */
            font-weight: 600;
            font-size: 1.125rem;
        }

        .dialog-checkbox {
            width: 1.5rem;
            height: 1.5rem;
            border-radius: 0.375rem;
            cursor: pointer;
            border: 1px solid #003366;
            background-color: white;
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }

        .dialog-checkbox:checked {
            background-color: #001f3f;
            border-color: #001f3f;
        }

        .dialog-menu {
            display: flex;
            justify-content: flex-end;
            gap: 1.5rem;
            padding-top: 1.5rem;
        }

        .dialog-btn {
            font-weight: 700;
            padding: 0.75rem 2rem;
            border-radius: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 31, 63, 0.15), 0 2px 4px -1px rgba(0, 31, 63, 0.07);
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .dialog-confirm {
            background-color: #001f3f;
            color: white;
        }

        .dialog-confirm:hover {
            background-color: #000d1a;
        }

        .dialog-cancel {
            background-color: #dc2626;
            color: white;
        }

        .dialog-cancel:hover {
            background-color: #b91c1c;
        }

        /* Responsive adjustments */
        @media (max-width: 1024px) {
            .section-card {
                padding: 2.5rem;
            }
        }

        @media (max-width: 768px) {
            main {
                padding: 2rem 8%;
            }

            .section-card {
                padding: 2rem;
            }

            .room-info-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
        }

        @media (max-width: 480px) {
            main {
                padding: 1.5rem 5%;
            }

            .section-card {
                padding: 1.5rem;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .btn-submit {
                font-size: 1.25rem;
                padding: 1.25rem;
            }
        }


        /* Hiệu ứng hover cho section-card */
        .section-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 30px 40px -10px rgba(0, 31, 63, 0.25);
        }

        /* Hiệu ứng hover cho ảnh */
        .room-image:hover {
            transform: scale(1.03);
        }

        /* Hiệu ứng hover cho form-select */
        .form-select:hover {
            border-color: #003366;
            box-shadow: 0 0 0 3px rgba(0, 51, 102, 0.5);
        }

        /* Hiệu ứng hover cho form-label */
        .form-label:hover {
            color: #003366;
        }
        /* Hover cho tiêu đề chính */
        .section-title:hover {
            color: #003366;
            letter-spacing: 1px;
        }

        /* Hover cho tên phòng */
        .room-title:hover {
            color: #001f3f;
            transform: scale(1.03);
            transition: color 0.3s ease, transform 0.3s ease;
        }

        /* Hover cho nút xác nhận */
        .btn:hover {
            background-color: #003366;
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 51, 102, 0.3);
        }


        .voucher-btn {
            width: 100%;
            border-radius: 1rem;
            border: 1px solid #99aabb;
            padding: 1.25rem 1.5rem;
            color: #001f3f;
            font-weight: 600;
            background-color: #f0f4f8;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .voucher-btn:hover {
            border-color: #003366;
            background-color: #e0ebf5;
            box-shadow: 0 0 0 4px rgba(0, 51, 102, 0.3);
        }
        .voucher-btn1 {
            background-color: #3EB489;
            color: white;
            border: 2px ;
            padding: 8px 16px;
            border-radius: 6px;
            margin-left: 12px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .voucher-btn1:hover {
            background-color: #349c76;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .voucher-group {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .voucher-btn,
        .voucher-btn1,
        .form-select {
            height: 3.5rem;
            padding: 0 1.2rem;
            font-size: 1rem;
            border-radius: 1rem;
            border: 1px solid #99aabb;
            box-sizing: border-box;
            font-weight: 600;
            background-color: #f0f4f8;
            color: #001f3f;
            min-width: 180px;
        }

        .voucher-btn1 {
            background-color: #ffffff;
            color: #007bff;
            border: 2px dashed #007bff;
            cursor: pointer;
            transition: 0.3s;
        }

        .voucher-btn1:hover {
            background-color: #e6f0ff;
        }

        .form-label {
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }


        .btn-cancel {
            display: inline-block;
            padding: 10px 20px;
            background-color: #dc3545; /* Màu đỏ */
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.2);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-cancel:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .btn-cancel:active {
            transform: scale(0.98);
        }

        .voucher-btn {
            display: inline-block;
            width: 100%;
            max-width: 400px;
            padding: 12px 16px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            color: #0b3954;
            background-color: #f3f7fb;
            border: 1px solid #a0bcd0;
            border-radius: 10px;
            box-sizing: border-box;
            cursor: pointer;
            text-decoration: none;
            line-height: 1.4;
            transition: background-color 0.3s ease;
        }

        .voucher-btn:hover {
            background-color: #e0edf8;
        }

        .btn-cancel {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 14px;
            background-color: #f44336;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .btn-cancel:hover {
            background-color: #d32f2f;
        }

        .voucher-group p {
            margin-top: 10px;
            font-size: 15px;
        }
        .form-select {
            display: block;
            width: 100%;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #0a2b44;
            background-color: #f2f6fa;
            border: 1px solid #c2d1e0;
            border-radius: 12px;
            appearance: none;
            text-align: center;
            text-align-last: center; /* Căn giữa option được chọn */
            cursor: pointer;
            transition: border 0.3s ease;
        }

        .form-select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.5);
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #0a2b44;
        }

        .form-group {
            margin-bottom: 20px;
        }

    </style>
    <body>
        <%@include file="../header/header.jsp" %>
        <br>
        <br>
        <main>
            <!-- Room Info -->
            <section class="section-card" aria-labelledby="room-info-title">
                <h2 class="section-title" id="room-info-title">
                    Room Information Currently Selected
                </h2>
                <div class="room-info-grid">
                    <div>
                        <p class="room-info-item">
                            <span class="room-info-label">Number Of Rooms:</span>
                            <span class="room-info-value">${room.roomNumber}</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Check-in Date:</span>
                            <span class="room-info-value">${checkIn}</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Number Of Guests:</span>
                            <span class="room-info-value">${adults+children}
                                <%--<c:choose>--%> 
                                <%--<c:when test="${adults >0 and children > 0}"> ${adults} Adults and ${children} Children )</c:when>--%>
                                <%--<c:when test="${adults >0 }"> ${adults} Adults )</c:when>--%>
                                <%--<c:otherwise>${children} Children )</c:otherwise>--%>
                                <%--</c:choose>--%>
                            </span>
                        </p>
                    </div>
                    <div>
                        <p class="room-info-item">
                            <span class="room-info-label">Room Type:</span>
                            <span class="room-info-value">${room.roomType}</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Check-out date:</span>
                            <span class="room-info-value">${checkOut}</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Bed:</span>
                            <span class="room-info-value">${room.bedType}</span>
                        </p>
                    </div>
                    <div>
                        <p class="room-info-item">
                            <span class="room-info-label">Price:</span>
                            <span class="room-info-value" id="price1" >${room.price} VND / Night</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Number Of Nights:</span>
                            <span class="room-info-value">${numberNight}</span>
                        </p>
                        <p class="room-info-item">
                            <span class="room-info-label">Cancellation policy: </span>
                            <span class="room-info-value">Free before 24 hours</span>
                        </p>
                    </div>
                </div>
                <div class="img">  <img 
                        alt="Phòng sang trọng với ánh sáng tự nhiên và trang trí hiện đại"
                        class="room-image"
                        height="400"
                        loading="lazy"
                        src="${room.imageUrl}"
                        width="100%"
                        /></div>
            </section>
            <!-- Booking & Payment -->
            <section class="section-card" aria-labelledby="booking-section-title">
                <h2 class="section-title" id="booking-section-title">
                    Booking & Payment Information
                </h2>



                <form class="form" action="ConfirmBooking" method="post" id="bookingForm">
                    <input  value="${room.roomType}" name="roomType" type="hidden">
                    <input value="${checkOut}" name="endDate" type="hidden">
                    <input value="${checkIn}" name="startDate" type="hidden">
                    <input value="${numberNight}" name="numberNight" type="hidden">
                    <div class="form-grid">
                        <!-- Chọn mã voucher - nằm trên cùng -->
                        <div class="form-group">
                            <!--<label  class="form-label">Select Voucher Code</label>-->
                            <div class="voucher-group">
                                <a id="Voucher" style="text-decoration: none" href="UserVouchers" class="voucher-btn">-- Select Voucher Code --</a>
                                <c:choose>

                                    <c:when test="${sessionScope.voucherCode != null}">
                                        <p>Voucher Code: ${sessionScope.voucherCode}</p>
                                        <a href="ConfirmBooking?voucherId=${sessionScope.voucherId}&check=cancel" class="btn-cancel">Cancel</a>


                                    </c:when>
                                    <c:otherwise>
                                        <p>No Choose Vouchers</p>
                                    </c:otherwise>

                                </c:choose>
                            </div>
                        </div>
                        <!-- Hạn mức thanh toán -->
                        <div class="form-group">
                            <!--<label class="form-label" for="limit">Select Payment Limit</label>-->
                            <select class="form-select" id="limit" name="limit" required>
                                <option value="full">-- Select Payment Limit --</option>
                                <option value="full">Full Payment</option>
                                <option value="50">50% down payment</option>
                                <option value="30">30% down payment</option>
                            </select>
                        </div>

                        <!-- Phương thức thanh toán -->
                        <div class="form-group">
                            <!--<label class="form-label" for="payment">Payment Method</label>-->
                            <select class="form-select" id="payment" name="payment" required>
                                <option value="">-- Payment Method --</option>
                                <option value="VNPay">Payment Via VNPay</option>

                                <!--<option id="cod" value="cod">Cash On Delivery</option>-->
                                <!--<option value="momo">Payment Via Momo</option>-->
                            </select>
                        </div>
                    </div>

                    <div>
                        <label class="form-label" for="note">Note</label>
                        <textarea
                            class="form-textarea"
                            id="note"
                            name="note"
                            placeholder="Ghi chú thêm về yêu cầu của bạn..."
                            rows="6"
                            maxlength="500"
                            ></textarea>
                    </div>
                    <!--                    <div>
                                            <label class="form-label">Selected Service</label>
                                            <div
                                                aria-atomic="true"
                                                aria-live="polite"
                                                aria-relevant="text"
                                                class="services-list"
                                                id="servicesList"
                                                >
                                                <p class="services-placeholder">No Services Selected yet </p>
                                            </div>
                                        </div>
                                        <button
                                            type="button"
                                            id="chooseServicesBtn"
                                            class="btn btn-services"
                                            >
                                            <i class="fas fa-concierge-bell"></i>Select Service
                                        </button>-->
                    <div
                        aria-atomic="true"
                        aria-live="polite"
                        aria-relevant="text"
                        class="summary"
                        id="summary"
                        >
                        <p class="summary-item">
                            Room Price (${numberNight} Night):
                            <span class="summary-price" id="price2">${room.price} VND</span>
                        </p>
                        <p class="summary-item">
                            Discount: 
                            <span id="discount" data-discount="${voucherdiscountPercent1}" class="summary-discount"> -<c:choose>
                                    <c:when test="${voucherdiscountPercent1 !=null }">${voucherdiscountPercent1}</c:when>
                                    <c:otherwise>0</c:otherwise>

                                </c:choose>%</span>

                        </p> 

                        <!--                        <p class="summary-item">
                                                    Additional Services: 
                                                    <span class="summary-price">0 VND</span>
                                                </p>-->
                        <p class="summary-total">
                            Total Payment: 

                            <input type="hidden" name="voucherdiscountPercent1" value="${voucherdiscountPercent1}">
                            <input type="hidden" name="roomPriceTotal" value="${room.price * numberNight}">
                            <input type="hidden"  name="totalAmount" value="${room.price * numberNight *   (1- voucherdiscountPercent1/100)}"> 
                            <span class="summary-totalPrice" id="price3" data-price="${room.price * numberNight *   (1- voucherdiscountPercent1/100)}" >${ room.price * numberNight *   (1- voucherdiscountPercent1/100) } VND</span>

                        </p>
                    </div>
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-check-circle"></i> Payment Confirmation
                    </button>
                </form>
            </section>
        </main>

    </body>
    <footer>
        © 2025 MyHotel. Địa chỉ: 123 Nguyễn Trãi, Hà Nội. Hotline: 1900 9999
    </footer>

</body>





<script>
    // chỉnh sửa khi chọn thanh toán 
    document.addEventListener('DOMContentLoaded', function () {
        const select = document.getElementById("limit");
        const totalPice = document.getElementById("price3");
        let originalPrice = totalPice.dataset.price;
        select.addEventListener('change', function () {
            const paymentCod = document.getElementById("cod");
            if (select.value === "50" || select.value === "30") {
                paymentCod.hidden = true;
                const totalPice = document.getElementById("price3");
                let originalPrice = totalPice.dataset.price;
                if (select.value === "50") {

                    totalPice.textContent = (parseInt(originalPrice) * 0.5).toLocaleString("vi-VN") + " VND ";

                } else {
                    totalPice.textContent = (parseInt(originalPrice) * 0.3).toLocaleString("vi-VN") + " VND ";
                }
            } else {
                totalPice.textContent = (parseInt(originalPrice).toLocaleString("vi-VN")) + " VND ";
                paymentCod.hidden = false;
            }
        });
    });
// chỉnh sửa thanh toán khi chọn voucher
    document.addEventListener("DOMContentLoaded", function () {
        const totalPice = document.getElementById("price3");
        let priceValue = totalPice.textContent;
        let priceNumber = parseInt(priceValue.replace(/[^\d]/g, ''));
        let priceVoucher = document.getElementById("discount").textContent.replace("%", "");
        let select = document.getElementById("Voucher");
        let numberNight = document.getElementById();
        select.addEventListener("click", function () {

            totalPice.textContent = (parseInt(priceNumber) - (parseInt(priceNumber) * (parseFloat(priceVoucher) / 100))).toLocaleString("vi-VN") + " VND";


        });


    });


    document.addEventListener("DOMContentLoaded", function () {

        const paymentCod = document.getElementById("cod");
        const action = document.getElementById("cod");
        select.addEventListener("click", function () {




        });


    });

    // thêm dấu . cách 3 số 0
    document.addEventListener('DOMContentLoaded', function () {
        let price1 = document.getElementById("price1");
        let num1 = parseInt(price1.textContent);
        let price2 = document.getElementById("price2");
        let num2 = parseInt(price2.textContent);
        let price3 = document.getElementById("price3");
        let num3 = parseInt(price3.textContent);
        if (!isNaN(num1) || !isNaN(num2) || !isNaN(num3)) {
            price1.textContent = num1.toLocaleString("vi-VN") + " VND / Night";
            price2.textContent = num2.toLocaleString("vi-VN") + " VND / Night";
            price3.textContent = num3.toLocaleString("vi-VN") + " VND ";
        }
    });


</script>
</html>