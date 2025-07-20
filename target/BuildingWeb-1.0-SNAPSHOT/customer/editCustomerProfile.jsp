<%-- 
    Document   : editCustomerProfile
    Created on : 13-Jun-2025, 02:15:11
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update User Profile</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding-top: 100px; /* tránh bị header che */
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: flex-start; /* tránh căn giữa dọc gây ẩn form */
                min-height: 100vh;
            }

            .form-container {
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                width: 100%;
                max-width: 400px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #555;
            }

            input[type="text"], input[type="date"], select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            input[type="submit"], button[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover, button[type="submit"]:hover {
                background-color: #218838;
            }

            .error-message {
                color: red;
                text-align: center;
                margin-bottom: 15px;
                font-weight: bold;
            }

            @media (max-width: 480px) {
                .form-container {
                    padding: 20px;
                    margin: 0 10px;
                }
            }

            .custom-file-upload {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
            }

            .custom-file-upload input[type="file"] {
                display: none;
            }

            .file-label {
                background-color: #007bff;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s;
            }

            .file-label:hover {
                background-color: #0056b3;
            }

            #file-name {
                font-size: 14px;
                color: #444;
            }

            .full-width input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .toggle-buttons {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .toggle-buttons button {
                flex: 1;
                padding: 10px;
                margin-right: 10px;
                font-weight: bold;
                cursor: pointer;
                border: 2px solid #ccc;
                background-color: #f8f9fa;
                color: #333;
                border-radius: 5px;
                transition: background-color 0.3s, border-color 0.3s;
            }

            .toggle-buttons button:last-child {
                margin-right: 0;
            }

            .toggle-buttons button.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .disabled-section {
                opacity: 0.4;
                pointer-events: none;
            }

            .back-button {
                top: -40px;
                left: 20px;
                width: 80px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #0c53b0;
            }
        </style>

        <script>
            function validateForm() {
                const name = document.forms["updateForm"]["fullName"].value;
                const dob = document.forms["updateForm"]["dateOfBirth"].value;
                const namePattern = /^[A-Za-zÀ-ỹ\s]{1,100}$/;

                if (!namePattern.test(name)) {
                    alert("Name must contain only letters and spaces, and be up to 100 characters long.");
                    return false;
                }

                if (name.length > 100) {
                    alert("Full name must not exceed 100 characters.");
                    return false;
                }

                const today = new Date();
                const dobDate = new Date(dob);
                let age = today.getFullYear() - dobDate.getFullYear();
                const m = today.getMonth() - dobDate.getMonth();
                if (m < 0 || (m === 0 && today.getDate() < dobDate.getDate())) {
                    age--;
                }

                if (age < 18) {
                    alert("User must be at least 18 years old.");
                    return false;
                }

                return true;
            }

            window.onload = function () {
                const today = new Date();
                today.setFullYear(today.getFullYear() - 18);
                const maxDate = today.toISOString().split("T")[0];
                document.getElementById("dob").setAttribute("max", maxDate);
            };

            document.getElementById("imageFile").addEventListener("change", function () {
                const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                document.getElementById("file-name").textContent = fileName;
            });

            function setUploadMethod(method) {
                const fileSection = document.getElementById("file-upload-section");
                const urlSection = document.getElementById("url-upload-section");
                const fileInput = document.getElementById("imageFile");
                const urlInput = document.querySelector("input[name='imageUrl']");
                const btnFile = document.getElementById("btn-file");
                const btnUrl = document.getElementById("btn-url");

                if (method === "file") {
                    fileSection.classList.remove("disabled-section");
                    urlSection.classList.add("disabled-section");
                    fileInput.disabled = false;
                    urlInput.disabled = true;
                    btnFile.classList.add("active");
                    btnUrl.classList.remove("active");
                } else {
                    fileSection.classList.add("disabled-section");
                    urlSection.classList.remove("disabled-section");
                    fileInput.disabled = true;
                    urlInput.disabled = false;
                    btnFile.classList.remove("active");
                    btnUrl.classList.add("active");
                }
            }

            window.onload = function () {
                // Gán max cho ngày sinh
                const today = new Date();
                today.setFullYear(today.getFullYear() - 18);
                const maxDate = today.toISOString().split("T")[0];
                document.getElementById("dob").setAttribute("max", maxDate);

                // Gán mặc định: upload file
                setUploadMethod("file");

                // Hiển thị tên file khi chọn ảnh
                document.getElementById("imageFile").addEventListener("change", function () {
                    const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                    document.getElementById("file-name").textContent = fileName;
                });
            };
        </script>
    </head>
    <body>
        <%@include file="../header/header.jsp" %>

        <div class="form-container">
            <br>
            <br>
            <br>
            <a href="javascript:history.back()" class="back-button">← Back</a>
            <h2>Update Profile</h2>

            <!-- Display error message if exists -->
            <c:if test="${not empty message}">
                <div class="error-message">${message}</div>
            </c:if>

            <!-- Display form if user information is available -->
            <c:if test="${not empty userInfomation}">
                <form name="updateForm" action="EditCustomerProfile" method="post" onsubmit="return validateForm();" enctype="multipart/form-data"">
                    <input type="hidden" name="id" value="${customerId}" />

                    <!-- FULL NAME -->
                    <label>Full Name:</label>
                    <input type="text" name="fullName"
                           value="${userInfomation.fullName}"
                           maxlength="100"
                           pattern="^[A-Za-zÀ-ỹ\s]{1,100}$"
                           title="❗ Only letters and spaces allowed. No numbers or special characters. Max 100 characters."
                           required />

                    <!-- ADDRESS -->
                    <label>Address:</label>
                    <input type="text" name="address"
                           value="${userInfomation.address}"
                           maxlength="255"
                           title="🏠 Enter your current address. Max 255 characters." />

                    <!-- GENDER -->
                    <label>Gender:</label>
                    <select name="gender" title="⚧️ Select your gender from the list.">
                        <option value="Male" ${userInfomation.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${userInfomation.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${userInfomation.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>

                    <!-- DATE OF BIRTH -->
                    <label>Date of Birth:</label>
                    <input type="date" name="dateOfBirth" id="dob"
                           value="${userInfomation.dateOfBirth}"
                           required
                           title="🎂 You must be at least 18 years old to register." />

                    <input type="hidden" name="oldAvatar" value="${userInfomation.avatarUrl}" />
                    <!-- AVATAR UPLOAD -->
                    <label>Upload Avatar:</label>
                    <div class="custom-file-upload">
                        <label for="imageFile" class="file-label">📁 Choose Image</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*" />
                        <span id="file-name">No file chosen</span>
                    </div>
                    <br>
                    <button type="submit">Save</button>
                </form>
            </c:if>
        </div>
    </body>
</html>
