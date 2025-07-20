<%-- 
    Document   : editServiceDashboard
    Created on : 18-Jun-2025, 01:29:57
    Author     : dodan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Service Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --transition-speed: 0.3s;
                --sidebar-width-collapsed: 60px;
                --sidebar-width-expanded: 220px;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 20px;
                transition: margin-left var(--transition-speed);
            }

            .main-content {
                margin-left: var(--sidebar-width-collapsed);
                transition: margin-left var(--transition-speed);
                padding: 20px;
            }

            .sidebar.open ~ .main-content {
                margin-left: var(--sidebar-width-expanded);
            }

            .container {
                max-width: 700px;
                margin: auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333333;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
                position: relative;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 6px;
                color: #444;
            }

            input[type="text"],
            input[type="number"],
            input[type="file"],
            textarea {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 14px;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            .checkbox-group label {
                font-weight: normal;
            }

            .tooltip {
                position: absolute;
                background-color: #333;
                color: #fff;
                padding: 6px 10px;
                border-radius: 5px;
                font-size: 13px;
                display: none;
                white-space: nowrap;
                z-index: 10;
                pointer-events: none;
            }

            .image-upload-toggle {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 14px;
                font-weight: 600;
                color: #333;
            }

            .image-upload-toggle label {
                display: flex;
                align-items: center;
                gap: 6px;
                cursor: pointer;
            }

            .disabled-input {
                opacity: 0.5;
                pointer-events: none;
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

            button {
                background-color: #007bff;
                color: white;
                padding: 12px 20px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0056b3;
            }

            .back-button {
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
                margin-bottom: 20px;
                margin-left: 10px;
                transition: margin-left var(--transition-speed);
            }

            .sidebar.open ~ .main-content .back-button {
                margin-left: calc(var(--sidebar-width-expanded) + 10px);
            }

            @media screen and (max-width: 768px) {
                .container {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <div class="container">
                <h1>Update Service</h1>
                <form action="${pageContext.request.contextPath}/EditServiceDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                    <input type="hidden" name="serviceId" value="${s.serviceId}" />

                    <div class="form-group">
                        <label>Service Name:</label>
                        <input type="text" name="name" value="${s.serviceName}" maxlength="100" required 
                               pattern="^[A-Za-z0-9\s]+$"
                               data-tooltip="Must not contain special characters. Max 100 characters." />
                        <div class="tooltip"></div>
                    </div>

                    <div class="form-group">
                        <label>Unit Type:</label>
                        <input type="text" name="unitType" value="${s.unitType}" maxlength="50" required 
                               pattern="^[\w\d\s]+$"
                               data-tooltip="Letters, digits, and spaces only. Max 50 characters." />
                        <div class="tooltip"></div>
                    </div>

                    <div class="form-group">
                        <label>Description:</label>
                        <textarea name="description" rows="4" minlength="10" maxlength="1000" required
                                  data-tooltip="Must be between 10 and 1000 characters.">${s.description}</textarea>
                        <div class="tooltip"></div>
                    </div>

                    <div class="form-group">
                        <label>Price (VND):</label>
                        <input type="text" name="price" id="price" required
                               inputmode="numeric"
                               value="${s.price}"
                               data-tooltip="Only numbers. Between 1,000 and 1,000,000,000. Must be divisible by 1,000." />
                        <div class="tooltip"></div>
                    </div>

                    <div class="form-group">
                        <label>Upload Image:</label>
                        <div class="custom-file-upload">
                            <label for="imageFile" class="file-label">📂 Choose File</label>
                            <input type="file" name="imageFile" id="imageFile" accept="image/*">
                            <span id="file-name">No file chosen</span>
                        </div>
                        <div style="margin-top: 8px; color: #666;">
                            Current: <span style="font-style: italic;">${s.imageURL}</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Status:</label>
                        <div class="checkbox-group">
                            <label><input type="radio" name="isActive" value="true" ${s.isActive ? 'checked' : ''} /> Active</label><br>
                            <label><input type="radio" name="isActive" value="false" ${!s.isActive ? 'checked' : ''} /> Deactivated</label>
                        </div>
                    </div>

                    <button type="submit">Update Service</button>
                    <br>
                    <br>
                    <br>
                    <a href="javascript:history.back()" class="back-button">← Back</a>
                </form>
            </div>
        </div>

        <script>
            function validateForm() {
                const name = document.getElementsByName("name")[0].value.trim();
                const unitType = document.getElementsByName("unitType")[0].value.trim();
                const desc = document.getElementsByName("description")[0].value.trim();
                const priceStr = document.getElementById("price").value.replaceAll(".", "");

                if (!/^[A-Za-z0-9\s]+$/.test(name) || name.length > 100) {
                    alert("Service Name must not be empty, max 100 characters, and contain no special characters.");
                    return false;
                }

                if (!/^[\w\d\s]+$/.test(unitType) || unitType.length > 50) {
                    alert("Unit Type must be valid and up to 50 characters.");
                    return false;
                }

                if (desc.length < 10 || desc.length > 1000) {
                    alert("Description must be between 10 and 1000 characters.");
                    return false;
                }

                const price = parseInt(priceStr);
                if (isNaN(price) || price < 1000 || price > 1000000000 || price % 1000 !== 0) {
                    alert("Price must be a valid number between 1,000 and 1,000,000,000 divisible by 1,000.");
                    return false;
                }
                document.getElementById("price").value = priceStr;

                return true;
            }

            document.addEventListener("DOMContentLoaded", function () {
                const priceInput = document.getElementById("price");
                priceInput.addEventListener("input", function (e) {
                    let val = e.target.value.replace(/\D/g, "");
                    val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                    e.target.value = val;
                });

                const imageInput = document.getElementById("imageFile");
                if (imageInput) {
                    imageInput.addEventListener("change", function () {
                        const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                        document.getElementById("file-name").textContent = fileName;
                    });
                }

                const tooltip = document.createElement('div');
                tooltip.className = 'tooltip';
                document.body.appendChild(tooltip);

                document.querySelectorAll('[data-tooltip]').forEach(el => {
                    el.addEventListener('mouseenter', (e) => {
                        tooltip.textContent = el.getAttribute('data-tooltip');
                        tooltip.style.display = 'block';
                    });
                    el.addEventListener('mousemove', (e) => {
                        tooltip.style.left = e.pageX + 15 + 'px';
                        tooltip.style.top = e.pageY + 10 + 'px';
                    });
                    el.addEventListener('mouseleave', () => {
                        tooltip.style.display = 'none';
                    });
                });
            });
        </script>
    </body>
</html>

