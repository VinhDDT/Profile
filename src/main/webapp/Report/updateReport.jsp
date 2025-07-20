<%-- 
    Document   : updatereport
    Created on : Jul 1, 2025, 2:30:12 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    models.Report report = (models.Report) request.getAttribute("report");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật Báo cáo Phòng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .form-container {
            max-width: 750px;
            margin: 40px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            text-align: center;
            color: #333;
        }

        .form-container label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        .form-container input,
        .form-container textarea,
        .form-container select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .form-container button {
            margin-top: 25px;
            padding: 12px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        .form-container button:hover {
            background-color: #0056b3;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #007BFF;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <a href="ViewAllRoomReportsController" class="back-btn">&larr; Quay lại danh sách</a>
    <h2>Cập nhật Báo cáo Phòng</h2>

    <form action="UpdateReport" method="post">
        <input type="hidden" name="reportId" value="${report.reportId}" />

        <label>Mã Phòng (RoomId):</label>
        <input type="number" name="roomId" value="${report.roomId}" required />

        <label>Mã Khách Hàng (ReportedByCustomerId):</label>
        <input type="number" name="reportedByCustomerId"
               value="<c:out value='${report.reportedByCustomerId}' default=''/>" />

        <label>Mã Nhân Viên Báo Cáo (ReportedByUserId):</label>
        <input type="number" name="reportedByUserId"
               value="<c:out value='${report.reportedByUserId}' default=''/>" />

        <label>Thời gian báo cáo (yyyy-MM-dd HH:mm:ss):</label>
        <input type="text" name="reportTime"
               value="<fmt:formatDate value='${report.reportTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" required />

        <label>Mô tả sự cố:</label>
        <textarea name="description" rows="4" required>${report.description}</textarea>

        <label>Trạng thái:</label>
        <select name="status" required>
            <option value="Pending" <c:if test="${report.status == 'Pending'}">selected</c:if>>Pending</option>
            <option value="In Progress" <c:if test="${report.status == 'In Progress'}">selected</c:if>>In Progress</option>
            <option value="Resolved" <c:if test="${report.status == 'Resolved'}">selected</c:if>>Resolved</option>
        </select>

        <label>Mã Nhân Viên Xử Lý (HandledBy):</label>
        <input type="number" name="handledBy"
               value="<c:out value='${report.handledBy}' default=''/>" />

        <label>Thời gian xử lý (yyyy-MM-dd HH:mm:ss):</label>
        <input type="text" name="handledTime"
               value="<c:choose>
                          <c:when test='${not empty report.handledTime}'>
                              <fmt:formatDate value='${report.handledTime}' pattern='yyyy-MM-dd HH:mm:ss'/>
                          </c:when>
                          <c:otherwise></c:otherwise>
                      </c:choose>" />

        <label>Ghi chú:</label>
        <textarea name="notes" rows="3">${report.notes}</textarea>

        <button type="submit">Cập nhật</button>
    </form>
</div>

</body>
</html>
