<%-- 
    Document   : viewServiceDetail
    Created on : 18-Jun-2025, 04:48:37
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <title>Service Detail</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 900px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
                display: flex;
                gap: 30px;
                flex-wrap: wrap;
            }

            .image-box {
                flex: 1 1 300px;
            }

            .image-box img {
                width: 100%;
                border-radius: 10px;
                object-fit: cover;
                max-height: 400px;
            }

            .info-box {
                flex: 2 1 500px;
                display: flex;
                flex-direction: column;
            }

            .info-box h2 {
                font-size: 28px;
                color: #006064;
                margin-bottom: 10px;
            }

            .info-box .type {
                font-size: 16px;
                color: #555;
                margin-bottom: 20px;
            }

            .info-box .description {
                font-size: 15px;
                line-height: 1.6;
                color: #444;
                margin-bottom: 20px;
            }

            .info-box .price {
                font-size: 20px;
                font-weight: bold;
                color: #2e7d32;
                margin-bottom: 20px;
            }

            .info-box .status {
                font-size: 15px;
                color: ${s.isActive ? '#2e7d32' : '#c62828'};
                margin-bottom: 30px;
            }

            .info-box .order-btn {
                text-align: center;
                display: inline-block;
                padding: 14px 24px;
                background-color: #1976d2;
                color: white;
                text-decoration: none;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                transition: background-color 0.3s ease;
                width: fit-content;
                cursor: pointer;
            }

            .info-box .order-btn:hover {
                background-color: #0d47a1;
            }
            
            .back-button {
                top: -40px;
                left: 20px;
                width: 80px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #0c53b0;
            }

            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../header/header.jsp"%> 
        <br><br><br>
        <a href="javascript:history.back()" class="back-button">← Back</a>
        <div class="container">
            <!-- Hộp ảnh -->
            <div class="image-box">
                <img src="${s.imageURL}" alt="${s.serviceName}" />
            </div>

            <!-- Hộp thông tin -->
            <div class="info-box">
                <h2>${s.serviceName}</h2>
                <div class="type">🔧 Service Type: ${s.unitType}</div>
                <div class="description">${s.description}</div>
                <div class="price">💰 Price: ${s.price} VNĐ</div>
                <div class="status">${s.isActive ? '🟢 Active' : '🔴 Inactive'}</div>

                <form id="orderForm" action="ViewServicesCart" method="post" onsubmit="return handleOrderSubmit();">
                    <input type="hidden" name="serviceId" value="${s.serviceId}" />
                    <input type="hidden" name="serviceName" value="${s.serviceName}" />
                    <input type="hidden" name="price" value="${s.price}" />
                    <input type="hidden" name="unitType" value="${s.unitType}" />

                    <button type="submit" class="order-btn">Add Order Service</button>
                </form>
            </div>
        </div>

        <script>
            function handleOrderSubmit() {
                const customerId = "${sessionScope.customerId}";
                if (!customerId || customerId.trim() === "") {
                    alert("You must log in before adding services to your cart.");
                    window.location.href = "<c:url value='/Login' />";
                    return false;
                }
                return confirm("Do you want to add this service to your cart?");
            }
        </script>
    </body>
</html>

