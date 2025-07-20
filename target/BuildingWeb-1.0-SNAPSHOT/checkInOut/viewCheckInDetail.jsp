<%-- 
    Document   : ViewCheckInDetail
    Created on : Jun 20, 2025, 5:45:30 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Detail</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --navy: #4a6fa5;
            --white: #ffffff;
        }
        .navbar {
            background-color: var(--navy);
            color: var(--white);
            padding: 0 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 60px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar h1 {
            font-size: 22px;
            margin: 0;
            font-weight: 700;
            color: var(--white);
        }
        .navbar a {
            color: var(--white);
            text-decoration: none;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #e7f0fa, #ffffff);
            margin: 0;
            padding: 0;
            color: #333;
            animation: fadeInBody 0.6s ease-in-out;
        }
        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .main-content {
            margin-left: 60px;
            padding: 80px 20px 40px;
            animation: slideInMain 0.6s ease forwards;
            opacity: 0;
        }
        @keyframes slideInMain {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .container {
            max-width: 700px;
            margin: auto;
            background-color: #fff;
            padding: 35px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }
        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 30px;
            font-size: 28px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        p {
            font-size: 16px;
            margin: 12px 0;
            line-height: 1.6;
        }
        strong {
            color: #003c75;
            display: inline-block;
            width: 180px;
        }
        .back-btn {
            text-align: center;
            margin-top: 30px;
        }
        .back-btn a {
            text-decoration: none;
            background-color: #007bff;
            color: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .back-btn a:hover {
            background-color: #0056b3;
        }
        .not-found {
            text-align: center;
            color: #d9534f;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="main-content">
    <div class="container">
        <h2><i class="fa-solid fa-circle-info"></i> Check-In / Check-Out Detail</h2>
        <c:if test="${not empty booking}">
            <p><strong><i class="fa-solid fa-id-badge"></i> Booking ID:</strong> ${booking.bookingId}</p>
            <p><strong><i class="fa-solid fa-user"></i> Customer:</strong> ${booking.customers.fullName}</p>
            <p><strong><i class="fa-solid fa-envelope"></i> Email:</strong> ${booking.customers.email}</p>
            <p><strong><i class="fa-solid fa-phone"></i> Phone:</strong> ${booking.customers.phone}</p>
            <p><strong><i class="fa-solid fa-door-closed"></i> Room:</strong> 
                <c:choose>
                    <c:when test="${booking.rooms != null}">
                        ${booking.rooms.roomNumber}
                    </c:when>
                    <c:otherwise>Chưa có phòng</c:otherwise>
                </c:choose>
            </p>
            <p><strong><i class="fa-solid fa-bars-progress"></i> Status:</strong> ${booking.status}</p>
            <p><strong><i class="fa-solid fa-calendar-plus"></i> Start Date:</strong> ${booking.formattedStartDate}</p>
            <p><strong><i class="fa-solid fa-calendar-minus"></i> End Date:</strong> ${booking.formattedEndDate}</p>
        </c:if>
        <c:if test="${empty booking}">
            <div class="not-found">⚠️ Booking not found.</div>
        </c:if>
        <div class="back-btn">
            <a href="javascript:history.back()"><i class="fa-solid fa-arrow-left"></i> Back</a>
        </div>
    </div>
</div>
</body>
</html>
