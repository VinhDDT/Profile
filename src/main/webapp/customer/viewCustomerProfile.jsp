<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            .user-info-container {
                max-width: 600px;
                margin: 0 auto;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .user-card {
                background-color: #fff;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #007BFF;
            }

            .info p {
                margin: 10px 0;
                color: #555;
                font-size: 16px;
            }

            .info strong {
                color: #333;
            }

            .status-indicator {
                display: inline-block;
                width: 10px;
                height: 10px;
                margin-right: 8px;
                border-radius: 50%;
                background-color: #28a745;
                box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
                animation: pulse 1.5s infinite;
                vertical-align: middle;
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
            
            @keyframes pulse {
                0% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
                }
                70% {
                    box-shadow: 0 0 0 10px rgba(40, 167, 69, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(40, 167, 69, 0);
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../header/header.jsp" %>
        <br>
        <br>
        <br>
        <a href="javascript:history.back()" class="back-button">← Back</a>
        <div class="user-info-container">
            <h1>User Information</h1>


            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty message}">
                <div class="error-message">${message}</div>
            </c:if>

            <!-- Hiển thị thông tin người dùng nếu tồn tại -->
            <c:if test="${not empty userProfile}">
                <div class="user-card">
                    <img class="avatar" src="${userProfile.avatarUrl}" alt="Avatar người dùng">
                    <div class="info">
                        <p><strong>Full Name:</strong> ${userProfile.fullName}</p>
                        <p><strong>UserName:</strong> ${userProfile.userName}</p>
                        <p><strong>Email:</strong> ${userProfile.email}</p>
                        <p><strong>Phone:</strong> ${userProfile.phone}</p>
                        <p><strong>Address:</strong>
                            <c:choose>
                                <c:when test="${not empty userProfile.address}">
                                    ${userProfile.address}
                                </c:when>
                                <c:otherwise>Not updated yet</c:otherwise>
                            </c:choose>
                        </p>
                        <p><strong>Gender:</strong>
                            <c:choose>
                                <c:when test="${userProfile.gender == 'Male'}">Male</c:when>
                                <c:when test="${userProfile.gender == 'Female'}">Female</c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </p>
                        <p><strong>Date of Birth:</strong>
                            <c:choose>
                                <c:when test="${not empty userProfile.dateOfBirth}">
                                    ${userProfile.dateOfBirth}
                                </c:when>
                                <c:otherwise>Not updated yet</c:otherwise>
                            </c:choose>
                        </p>
                        <p>
                            <strong>Status: </strong>
                            <span class="status-indicator"></span>
                            ${userProfile.status}
                        </p>
                        <p><strong>Last Login:</strong>
                            <c:choose>
                                <c:when test="${not empty userProfile.lastLogin}">
                                    ${fn:replace(userProfile.lastLogin, 'T', ' ')}
                                </c:when>
                                <c:otherwise>No data available</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="EditCustomerProfile?id=${customerId}">Update</a>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>
