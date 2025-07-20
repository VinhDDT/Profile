<%-- 
    Document   : report
    Created on : Jun 21, 2025, 5:02:11 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Reports</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --sidebar-width: 250px;
            --sidebar-collapsed-width: 60px;
            --navy: #4a6fa5;
            --white: #ffffff;
            --gray-bg: #f0f2f5;
            --table-header: #007BFF;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--gray-bg);
        }

        .main-wrapper {
            display: flex;
        }

       

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-button, .add-button {
            background-color: #007BFF;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .back-button i,
        .add-button i {
            margin-right: 8px;
        }

        .back-button:hover,
        .add-button:hover {
            background-color: #0056b3;
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
            font-size: 14px;
        }

        th {
            background-color: var(--table-header);
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .no-data {
            padding: 16px;
            background-color: #fff3cd;
            color: #856404;
            border-radius: 6px;
            margin-top: 10px;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .btn-update {
            background-color: #ffc107;
            color: #000;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }

        .btn-update:hover {
            background-color: #e0a800;
        }

        @media screen and (max-width: 768px) {
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 30px 16px 16px;
            }

            table {
                font-size: 13px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .back-button, .add-button {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>

<div class="main-wrapper">
    <%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

    <div class="main-content">
        <div class="header">
            <div class="header-left">
                <h2><i class="fa-solid fa-file-lines"></i> Room Report List</h2>
                <button class="back-button" onclick="history.back()">
                    <i class="fa-solid fa-arrow-left"></i> Back
                </button>
            </div>
            <a href="AddNewReport" class="add-button">
                <i class="fa-solid fa-plus"></i> Add New Report
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty reportList}">
                <div class="no-data">There are no reports available.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Room</th>
                            <th>Customer Reporter</th>
                            <th>User Reporter</th>
                            <th>Reported Time</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Handled By</th>
                            <th>Handled Time</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reportList}">
                            <tr>
                                <td>${r.reportId}</td>
                                <td>${r.roomId}</td>
                                <td>${r.reportedByCustomerId}</td>
                                <td>${r.reportedByUserId}</td>
                                <td>${r.reportTime}</td>
                                <td>${r.description}</td>
                                <td>${r.status}</td>
                                <td>${r.handledBy}</td>
                                <td>${r.handledTime}</td>
                                <td>${r.notes}</td>
                                <td>
                                    <form action="UpdateReport" method="get">
                                        <input type="hidden" name="reportId" value="${r.reportId}" />
                                        <button type="submit" class="btn-update">
                                            <i class="fa-solid fa-pen-to-square"></i> Update
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
