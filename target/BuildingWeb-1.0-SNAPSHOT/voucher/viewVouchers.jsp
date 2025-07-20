<%-- 
    Document   : vouchers
    Created on : May 14, 2025, 11:36:39 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Kho Voucher</title>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f7f9fc;
                padding: 20px;
                margin: 0;
                color: #333;
            }

            .title {
                font-size: 24px;
                color: #2c3e50;
                margin-bottom: 20px;
                text-align: center;
            }

            .voucher-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 15px;
            }

            .voucher-card {
                background-color: #fff;
                border-radius: 8px;
                padding: 14px 16px;
                box-shadow: 0 1px 6px rgba(0, 0, 0, 0.08);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                transition: transform 0.2s;
                border-left: 5px solid #3498db;
            }

            .voucher-card.saved {
                border-left-color: #28a745;
            }

            .voucher-card.out-of-stock {
                border-left-color: #e74c3c;
                opacity: 0.75;
            }

            .voucher-card:hover {
                transform: translateY(-3px);
            }

            .voucher-code {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 4px;
                color: #2c3e50;
            }

            .voucher-desc,
            .voucher-time {
                font-size: 13px;
                margin: 3px 0;
                color: #555;
            }

            .voucher-discount .discount {
                font-size: 18px;
                font-weight: bold;
                color: #e67e22;
            }

            .voucher-action {
                margin-top: 10px;
            }

            .save-btn {
                background-color: #3498db;
                color: #fff;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 13px;
                cursor: pointer;
                transition: background-color 0.2s;
                width: 100%;
            }

            .save-btn:hover {
                background-color: #2980b9;
            }

            .saved-label,
            .out-label {
                font-size: 13px;
                font-weight: 600;
                text-align: center;
                margin-top: 4px;
            }

            .saved-label {
                color: #28a745;
            }

            .out-label {
                color: #c0392b;
            }

            @media (max-width: 480px) {
                .voucher-code {
                    font-size: 16px;
                }

                .discount {
                    font-size: 16px;
                }

                .voucher-desc,
                .voucher-time {
                    font-size: 12px;
                }
            }
        </style>


    </head>
    <body>
        <h1 class="title">🎁 Voucher Warehouse</h1>

        <div class="voucher-list">
            <c:forEach var="v" items="${vouchers}">
                <c:set var="isSaved" value="false" />
                <c:forEach var="saved" items="${savedIds}">
                    <c:if test="${v.voucherId == saved.voucherId}">
                        <c:set var="isSaved" value="true" />
                    </c:if>
                </c:forEach>

                <div class="voucher-card ${isSaved ? 'saved' : ''} ${v.quantity == 0 ? 'out-of-stock' : ''}">
                    <div class="voucher-content">
                        <div class="voucher-info">
                            <h2 class="voucher-code">${v.code}</h2>
                            <p class="voucher-desc">Minimum application: ${v.minOrderAmount} VNĐ</p>
                            <p class="voucher-desc">${v.description}</p>
                            <p class="voucher-time">Expiry: ${v.formattedEndDate}</p>
                        </div>

                        <div class="voucher-action">
                            <div class="voucher-discount">
                                <c:if test="${v.discountPercent != 0}">
                                    <span class="discount">-${v.discountPercent}%</span>
                                </c:if>
                            </div>

                            <c:choose>
                                <c:when test="${isSaved}">
                                    <p class="saved-label">✔ Received</p>
                                </c:when>
                                <c:when test="${v.quantity == 0}">
                                    <p class="status-label out-label">Voucher has expired</p>
                                </c:when>
                                <c:otherwise>
                                    <form action="ViewVouchers" method="post">
                                        <input type="hidden" name="voucherId" value="${v.voucherId}" />
                                        <button class="save-btn">Save voucher</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>



</html>