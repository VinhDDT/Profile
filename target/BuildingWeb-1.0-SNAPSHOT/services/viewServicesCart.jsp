<%-- 
    Document   : viewServicesCart
    Created on : 21 Jun 2025, 15:23:59
    Author     : dodan
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Giỏ hàng dịch vụ</title>
        <style>
            table {
                width: 90%;
                margin: auto;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px 12px;
                text-align: center;
            }

            th {
                background-color: #f2f2f2;
            }

            h2 {
                text-align: center;
                margin: 20px 0;
            }
        </style>
    </head>
    <body>
        <h2>Giỏ hàng dịch vụ của bạn</h2>

        <c:choose>
            <c:when test="${empty list}">
                <p style="text-align:center;">Không có dịch vụ nào trong giỏ hàng.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID giỏ</th>
                            <th>Tên dịch vụ</th>
                            <th>Mã khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Số phòng</th>
                            <th>Ghi chú</th>
                            <th>Trạng thái</th>
                            <th>Mã nhân viên</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.cartId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.service}">
                                            ${item.service.serviceName}
                                        </c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item.customerId}</td>
                                <td>${fn:replace(item.orderDate, "T", " ")}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.room}">
                                            ${item.room.roomNumber}
                                        </c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item.notes}</td>
                                <td>${item.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </body>
</html>

