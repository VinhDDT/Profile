<%-- 
    Document   : viewAmenities
    Created on : Jun 15, 2025, 8:19:33 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Amenities List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        :root {
            --primary: #1e88e5;
            --primary-dark: #1565c0;
            --danger: #e53935;
            --danger-dark: #b71c1c;
            --white: #ffffff;
            --gray-light: #f4f6f9;
            --gray-medium: #e0e7ef;
            --text: #2b2b2b;
            --shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            --radius: 12px;
            --transition: 0.3s ease;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(to bottom right, #eef5ff, #f9fbff);
            color: var(--text);
        }

        .main-content {
            margin-left: 240px;
            padding: 60px 40px 50px;
        }

        h2 {
            font-size: 34px;
            font-weight: 800;
            margin-bottom: 25px;
            color: var(--primary-dark);
            line-height: 1.4;
            border-left: 6px solid var(--primary-dark);
            padding-left: 16px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 25px;
        }

        .btn {
            background-color: var(--primary);
            color: var(--white);
            padding: 12px 24px;
            border-radius: var(--radius);
            font-weight: 600;
            text-decoration: none;
            box-shadow: var(--shadow);
            transition: background-color var(--transition), transform var(--transition);
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        th, td {
            padding: 16px 18px;
            text-align: center;
            font-size: 15px;
            vertical-align: middle;
        }

        th {
            background-color: var(--primary-dark);
            color: var(--white);
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        tbody tr:nth-child(even) {
            background-color: var(--gray-light);
        }

        tbody tr:hover {
            background-color: var(--gray-medium);
        }

        .action-links a {
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-size: 13px;
            font-weight: 600;
            margin: 0 4px;
            transition: background-color var(--transition), transform var(--transition);
        }

        .edit-btn {
            background-color: var(--primary);
        }

        .edit-btn:hover {
            background-color: var(--primary-dark);
            transform: scale(1.05);
        }

        .delete-btn {
            background-color: var(--danger);
        }

        .delete-btn:hover {
            background-color: var(--danger-dark);
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
                margin-left: 0;
            }

            h2 {
                font-size: 24px;
                padding-left: 10px;
            }

            th, td {
                font-size: 13px;
                padding: 10px;
            }

            .btn {
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>Amenities List</h2>

    <div class="top-bar">
        <a class="btn" href="AddAmenitiesDashboard"><i class="fa fa-plus"></i> Add Amenity</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Amenity Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="a" items="${amenitiesList}">
                <tr>
                    <td>${a.amenityId}</td>
                    <td>${a.name}</td>
                    <td>${a.description}</td>
                    <td class="action-links">
                        <a class="edit-btn" href="EditAmenitiesDashboard?id=${a.amenityId}"><i class="fa fa-edit"></i> Edit</a>
                        <a class="delete-btn" href="DeleteAmenitiesDashboard?id=${a.amenityId}" onclick="return confirm('Are you sure you want to delete this amenity?');"><i class="fa fa-trash"></i> Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
