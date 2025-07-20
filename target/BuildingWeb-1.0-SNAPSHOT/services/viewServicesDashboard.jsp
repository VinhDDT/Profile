<%-- 
    Document   : viewServicesDashboard
    Created on : 17-Jun-2025, 23:44:45
    Author     : dodan
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <title>Danh sách dịch vụ</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
                color: #333;
            }

            .main-content {
                margin-left: 60px;
                padding: 30px;
                transition: margin-left 0.3s ease;
            }

            .sidebar.open ~ .main-content {
                margin-left: 220px;
            }

            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
                font-size: 32px;
            }

            a button, .back-button {
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
                transition: background-color 0.3s ease;
                margin-bottom: 20px;
                display: inline-block;
                text-decoration: none;
            }

            a button:hover, .back-button:hover {
                background-color: #2980b9;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                border-radius: 10px;
                overflow: hidden;
            }

            thead {
                background-color: #e8f0fe;
            }

            th, td {
                padding: 12px 14px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                vertical-align: middle;
            }

            tbody tr:hover {
                background-color: #f6f9fc;
            }

            img {
                max-height: 50px;
                border-radius: 4px;
            }

            .btn {
                padding: 6px 12px;
                font-size: 14px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin: 2px 0;
            }

            .btn-update {
                background-color: #f1c40f;
                color: #000;
            }

            .btn-update:hover {
                background-color: #d4ac0d;
            }

            .btn-delete {
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-delete:hover {
                background-color: #c0392b;
            }

            form {
                display: inline;
            }

            .back-button {
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
            }

            @media (max-width: 768px) {
                th, td {
                    font-size: 13px;
                    padding: 8px;
                }

                a button {
                    font-size: 14px;
                    padding: 8px 16px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <h1>List of Services</h1>
            <a href="javascript:history.back()" class="back-button">← Back</a>
            <a href="AddServiceDashboard">
                <button type="button">➕ Add Service</button>
            </a>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Service Name</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${listS}">
                        <tr>
                            <td>${s.serviceId}</td>
                            <td>${s.serviceName}</td>
                            <td>${s.unitType}</td>
                            <td>${s.price}</td>
                            <td><img src="${s.imageURL}" alt="Hình ảnh dịch vụ"></td>
                            <td>
                                <c:choose>
                                    <c:when test="${s.isActive}"><span style="color: green;">✔ Active</span></c:when>
                                    <c:otherwise><span style="color: red;">✘ Deactivated</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="ViewServiceDetailDashboard" method="get">
                                    <input type="hidden" name="id" value="${s.serviceId}" />
                                    <button type="submit" class="btn btn-update">👁️ View</button>
                                </form>
                                <form action="EditServiceDashboard" method="get">
                                    <input type="hidden" name="id" value="${s.serviceId}" />
                                    <button type="submit" class="btn btn-update">✏️ Edit</button>
                                </form>
                                <form action="DeleteServiceDashboard" method="get" onsubmit="return confirm('Are you sure you want to delete this service?');">
                                    <input type="hidden" name="id" value="${s.serviceId}" />
                                    <button type="submit" class="btn btn-delete">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>