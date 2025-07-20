<%-- 
    Document   : viewRoomDetail
    Created on : Jun 11, 2025, 1:50:26 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Room Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
                margin: 0;
                padding: 0;
            }

            main {
                max-width: 1200px;
                margin: auto;
                padding: 2rem;
            }

            .flex {
                display: flex;
                gap: 2rem;
                flex-wrap: wrap;
                align-items: center; /* Căn giữa theo chiều dọc */
            }

            .rounded-lg {
                border-radius: 0.5rem;
            }

            .overflow-hidden {
                overflow: hidden;
            }

            .shadow-lg {
                box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            }

            .img-cover {
                width: 100%;
                height: 450px;
                object-fit: cover;
                border-radius: 0.5rem;
                transition: transform 0.5s ease; /* chuyển động mượt */
            }

            .img-cover:hover {
                transform: scale(1.05); /* zoom lớn hơn 5% khi hover */
            }

            .text-3xl {
                font-size: 1.875rem;
                font-weight: 600;
                color: #1f2937;
            }

            .text-xl {
                font-size: 1.25rem;
                color: #2563eb;
                font-weight: bold;
            }

            .text-base {
                font-size: 1rem;
                font-weight: normal;
                color: #6b7280;
            }

            .text-yellow {
                color: #facc15;
            }

            .text-gray {
                color: #6b7280;
            }

            .text-blue {
                color: #2563eb;
            }

            .leading-relaxed {
                line-height: 1.625;
            }

            .text-lg {
                font-size: 1.125rem;
                font-weight: 600;
            }

            .text-2xl {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 1rem;
            }

            ul.grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 0.75rem;
                color: #374151;
            }

            .items-center {
                display: flex;
                align-items: center;
            }

            .space-x-2 > * + * {
                margin-left: 0.5rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-group label {
                display: block;
                font-weight: 500;
                margin-bottom: 0.5rem;
                color: #374151;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 0.5rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
            }

            /* Button đã có hover rồi, mình nâng cấp thêm */
            button {
                width: 100%;
                background-color: #2563eb;
                color: white;
                font-weight: 600;
                padding: 0.75rem;
                border: none;
                border-radius: 0.375rem;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            button:hover {
                background-color: #1d4ed8;
                transform: scale(1.05);
            }

            /* Hiệu ứng hover cho danh sách tiện ích (amenities) */
            ul.grid li {
                transition: background-color 0.3s ease, color 0.3s ease, transform 0.2s ease;
                border-radius: 0.375rem;
                padding: 0.3rem 0.5rem;
                cursor: default;
            }

            ul.grid li:hover {
                background-color: #e0e7ff; /* Màu nền nhẹ */
                color: #1e40af; /* Màu chữ đậm hơn */
                transform: translateY(-3px);
            }

            ul.grid li:hover i {
                color: #1e40af; /* đổi màu icon cùng hover */
            }

            /* Hiệu ứng cho thẻ đánh giá (review) */
            .review {
                background: white;
                padding: 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: box-shadow 0.3s ease, transform 0.3s ease;
                cursor: default;
            }

            .review:hover {
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
                transform: translateY(-6px);
            }

            /* Hiệu ứng mượt cho ảnh avatar trong review */
            .review img {
                width: 64px;
                height: 64px;
                border-radius: 9999px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .review:hover img {
                transform: scale(1.1);
            }

            /* Hiệu ứng cho các tiêu đề h2, h3, h4 */
            .text-3xl, .text-2xl, .text-lg, h4 {
                transition: color 0.3s ease;
                cursor: default;
            }

            .text-3xl:hover, .text-2xl:hover, .text-lg:hover, h4:hover {
                color: #2563eb;
            }

            /* Hiệu ứng cho input và select */
            .form-group input,
            .form-group select,
            .form-group textarea {
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #2563eb;
                box-shadow: 0 0 5px rgba(37, 99, 235, 0.5);
            }

            /* Thêm hiệu ứng cho icon sao đánh giá */
            .text-yellow i {
                transition: color 0.3s ease, transform 0.3s ease;
            }

            .text-yellow i:hover {
                color: #fbbf24; /* vàng sáng hơn */
                transform: scale(1.2);
                cursor: pointer;
            }

            .review {
                background: white;
                padding: 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }



            .mt-4 {
                margin-top: 1rem;
            }

            .mt-6 {
                margin-top: 1.5rem;
            }

            .mt-8 {
                margin-top: 2rem;
            }

            .mt-16 {
                margin-top: 4rem;
            }

            .space-y-8 > * + * {
                margin-top: 2rem;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .flex {
                    flex-direction: column;
                }

                ul.grid {
                    grid-template-columns: 1fr;
                }
            }
            .form-group input,
            .form-group select,
            .form-group textarea,
            .review form button {
                width: 100%;
                padding: 0.75rem;              /* Đều nhau */
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 1rem;
                font-family: 'Inter', sans-serif;
                box-sizing: border-box;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #2563eb;
                box-shadow: 0 0 5px rgba(37, 99, 235, 0.5);
            }

            .review form button {
                background-color: #2563eb;
                color: white;
                font-weight: 600;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .review form button:hover {
                background-color: #1d4ed8;
                transform: scale(1.05);
            }
            .please {
                font-size: 16px;
                font-weight: 600;
                color: #ff4d4d; /* Màu đỏ cảnh báo */
                margin-bottom: 8px;
            }

            .sendMessage {
                display: inline-block;
                background-color: #2563eb; /* Màu xanh dương */
                color: white;
                font-weight: 600;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 6px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .sendMessage:hover {
                background-color: #1e40af; /* Đậm hơn khi hover */
                transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
            }

            .checkLogin{
                text-align: center;
            }
        </style>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const price = document.getElementById("price");
                if (!isNaN(parseInt(price.textContent))) {
                    price.textContent = parseInt(price.textContent).toLocaleString("vi-VN") + " VND / Night";
                }
            });
        </script>
    </head>
    <body>
        <%@include file="../header/header.jsp" %>
        <br>
        <br>
        <main>
            <div class="flex">
                <section style="flex: 2">
                    <div class="rounded-lg overflow-hidden shadow-lg">

                        <img class="img-cover" src="${room.imageUrl}" alt="Room"/>
                    </div>
                </section>
                <section style="flex: 1; padding-left: 1rem;">
                    <h2 class="text-3xl">${room.roomType}</h2>
                    <p class="text-xl mt-2">
                        <span id="price" class="text-base">${room.price} VND / Night</span>
                    </p>
                    <div class="mt-4 items-center">
                        <span class="text-gray">
                            <c:choose> 
                                <c:when test="${totalRating > 0}">
                                    <fmt:formatNumber value="${totalRating} " type="number" maxFractionDigits="1" minFractionDigits="1" ></fmt:formatNumber>
                                </c:when>
                                <c:otherwise>No One Send Review</c:otherwise>
                            </c:choose>
                            /5 <i style="color: #FBBF24" class="fas fa-star"></i> (${numberOfReview} reviews)</span>
                    </div>
                    <p class="text-xl mt-2">
                        <span id="area" class="text-base">Area ${room.area} (m²)</span>
                    </p>
                    <p class="mt-6 text-gray leading-relaxed">
                        ${room.description}
                    </p>



                    <div class="mt-6">
                        <h3 class="text-lg">Amenities</h3>
                        <ul class="grid mt-3">
                            <c:forEach var="amenity" items="${listAmenites}"> 

                                <li class="items-center space-x-2">
                                    <!--                                    <i class="fas fa-wifi text-blue"></i>-->
                                    <i style="color: red" class="fas fa-star"></i>
                                    <span>${amenity.name}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="mt-8">
                        <form action="ConfirmBooking " method="get">
                            <input type="hidden" name="roomId" value="${room.roomId}"> 

                            <c:choose>
                                <c:when test="${ not empty sessionScope.customerId}"> 
                                    <c:choose>
                                        <c:when test="${ not empty sessionScope.checkIn and not empty sessionScope.checkOut}">     
                                            <button type="submit">Book Now</button>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="sendMessage" href="ViewRooms" style="text-decoration: none">Please Enter Value In Search Bar</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${ empty sessionScope.customerId}"> 
                                    <div class="checkLogin"><div class="please">  Please Login To Booking</div>
                                        <a class="sendMessage" style="text-decoration: none;" href="Login">  Go to Login</a></div>
                                    </c:when>
                                </c:choose>
                        </form>
                    </div>
                </section>
            </div>

            <!-- ĐÁNH GIÁ -->
            <section class="mt-16">
                <h3 class="text-2xl">Reviews </h3>
                <div class="space-y-8">
                    <c:forEach var="review" items="${customerReview}"> 
                        <article class="review">
                            <div class="flex items-center space-x-4">
                                <img src="${review.customer.avatarUrl}" alt=""/>
                                <div>
                                    <h4 class="text-lg">${review.customer.userName}</h4>
                                    <div class="text-yellow">
                                        <c:forEach  begin="1" end="${review.rating}" step="1" > 
                                            <i class="fas fa-star"></i>
                                        </c:forEach>
                                    </div>
                                    <p class="text-gray text-sm">  ${review.createdAt}</p>
                                </div>
                            </div>
                            <p class="mt-4 text-gray leading-relaxed">
                                ${review.comment}
                            </p>
                        </article>
                    </c:forEach>
                    <!-- <div>
                                            <button id="loadmore-btn" onclick="loadMore()">View More Reviews</button>
                                        </div>-->

                    <!-- Form đánh giá -->
                    <article class="review">
                        <h4 class="text-lg mb-3">Send Your Review</h4>
                        <form action="ViewRoomDetail" method="post">
                            <input type="hidden" name="roomId" value="${room.roomId}">
                            <div class="form-group">
                                <label for="rating">Review (Start<i style="color: #FBBF24" class="fas fa-star"></i>)</label>
                                <select id="rating" name="rating">
                                    <option value="5">5 Start</option>
                                    <option value="4">4 Start</option>
                                    <option value="3">3 Start</option>
                                    <option value="2">2 Start</option>
                                    <option value="1">1 Start</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="comment">Content</label>
                                <textarea id="comment" name="comment" rows="4" required></textarea>
                            </div>

                            <c:choose>
                                <c:when test="${ not empty sessionScope.customerId}"> 
                                    <button class="sendMessage"type="submit">Send</button>
                                </c:when>
                                <c:otherwise>
                                    <div class="checkLogin"><div class="please">  Please Login To Send Messages</div>
                                        <a class="sendMessage" style="text-decoration: none;" href="Login"> ==> Go to Login</a></div>
                                    </c:otherwise>
                                </c:choose>

                        </form>
                    </article>
                </div>
            </section>
        </main>
    </body>
</html>
