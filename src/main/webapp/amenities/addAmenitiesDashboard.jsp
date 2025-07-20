<%-- 
    Document   : addAmenitiesDashboard
    Created on : Jun 15, 2025, 10:06:09 PM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${a != null ? 'Edit Amenity' : 'Add New Amenity'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --main-color: #0a2f5c;
            --hover-color: #0c3f7c;
            --bg-color: #f0f6ff;
            --text-color: #333;
            --radius: 10px;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
            --transition: 0.3s ease;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e4f0ff, #ffffff);
        }

        .main-content {
            margin-left: 240px;
            padding: 60px 20px 40px;
        }

        .form-wrapper {
            background-color: var(--bg-color);
            padding: 40px 30px;
            max-width: 540px;
            width: 100%;
            margin: auto;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        h2 {
            text-align: center;
            color: var(--main-color);
            margin-bottom: 10px;
            font-size: 26px;
        }

        .description-text {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: var(--main-color);
        }

        label::before {
            content: attr(data-icon) " ";
            margin-right: 5px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: var(--radius);
            font-size: 15px;
            background-color: #fff;
            transition: border 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--main-color);
            box-shadow: 0 0 5px rgba(10, 47, 92, 0.4);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .error-message {
            color: red;
            font-size: 13px;
            margin-bottom: 15px;
            display: none;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: var(--main-color);
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: var(--radius);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: var(--hover-color);
            transform: scale(1.05);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            text-decoration: none;
            color: var(--main-color);
            font-weight: bold;
            font-size: 14px;
            transition: color 0.2s ease;
        }

        .back-link a:hover {
            color: var(--hover-color);
        }
    </style>
</head>
<body>

 <%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>
<div class="main-content">
    <div class="form-wrapper">
        <h2>${a != null ? '🛠️ Edit Amenity' : '➕ Add New Amenity'}</h2>
        <p class="description-text">
            Please fill in the details below to ${a != null ? 'update the amenity' : 'add a new amenity'} to the system.
        </p>

        <form action="${pageContext.request.contextPath}/${a != null ? 'EditAmenitiesDashboard' : 'AddAmenitiesDashboard'}"
              method="post" onsubmit="return validateForm()">
            <c:if test="${a != null}">
                <input type="hidden" name="id" value="${a.amenityId}" />
            </c:if>

            <label for="name" data-icon="🏷️">Amenity Name:</label>
            <input type="text" id="name" name="name" maxlength="35" required value="${a != null ? a.name : ''}" oninput="checkNameLength(this)">
            <div id="name-error" class="error-message">You have exceeded the 35-character limit.</div>

            <label for="description" data-icon="📝">Description:</label>
            <textarea id="description" name="description" maxlength="250" oninput="checkDescriptionLength(this)">${a != null ? a.description : ''}</textarea>
            <div id="desc-error" class="error-message">You have exceeded the 250-character limit.</div>

            <div class="button-group">
                <input type="submit" value="${a != null ? 'Update' : 'Add'}">
                <input type="reset" value="Reset">
            </div>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/ViewAmenitiesDashboard">← Back to Amenities List</a>
        </div>
    </div>

</div>

<script>
    function checkNameLength(input) {
        const errorMsg = document.getElementById("name-error");
        errorMsg.style.display = input.value.length > 35 ? "block" : "none";
    }

    function checkDescriptionLength(input) {
        const errorMsg = document.getElementById("desc-error");
        errorMsg.style.display = input.value.length > 250 ? "block" : "none";
    }

    function validateForm() {
        const name = document.getElementById("name");
        const desc = document.getElementById("description");
        const nameError = document.getElementById("name-error");
        const descError = document.getElementById("desc-error");

        let isValid = true;

        if (name.value.length > 35) {
            nameError.style.display = "block";
            name.focus();
            isValid = false;
        }

        if (desc.value.length > 250) {
            descError.style.display = "block";
            desc.focus();
            isValid = false;
        }

        return isValid;
    }
</script>

</body>
</html>
