<%-- 
    Document   : equipment
    Created on : May 19, 2025, 10:51:02 AM
    Author     : KHANH
--%>

<%@page import="models.MaintenanceStatuses"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, models.MaintenanceSchedule, dao.EquipmentDao"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:formatDate value="${ms.date}" pattern="yyyy-MM-dd HH:mm"/>



<!DOCTYPE html>
<html>
    <head>
    <title>Lịch Bảo Trì Thiết Bị</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #2E8B57;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Màu theo trạng thái */
        .pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .inprogress {
            background-color: #cce5ff;
            color: #004085;
        }

        .completed {
            background-color: #d4edda;
            color: #155724;
        }

        .cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 30px;
        }
    </style>
</head>
    <body>
        <h1>LỊCH BẢO TRÌ THIẾT BỊ</h1>
        <table>
            <tr>
                
                <th>Phòng</th>
                <th>Thiết bị</th>
                <th>Ngày bảo trì</th>
                <th>Trạng thái</th>
                <th>Nhân viên phụ trách</th>
            </tr>
            <c:forEach var="ms" items="${list}">
    <tr>
        
        <td>${ms.rooms.roomNumber}</td>
        <td>${ms.equipment.equipmentName}</td>
        <td>${ms.date}</td>
        <td>${ms.maintenanceStatuses.statusName}</td>
        <td>${ms.users.userName} </td>
    </tr>
    
            </c:forEach>
        </table>
    </body>
</html>
