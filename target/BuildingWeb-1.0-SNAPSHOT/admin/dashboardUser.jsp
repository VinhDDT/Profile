<%-- 
    Document   : dashBoardUser
    Created on : May 3, 2025, 2:04:23 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management Dashboard</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
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
            --radius: 12px;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: var(--background);
            font-family: 'Segoe UI', sans-serif;
            color: var(--text);
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

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
            color: var(--primary);
        }

        form {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        input[type="search"] {
            width: 320px;
            padding: 12px 16px;
            border: 1px solid var(--gray);
            border-radius: 8px 0 0 8px;
            font-size: 15px;
            outline: none;
        }

        button {
            padding: 12px 20px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 0 8px 8px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: var(--primary-light);
        }

        button i {
            font-size: 18px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: var(--white);
            box-shadow: var(--shadow);
            border-radius: var(--radius);
            overflow: hidden;
        }

        thead {
            background-color: var(--primary);
            color: white;
        }

        th, td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid var(--gray);
        }

        th:first-child, td:first-child {
            text-align: left;
            padding-left: 30px;
        }

        tr:hover {
            background-color: #f0f8ff;
            transition: background-color 0.2s;
        }

        .dot-menu {
            position: relative;
            cursor: pointer;
        }

        .dot-icon {
            font-size: 18px;
            color: #999;
            transition: color 0.2s;
        }

        .dot-icon:hover {
            color: var(--primary);
        }

        .dropdown {
            display: none;
            position: absolute;
            left: 0;
            top: 28px;
            background-color: var(--white);
            box-shadow: var(--shadow);
            border-radius: 6px;
            z-index: 10;
            width: 160px;
        }

        .dropdown a {
            display: block;
            padding: 10px 14px;
            text-align: left;
            text-decoration: none;
            color: var(--primary);
            font-size: 14px;
        }

        .dropdown a:hover {
            background-color: #eef4ff;
        }

        .dot-menu:hover .dropdown {
            display: block;
        }

        .actions a {
            color: var(--primary);
            margin: 0 6px;
            font-size: 16px;
            transition: 0.2s;
        }

        .actions a:hover {
            color: var(--primary-light);
            transform: scale(1.15);
        }

        nav {
            text-align: center;
            margin-top: 35px;
        }

        .pagination {
            list-style: none;
            display: inline-flex;
            gap: 10px;
            padding: 0;
        }

        .pagination li a {
            display: inline-block;
            padding: 10px 16px;
            background-color: var(--primary);
            color: white;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .pagination li a:hover {
            background-color: var(--primary-light);
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            tr {
                margin-bottom: 20px;
            }

            td {
                padding-left: 50%;
                position: relative;
                text-align: right;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 12px;
                font-weight: bold;
                color: var(--primary);
            }

            th {
                display: none;
            }
        }
    </style>
</head>
<body>
<%@include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>User Management Dashboard</h2>

    <form method="get" action="DashboardUser">
        <input type="search" name="search" placeholder="Enter keyword...">
        <button type="submit"><i class='bx bx-search-alt-2'></i></button>
    </form>

    <table>
        <thead>
            <tr>
                <th></th>
                <th>No.</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${list}" varStatus="i">
                <tr>
                    <td class="dot-menu">
                        <i class="fas fa-ellipsis-v dot-icon"></i>
                        <div class="dropdown">
                            <a href="AdminView?id=${user.userId}"><i class="fa-solid fa-eye"></i> View</a>
                            <a href="AdminEdit?id=${user.userId}"><i class="fa-solid fa-pencil"></i> Edit</a>
                            <a href="AdminDelete?id=${user.userId}"><i class="fa-solid fa-user-slash"></i> Delete</a>
                            <a href="Decentralization?id=${user.userId}"><i class="fa-solid fa-gear"></i> Role</a>
                        </div>
                    </td>
                    <td>${(thisPage - 1) * 10 + i.index + 1}</td>
                    <td>${user.userName}</td>
                    <td>${user.email}</td>
                    <td>${user.role.roleName}</td>
                    <td class="actions">
                        <a href="AdminView?id=${user.userId}" title="View"><i class="fa-solid fa-eye"></i></a>
                        <a href="AdminEdit?id=${user.userId}" title="Edit"><i class="fa-solid fa-pencil"></i></a>
                        <a href="AdminDelete?id=${user.userId}" title="Delete"><i class="fa-solid fa-user-slash"></i></a>
                        <a href="Decentralization?id=${user.userId}" title="Role"><i class="fa-solid fa-gear"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:forEach begin="1" end="${finalPage}" var="i">
                <li><a href="DashboardUser?Page=${i}">${i}</a></li>
            </c:forEach>
        </ul>
    </nav>
</div>

</body>
</html>
