<%-- 
    Document   : report
    Created on : Jun 21, 2025, 5:02:11 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Report" %>
<%@include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Reports</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --sidebar-width: 250px;
            --navy: #4a6fa5;
            --white: #ffffff;
            --gray-bg: #f0f2f5;
            --table-header: #007BFF;
        }

        body {
            margin: 0;
            background-color: var(--gray-bg);
            font-family: 'Segoe UI', sans-serif;
            display: flex;
        }

        .main {
            margin-left: var(--sidebar-width);
            padding: 20px 30px;
            width: calc(100% - var(--sidebar-width));
            box-sizing: border-box;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-button {
            background-color: #007BFF;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .back-button i {
            margin-right: 8px;
        }

        .back-button:hover {
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

        @media screen and (max-width: 768px) {
            .main {
                margin-left: 0;
                width: 100%;
                padding: 16px;
            }

            table {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="main">
    <div class="header">
        <h2><i class="fa-solid fa-file-lines"></i> Room Report List</h2>
        <button class="back-button" onclick="history.back()">
            <i class="fa-solid fa-arrow-left"></i> Back
        </button>
    </div>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <%
        List<Report> reportList = (List<Report>) request.getAttribute("reportList");
        if (reportList == null || reportList.isEmpty()) {
    %>
        <div class="no-data">There are no reports available.</div>
    <%
        } else {
    %>
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
                </tr>
            </thead>
            <tbody>
                <% for (Report r : reportList) { %>
                    <tr>
                        <td><%= r.getReportId() %></td>
                        <td><%= r.getRoomId() %></td>
                        <td><%= r.getReportedByCustomerId() %></td>
                        <td><%= r.getReportedByUserId() %></td>
                        <td><%= r.getReportTime() %></td>
                        <td><%= r.getDescription() %></td>
                        <td><%= r.getStatus() %></td>
                        <td><%= r.getHandledBy() %></td>
                        <td><%= r.getHandledTime() %></td>
                        <td><%= r.getNotes() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>
