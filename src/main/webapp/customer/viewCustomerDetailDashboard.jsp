<%-- 
    Document   : viewCustomerDetail
    Created on : Jun 18, 2025, 12:53:34 AM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        :root {
            --main-color: #002b5c;
            --transition: 0.3s ease;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }

        .main-content {
            margin-left: 60px;
            padding: 80px 20px 40px;
            transition: margin-left var(--transition);
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        h2 {
            color: var(--main-color);
            text-align: center;
            margin-bottom: 30px;
            font-size: 30px;
            font-weight: 600;
            border-bottom: 2px solid var(--main-color);
            padding-bottom: 12px;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 43, 92, 0.1);
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .info {
            margin-bottom: 14px;
            font-size: 16px;
            line-height: 1.5;
        }

        .info strong {
            width: 240px;
            display: inline-block;
            color: var(--main-color);
        }

        img {
            border-radius: 8px;
            margin-top: 12px;
            border: 2px solid var(--main-color);
        }

        .back-button {
            display: inline-block;
            margin-top: 35px;
            padding: 12px 24px;
            background-color: var(--main-color);
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #004080;
        }

        .avatar-box {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <div class="container">
        <h2>Customer Details</h2>

        <c:if test="${not empty customer}">
            <div class="info"><strong>Customer ID:</strong> ${customer.customerId}</div>
            <div class="info"><strong>Username:</strong> ${customer.userName}</div>
            <div class="info"><strong>Full Name:</strong> ${customer.fullName}</div>
            <div class="info"><strong>Email:</strong> ${customer.email}</div>
            <div class="info"><strong>Phone Number:</strong> ${customer.phone}</div>
            <div class="info"><strong>Gender:</strong> ${customer.gender}</div>
            <div class="info"><strong>Address:</strong> ${customer.address}</div>
            <div class="info"><strong>Date of Birth:</strong> ${customer.dateOfBirth}</div>
            <div class="info"><strong>Status:</strong> ${customer.status}</div>
            <div class="info"><strong>Account Created:</strong> ${customer.creationDate}</div>
            <div class="info"><strong>Last Login:</strong> ${customer.lastLogin}</div>
            <div class="info"><strong>ID/Passport Number:</strong> ${customer.identityNumber}</div>
            <div class="info"><strong>Join Date:</strong> ${customer.joinDate}</div>

            <c:if test="${not empty customer.avatarUrl}">
                <div class="avatar-box">
                    <strong>Avatar:</strong><br>
                    <img src="${customer.avatarUrl}" alt="Avatar" width="120" height="120">
                </div>
            </c:if>
        </c:if>

        <div style="text-align: center;">
            <a class="back-button" onclick="history.back()">← Back</a>
        </div>
    </div>
</div>

</body>
</html>
