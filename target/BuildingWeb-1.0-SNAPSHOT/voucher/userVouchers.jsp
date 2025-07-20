<%-- 
Document   : userVouchers
Created on : Jun 16, 2025, 1:08:27 PM
Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Voucher đã lưu</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6fa;
                color: #2c3e50;
                margin: 0;
                padding: 20px;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 20px;
                color: #1a202c;
            }

            .voucher-list {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .voucher-card {
                background-color: #ffffff;
                border: 2px solid #4a90e2;
                border-left: 6px solid #4a90e2;
                color: #2c3e50;
                border-radius: 10px;
                padding: 16px 20px;
                width: 280px;
                box-shadow: 0 3px 8px rgba(0,0,0,0.06);
                transition: transform 0.2s ease;
            }

            .voucher-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            }

            .voucher-card h3 {
                margin-top: 0;
                color: #2d3748;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .voucher-card p {
                margin: 6px 0;
                font-size: 14px;
                line-height: 1.4;
            }

            .voucher-card p:last-child {
                font-weight: bold;
                color: #e74c3c;
            }

            .btn-back {
                display: inline-block;
                margin: 10px 0 20px 0;
                padding: 8px 16px;
                background-color: #4a90e2;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.2s ease;
            }

            .btn-back:hover {
                background-color: #357ab8;
            }

            .voucher-card.expired {
                background-color: #e0e0e0;
                color: #888;
                border: 1px dashed #aaa;
            }

            .expired-text {
                color: #d9534f;
                font-weight: bold;
            }

            .use-button {
                margin-top: 10px;
                padding: 8px 16px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .use-button:hover {
                background-color: #218838;
            }

        </style>

    </head>
    <body>
        <h1 class="page-title">🎁 Your Voucher(s)</h1>
        <a href="ViewVouchers" class="btn-back">← Return to voucher warehouse</a>
        <c:choose>
            <c:when test="${empty savedVouchers}">
                <p class="empty-text">You have not saved any vouchers yet.</p>
            </c:when>
            <c:otherwise>
                <div class="voucher-list">
                    <c:forEach var="v" items="${savedVouchers}">
                        <c:set var="expired" value="${v.endDate lt now}" />
                        <div class="voucher-card ${expired ? 'expired' : ''}">
                            <h3>${v.code}</h3>
                            <p>Reduce ${v.discountPercent}%</p>
                            <p>Minimum application: ${v.minOrderAmount} VNĐ</p>
                            <p>${v.description}</p>
                            <p>Expiry: ${v.formattedEndDate}</p>
                            <c:choose>
                                <c:when test="${v.endDate lt now}">

                                    <p class="expired-text">Expired</p>
                                </c:when>
                                <c:when test="${v.customerVouchers.isUsed == true}">

                                    <p class="expired-text">Used</p>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.roomId}">
                                            <form action="ConfirmBooking" method="get">
                                                <input type="hidden" name="voucherId" value="${v.voucherId}" />
                                                <input type="hidden" name="voucherCode" value="${v.code}" />
                                                <input type="hidden" name="voucherdiscountPercent" value="${v.discountPercent}" />
                                                <button type="submit" class="use-button">Use Voucher</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="ViewRooms" method="get">
                                                <button type="submit" class="use-button">Use Voucher</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>



                        </div>
                    </c:forEach>

                </div>
            </c:otherwise>
        </c:choose>
    </body>

</html>
