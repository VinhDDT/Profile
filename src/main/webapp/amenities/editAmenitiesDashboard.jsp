<%-- 
    Document   : editAmenitiesDashboard
    Created on : Jun 16, 2025, 12:37:26 AM
    Author     : KHANH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Amenity</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --primary-color: #0a2f5c;
            --primary-hover: #0c3f7c;
            --background: #ffffff;
            --form-bg: #f4faff;
            --input-border: #ccc;
            --radius: 12px;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
            --navy: #4a6fa5;
            --transition: 0.3s ease;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e4f0ff, #ffffff);
            animation: fadeInBody 1s ease forwards;
        }

        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* SIDEBAR ANIMATION */
        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            height: calc(100% - 60px);
            width: 60px;
            background-color: var(--navy);
            transition: width var(--transition);
            overflow-x: hidden;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
            z-index: 999;
        }

        .sidebar.open {
            width: 220px;
        }

        .toggle-btn {
            background-color: var(--primary-hover);
            color: white;
            font-size: 20px;
            cursor: pointer;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .menu li a {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            text-decoration: none;
            color: white;
            font-size: 16px;
            white-space: nowrap;
            transition: background-color var(--transition);
        }

        .menu li a i {
            margin-right: 14px;
            font-size: 18px;
            width: 20px;
            text-align: center;
        }

        .menu li a span {
            display: none;
        }

        .sidebar.open .menu li a span {
            display: inline;
        }

        .menu li a:hover {
            background-color: #3a5c88;
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: 60px;
            padding: 80px 20px 40px;
            transition: margin-left var(--transition), opacity 0.5s ease;
            animation: slideInMain 0.8s ease forwards;
            opacity: 0;
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        @keyframes slideInMain {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-container {
            background-color: var(--form-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 40px;
            max-width: 500px;
            margin: auto;
            animation: scaleIn 0.7s ease-out forwards;
            transform: scale(0.98);
            opacity: 0;
        }

        @keyframes scaleIn {
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 10px;
            font-size: 26px;
        }

        .description {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 6px;
            font-weight: 600;
            color: var(--primary-color);
        }

        label::before {
            content: attr(data-icon) " ";
            margin-right: 4px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--input-border);
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
            background-color: #fff;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .error-message {
            color: red;
            font-size: 13px;
            margin-top: 4px;
            display: none;
        }

        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 30px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: var(--primary-hover);
            transform: scale(1.03);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: color 0.2s ease;
        }

        .back-link a:hover {
            color: var(--primary-hover);
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

<!-- Include Navbar and Sidebar -->
<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<!-- Main Content -->
<div class="main-content">
    <div class="form-container">
        <h1>🛠️ Edit Amenity</h1>
        <p class="description">Please fill in the details below to update this amenity in the system.</p>

        <form action="${pageContext.request.contextPath}/EditAmenitiesDashboard" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="id" value="${a.amenityId}" />

            <label for="name" data-icon="🏷️">Amenity Name:</label>
            <input type="text" id="name" name="name" maxlength="35" required value="${a.name}" oninput="checkNameLength(this)" />
            <div id="name-error" class="error-message">You have exceeded the 35-character limit.</div>

            <label for="description" data-icon="📝">Description:</label>
            <textarea id="description" name="description" maxlength="250" oninput="checkDescriptionLength(this)">${a.description}</textarea>
            <div id="desc-error" class="error-message">You have exceeded the 250-character limit.</div>

            <button type="submit">Update Amenity</button>
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

    // Toggle sidebar effect
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
        document.querySelector('.main-content').classList.toggle('sidebar-open');
    }
</script>

</body>
</html>
