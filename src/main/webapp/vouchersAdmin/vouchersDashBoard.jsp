<%-- 
    Document   : voucherDashBoard
    Created on : May 19, 2025, 9:03:49 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>
<html>
    <head>
        <title>Voucher Management</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f2f4f7;
                color: #222;
                margin: 0;
                padding: 0;
            }

            .content-wrapper {
                padding: 20px;
                transition: margin 0.3s ease, transform 0.3s ease;
            }

            #sidebar.open ~ .content-wrapper {
                margin-left: 200px;
                transform: scale(0.95);
            }

            #navbar.open ~ .content-wrapper {
                margin-top: 60px;
            }

            .title {
                font-size: 30px;
                font-weight: 700;
                margin-bottom: 20px;
                color: #1f2d3d;
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .top-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .btn {
                display: inline-block;
                padding: 8px 16px;
                margin: 4px 0;
                border-radius: 6px;
                font-size: 14px;
                border: none;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.2s;
                min-width: 70px;
                text-align: center;
            }

            .btn-add {
                background-color: #007bff;
                color: #fff;
            }

            .btn-add:hover {
                background-color: #0069d9;
            }

            .btn-view {
                background-color: #3498db;
                color: #fff;
            }

            .btn-view:hover {
                background-color: #2d88c6;
            }

            .btn-edit {
                background-color: #f39c12;
                color: #fff;
            }

            .btn-edit:hover {
                background-color: #d68910;
            }

            .btn-delete {
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-delete:hover {
                background-color: #c0392b;
            }




            .btn-back {
                background-color: #bdc3c7;
                color: #fff;
                padding: 8px 14px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 500;
                margin-right: 10px;
                display: inline-block;
            }

            .btn-back:hover {
                background-color: #95a5a6;
            }

            .voucher-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            .voucher-table th, .voucher-table td {
                padding: 14px 18px;
                text-align: left;
                border-bottom: 1px solid #e1e4e8;
            }

            .voucher-table thead {
                background-color: #e9ecef;
            }

            .voucher-table th {
                font-weight: 600;
                color: #333;
            }

            .voucher-table tr:hover {
                background-color: #f5f8fa;
            }

            .action-buttons {
                justify-content: center;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .voucher-table th:nth-child(4),
            .voucher-table td:nth-child(4),
            .voucher-table th:nth-child(5),
            .voucher-table td:nth-child(5) {
                text-align: center;
            }

            .status {
                padding: 4px 10px;
                border-radius: 12px;
                font-weight: 500;
                font-size: 13px;
                display: inline-block;
            }

            .status.active {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .status.inactive {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            form {
                display: inline;
            }

            @media screen and (max-width: 768px) {
                .top-actions {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .voucher-table th, .voucher-table td {
                    font-size: 14px;
                }
            }
            .btn-load-more {
                padding: 10px 20px;
                background-color: #007bff;
                border: none;
                border-radius: 8px;
                color: white;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s ease;
            }

            .btn-load-more:hover {
                background-color: #0056b3;
            }


        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="content-wrapper">
            <h1 class="title">Voucher Management</h1>

            <%
    String error = (String) session.getAttribute("error");
    if (error != null) {
            %>
            <div style="color: #fff3cd; background-color: #ffc107; padding: 10px 20px; border-radius: 6px; margin-bottom: 15px;">
                <strong>Warning:</strong> <%= error %>
            </div>
            <%
                    session.removeAttribute("error"); // để không hiển thị lại khi F5
                }
            %>




            <div style="max-width: 1200px; margin: 0 auto;">
                <div class="top-actions">
                    <a href="Dashboard" class="btn btn-back">← Back to Dashboard</a>
                    <a href="AddVoucher" class="btn btn-add">Add Voucher</a>
                </div>

                <div class="voucher-list">
                    <table class="voucher-table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Voucher Code</th>
                                <th>Expiry</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>         
                        </thead>
                        <tbody>
                            <c:forEach var="v" items="${vouchers}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${v.code}</td>
                                    <td>${v.formattedEndDate}</td>
                                    <td>
                                        <span class="status ${v.isActive ? 'active' : 'inactive'}">
                                            ${v.isActive ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="AdminViewVoucher?voucherId=${v.voucherId}" class="btn btn-view">View</a>
                                            <a href="EditVoucher?voucherId=${v.voucherId}" class="btn btn-edit">Edit</a>
                                            <form action="DeleteVoucher" method="get" onsubmit="return confirm('Are you sure you want to delete this voucher?')">
                                                <input type="hidden" name="id" value="${v.voucherId}" />
                                                <button type="submit" class="btn btn-delete">Delete</button>

                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="loadMoreWrapper" style="text-align: center; margin-top: 20px;">
                        <button id="loadMoreBtn" class="btn btn-load-more">View More</button>
                    </div>

                </div>
            </div>
        </div>
    </body>
    <script>
        const rowsPerPage = 10;
        const rows = document.querySelectorAll(".voucher-table tbody tr");
        const loadMoreBtn = document.getElementById("loadMoreBtn");

        let visibleCount = 0;

        function showRows() {
            const nextCount = visibleCount + rowsPerPage;
            for (let i = visibleCount; i < nextCount && i < rows.length; i++) {
                rows[i].style.display = "table-row";
            }
            visibleCount = nextCount;

            // Ẩn nút nếu đã hiển thị hết
            if (visibleCount >= rows.length) {
                loadMoreBtn.style.display = "none";
            }
        }

        // Ẩn tất cả, chỉ hiện 10 dòng đầu
        rows.forEach(row => row.style.display = "none");
        showRows();

        loadMoreBtn.addEventListener("click", showRows);
    </script>

</html>