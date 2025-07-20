<%-- 
    Document   : viewServices
    Created on : 18-Jun-2025, 04:32:24
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dịch Vụ</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8fafc;
                color: #333;
            }

            h1 {
                text-align: center;
                padding: 40px 20px;
                background: linear-gradient(to right, #00838f, #00acc1); /* Teal Gradient */
                color: white;
                font-size: 40px;
                margin: 0;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                letter-spacing: 1px;
            }

            .services-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 32px;
                padding: 50px 6%;
                max-width: 1400px;
                margin: auto;
            }

            .service-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 6px 24px rgba(0, 0, 0, 0.06);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                transition: all 0.3s ease;
                border-top: 5px solid #00acc1;
            }

            .service-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 14px 32px rgba(0, 131, 143, 0.2);
            }

            .service-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-bottom: 1px solid #eee;
            }

            .service-title {
                font-size: 22px;
                font-weight: 600;
                color: #006064;
                margin: 18px 16px 6px;
                min-height: 52px;
            }

            .service-type {
                font-size: 15px;
                color: #555;
                margin: 0 16px 6px;
            }

            .service-description {
                font-size: 14px;
                color: #444;
                margin: 0 16px 12px;
                line-height: 1.5;
            }

            .service-price {
                font-size: 16px;
                color: #2e7d32;
                font-weight: bold;
                margin: 0 16px 18px;
            }

            a {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .no-service-message {
                text-align: center;
                padding: 60px 20px;
                font-size: 20px;
                color: #c62828;
                font-weight: 500;
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
                h1 {
                    font-size: 28px;
                    padding: 30px 15px;
                }

                .service-title {
                    font-size: 18px;
                }

                .service-price {
                    font-size: 15px;
                }

                .services-container {
                    padding: 30px 4%;
                    gap: 20px;
                }
            }
        </style>

    </head>
    <body>
        <%@include file="../header/header.jsp"%> 
        <br>
        <br>
        <br>
        <h1>Our Services</h1>
        <a href="javascript:history.back()" class="back-button">← Back</a>
        <c:choose>
            <c:when test="${not empty servicesList}">
                <c:set var="hasActiveService" value="false" />
                <div class="services-container">
                    <c:forEach var="s" items="${servicesList}">
                        <c:if test="${s.isActive}">
                            <c:set var="hasActiveService" value="true" />
                            <a href="ViewServiceDetail?id=${s.serviceId}">
                                <div class="service-card">
                                    <img src="${s.imageURL}" alt="Ảnh dịch vụ">
                                    <div class="service-title">${s.serviceName}</div>
                                    <div class="service-type">Loại: ${s.unitType}</div>
                                    <div class="service-price">💰 ${s.price} VND</div>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>

                <c:if test="${!hasActiveService}">
                    <div style="text-align: center; padding: 40px; font-size: 18px; color: #c62828;">
                        ⚠️ There are currently no active services.
                    </div>
                </c:if>
            </c:when>

            <c:otherwise>
                <div style="text-align: center; padding: 40px; font-size: 18px; color: #c62828;">
                    ⚠️ There are currently no active services.
                </div>
            </c:otherwise>
        </c:choose>

    </body>
</html>

