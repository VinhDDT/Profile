<%-- 
    Document   : editCustomerDashboard
    Created on : Jun 18, 2025, 2:47:32 AM
    Author     : KHANH
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --main-color: #002b5c;
            --transition: 0.3s ease;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .main-content {
            margin-left: 60px;
            padding: 80px 20px 40px;
            transition: margin-left var(--transition);
        }

        .sidebar.open ~ .main-content {
            margin-left: 220px;
        }

        h2 {
            text-align: center;
            color: var(--main-color);
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            border-bottom: 2px solid var(--main-color);
            width: fit-content;
            margin: 0 auto 30px;
            padding-bottom: 10px;
        }

        form {
            max-width: 600px;
            margin: auto;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 43, 92, 0.15);
        }

        label {
            font-weight: bold;
            color: var(--main-color);
            display: block;
            margin-top: 14px;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            margin-bottom: 4px;
            box-sizing: border-box;
        }

        .custom-file-upload {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .file-label {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }

        .file-label:hover {
            background-color: #0056b3;
        }

        input[type="file"] {
            display: none;
        }

        #file-name {
            font-size: 13px;
            color: #555;
        }

        .error-message {
            font-size: 13px;
            color: red;
            margin-bottom: 10px;
            display: none;
        }

        input.invalid {
            border-color: red;
        }

        input[type="submit"], .button {
            padding: 12px 24px;
            background-color: var(--main-color);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .button {
            margin-left: 10px;
        }

        input[type="submit"]:hover,
        .button:hover {
            background-color: #004080;
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<%@ include file="../navbarDashboard/navbarDashboard.jsp" %>
<%@ include file="../sidebarDashboard/sidebarDashboard.jsp" %>

<div class="main-content">
    <h2>Edit Customer Information</h2>

    <form method="post" action="EditCustomerDashboard" onsubmit="return validateForm()" enctype="multipart/form-data">
        <input type="hidden" name="customerId" value="${customer.customerId}" />

        <label for="userName">Username:</label>
        <input type="text" id="userName" name="userName" maxlength="32" value="${customer.userName}" required>
        <div class="error-message" id="error-userName">Max 32 characters allowed.</div>

        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" maxlength="50" value="${customer.fullName}" required>
        <div class="error-message" id="error-fullName">Max 50 characters allowed.</div>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" maxlength="100" value="${customer.email}" required>
        <div class="error-message" id="error-email">Max 100 characters allowed.</div>
        <div class="error-message" id="error-email-format">Invalid email format.</div>

        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" maxlength="15" value="${customer.phone}">
        <div class="error-message" id="error-phone">Max 15 characters allowed.</div>
        <div class="error-message" id="error-phone-format">Phone must be Vietnamese format (03, 05, 07, 08, 09 + 8 digits).</div>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" maxlength="55" value="${customer.address}">
        <div class="error-message" id="error-address">Max 55 characters allowed.</div>

        <label for="gender">Gender:</label>
        <select name="gender" id="gender">
            <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
            <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
            <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>Other</option>
        </select>

        <label for="status">Status:</label>
        <input type="text" id="status" name="status" maxlength="20" value="${customer.status}">
        <div class="error-message" id="error-status">Max 20 characters allowed.</div>

        <label for="identityNumber">ID/Passport Number:</label>
        <input type="text" id="identityNumber" name="identityNumber" maxlength="25" value="${customer.identityNumber}">
        <div class="error-message" id="error-identityNumber">Max 25 characters allowed.</div>

        <!-- Avatar Upload -->
        <label>Avatar Image:</label>
        <div class="custom-file-upload">
            <label for="imageFile" class="file-label">📁 Choose Image</label>
            <input type="file" name="imageFile" id="imageFile" accept="image/*">
            <span id="file-name">No file chosen</span>
        </div>

        <input type="text" id="avatarUrl" name="avatarUrl" maxlength="250" placeholder="Or paste image URL here" value="${customer.avatarUrl}">
        <div class="error-message" id="error-avatarUrl">Max 250 characters allowed.</div>

        <div class="form-actions">
            <input type="submit" value="Update Information">
            <a href="javascript:history.back()" class="button">← Go Back</a>
        </div>
    </form>
</div>

<script>
    const fieldLimits = {
        userName: 32,
        fullName: 50,
        email: 100,
        phone: 15,
        address: 55,
        status: 20,
        identityNumber: 25,
        avatarUrl: 250
    };

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const vnPhoneRegex = /^(03|05|07|08|09)[0-9]{8}$/;

    const fileInput = document.getElementById('imageFile');
    const fileNameDisplay = document.getElementById('file-name');
    fileInput.addEventListener('change', () => {
        const file = fileInput.files[0];
        fileNameDisplay.textContent = file ? file.name : 'No file chosen';
        if (file) document.getElementById("avatarUrl").value = "";
    });

    const avatarUrlInput = document.getElementById("avatarUrl");
    avatarUrlInput.addEventListener("input", () => {
        if (avatarUrlInput.value.trim() !== "") {
            fileInput.value = "";
            fileNameDisplay.textContent = 'No file chosen';
        }
    });

    for (const fieldId in fieldLimits) {
        const input = document.getElementById(fieldId);
        const error = document.getElementById("error-" + fieldId);
        input.addEventListener("input", () => {
            const value = input.value;

            error.style.display = value.length > fieldLimits[fieldId] ? "block" : "none";
            input.classList.toggle("invalid", value.length > fieldLimits[fieldId]);

            if (fieldId === "email") {
                const formatError = document.getElementById("error-email-format");
                formatError.style.display = !emailRegex.test(value) ? "block" : "none";
                input.classList.toggle("invalid", !emailRegex.test(value));
            }

            if (fieldId === "phone") {
                const formatError = document.getElementById("error-phone-format");
                formatError.style.display = value && !vnPhoneRegex.test(value) ? "block" : "none";
                input.classList.toggle("invalid", value && !vnPhoneRegex.test(value));
            }
        });
    }

    function validateForm() {
        let valid = true;
        for (const fieldId in fieldLimits) {
            const input = document.getElementById(fieldId);
            const value = input.value;

            if (value.length > fieldLimits[fieldId]) {
                document.getElementById("error-" + fieldId).style.display = "block";
                input.classList.add("invalid");
                valid = false;
            }

            if (fieldId === "email" && !emailRegex.test(value)) {
                document.getElementById("error-email-format").style.display = "block";
                input.classList.add("invalid");
                valid = false;
            }

            if (fieldId === "phone" && value && !vnPhoneRegex.test(value)) {
                document.getElementById("error-phone-format").style.display = "block";
                input.classList.add("invalid");
                valid = false;
            }
        }
        return valid;
    }
</script>

</body>
</html>

