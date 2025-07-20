<%-- 
    Document   : adminView
    Created on : May 4, 2025, 11:44:22 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            :root {
                --primary: #002b5c;
                --primary-light: #004080;
                --background: #f4f6f9;
                --white: #ffffff;
                --gray: #e0e0e0;
                --text: #333;
                --shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            }

            body {
                margin: 0;
                padding: 0;
                background-color: var(--background);
                font-family: 'Segoe UI', sans-serif;
                color: var(--text);
                animation: fadeInBody 0.5s ease-in-out;
            }

            @keyframes fadeInBody {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .main-content {
                margin-left: 60px;
                padding: 80px 30px 40px;
                transition: margin-left 0.3s ease;
                animation: slideInMain 0.6s ease forwards;
                opacity: 0;
            }

            .sidebar.open ~ .main-content {
                margin-left: 220px;
            }

            @keyframes slideInMain {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: var(--white);
                box-shadow: var(--shadow);
                border-radius: 12px;
                overflow: hidden;
            }

            th {
                background-color: var(--primary);
                color: white;
                font-size: 20px;
                text-align: center;
                padding: 20px;
                font-weight: 600;
            }

            td {
                padding: 18px 16px;
                border-bottom: 1px solid var(--gray);
                font-size: 15px;
                vertical-align: middle;
            }

            td.label {
                font-weight: 600;
                color: var(--primary);
                width: 20%;
            }

            td.value {
                font-weight: 500;
                color: var(--text);
            }

            img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }



            a:hover {
                background-color: var(--primary-light);
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <div class="main-content">
            <table>
                <tr>
                    <th colspan="4">
                        THÔNG TIN CHI TIẾT: ${user.userName} &nbsp;&nbsp;
                        <a href="DashboardUser">Đóng</a>
                    </th>
                </tr>
                <tr>
                    <td class="label">Ảnh đại diện:</td>
                    <td rowspan="6"><img src="${user.avatarUrl}" alt="Avatar"></td>
                    <td class="label">Họ tên:</td>
                    <td class="value">${user.fullName}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="label">Email:</td>
                    <td class="value">${user.email}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="label">SĐT:</td>
                    <td class="value">${user.phone}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="label">Vai trò:</td>
                    <td class="value">${user.role.roleName}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="label">Trạng thái:</td>
                    <td class="value">${user.status}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="label">Ngày tạo:</td>
                    <td class="value">01/01/2024</td>
                    <td class="label">Lần cuối đăng nhập: <span class="value">05/05/2024</span></td>
                </tr>
            </table>
        </div>
    </body>
</html>
