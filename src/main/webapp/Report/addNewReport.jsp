<%-- 
    Document   : addNewReport
    Created on : Jul 3, 2025, 4:01:18 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Room Report</title>
</head>
<body>
<h2>Add New Room Report</h2>

<c:if test="${not empty error}">
    <div style="color: red">${error}</div>
</c:if>

<form method="post" action="AddNewReport">
    Room ID: <input type="number" name="roomId" required><br><br>
    Customer ID: <input type="number" name="reportedByCustomerId" required><br><br>
    User ID: <input type="number" name="reportedByUserId" required><br><br>
    Description: <br>
    <textarea name="description" rows="4" cols="50" required></textarea><br><br>
    <button type="submit">Submit Report</button>
</form>
</body>
</html>