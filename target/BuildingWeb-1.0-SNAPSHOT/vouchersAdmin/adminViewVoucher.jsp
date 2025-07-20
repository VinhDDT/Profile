<%-- 
    Document   : viewVoucher
    Created on : May 21, 2025, 2:26:02 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết Voucher</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin-top: 50px;
                padding: 0;
                font-family: "Segoe UI", sans-serif;
                background-color: #f1f3f5;
                display: flex;
                justify-content: center;
                align-items: center;

            }

            .voucher-details {
                background-color: #fff;
                border-radius: 16px;
                padding: 2rem;
                width: 100%;
                max-width: 700px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            h2 {
                margin-top: 0;
                text-align: center;
                font-size: 1.8rem;
                margin-bottom: 2rem;
                color: #333;
            }


            .detail-row {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                padding: 0.7rem 0;
                border-bottom: 1px solid #e2e2e2;
            }

            .detail-label {
                font-weight: 600;
                color: #555;
                flex: 1;
            }

            .detail-value {
                flex: 2;
                text-align: right;
                color: #222;
            }

            .back-btn {
                display: inline-block;
                margin-top: 2rem;
                padding: 0.75rem 1.5rem;
                background-color: #007bff;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: background 0.3s ease;
            }

            .back-btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        
        <div class="voucher-details">
            <h2>Voucher Details</h2>

            <div class="detail-row">
                <span class="detail-label">Voucher ID:</span>
                <span class="detail-value">${voucher.voucherId}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Voucher code:</span>
<span class="detail-value">${voucher.code}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Discount (%):</span>
                <span class="detail-value">${voucher.formattedDiscountPercent}%</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Minimum application:</span>
                <span class="detail-value">
                    <fmt:formatNumber value="${voucher.minOrderAmount}" type="number" groupingUsed="true" />đ
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Start date:</span>
                <span class="detail-value">${voucher.formattedStartDate}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">End date:</span>
                <span class="detail-value">${voucher.formattedEndDate}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Describe:</span>
                <span class="detail-value">${voucher.description}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Quantity:</span>
                <span class="detail-value">${voucher.quantity}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Status:</span>
                <span class="detail-value">
                    <c:choose>
                        <c:when test="${voucher.isActive}">
                            Active
                        </c:when>
                        <c:otherwise>
                            Inactive
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <a href="VouchersDashBoard" class="back-btn">← Back</a>
        </div>
    </body>
</html>