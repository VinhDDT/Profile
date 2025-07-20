<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <title>Create New News</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/dashboard.css"> <!-- nếu bạn đã tách dashboard chung -->
        <!-- <link rel="stylesheet" href="css/newsForm.css"> --> <!-- nếu muốn tách riêng CSS form -->
        <style>
            .container {
                max-width: 800px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px 25px;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                border-top: 6px solid #4a6fa5;
                position: relative;
            }

            .back-button {
                position: absolute;
                top: -35px;
                left: 10px;
                background-color: #4a6fa5;
                color: white;
                padding: 6px 10px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #3a5c88;
            }

            h1 {
                text-align: center;
                color: #1a237e;
                font-size: 28px;
                margin-bottom: 35px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
            }

            input[type="text"],
            textarea,
            select {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                background-color: #fdfdfd;
                transition: border 0.2s;
            }

            input:focus,
            textarea:focus,
            select:focus {
                border-color: #1a237e;
                outline: none;
            }

            textarea {
                resize: vertical;
            }

            .radio-group {
                margin-bottom: 20px;
            }

            .radio-group label {
                font-weight: normal;
                margin-right: 20px;
                color: #444;
            }

            .radio-group input[type="radio"] {
                margin-right: 6px;
            }

            .file-upload-section {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-bottom: 20px;
            }

            .file-label {
                background-color: #1a237e;
                color: white;
                padding: 10px 14px;
                border-radius: 5px;
                cursor: pointer;
                display: inline-block;
            }

            .disabled-input {
                opacity: 0.5;
                pointer-events: none;
            }

            button {
                background-color: #1a237e;
                color: white;
                padding: 14px;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0d154d;
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
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="content">
            <div class="container">
                <a href="javascript:history.back()" class="back-button"><i class="fa-solid fa-arrow-left"></i> Back</a>
                <h1><i class="fa-solid fa-pen-to-square"></i> Create New News</h1>

                <c:if test="${not empty message}">
                    <script>
                        alert("${message}");
                        window.location.href = "<c:url value='/Index' />";
                    </script>
                </c:if>

                <c:if test="${not empty listBuilding}">
                    <form action="AddNewsDashboard" method="post" onsubmit="return validateNewsForm();" enctype="multipart/form-data">
                        <label for="title">Title:</label>
                        <input type="text" id="title" name="title" maxlength="150" required data-tooltip="Required. Max 150 characters."/>

                        <label for="summary">Summary:</label>
                        <input type="text" id="summary" name="summary" maxlength="500" required data-tooltip="Required. Max 500 characters."/>

                        <!-- Loại bỏ phần chọn cách upload -->
                        <label for="imageFile">Upload Image:</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*" required />

                        <label for="content">Content:</label>
                        <textarea id="content" name="content" rows="5" required data-tooltip="At least 20 characters."></textarea>

                        <label>Publish Now:</label>
                        <div class="radio-group">
                            <label><input type="radio" name="isPublished" value="true" checked /> Yes</label>
                            <label><input type="radio" name="isPublished" value="false" /> No</label>
                        </div>

                        <label for="buildingID">Building:</label>
                        <select id="buildingID" name="buildingID" required data-tooltip="Please select a building.">
                            <option value="">-- Select Building --</option>
                            <c:forEach var="b" items="${listBuilding}">
                                <option value="${b.buildingId}">${b.buildingName}</option>
                            </c:forEach>
                        </select>

                        <button type="submit"><i class="fa-solid fa-plus"></i> Create News</button>
                    </form>
                </c:if>
            </div>
        </div>

        <script>
            function validateNewsForm() {
                const title = document.getElementById("title").value.trim();
                const summary = document.getElementById("summary").value.trim();
                const content = document.getElementById("content").value.trim();
                const buildingID = document.getElementById("buildingID").value;
                const fileInput = document.getElementById("imageFile");

                if (title === "" || title.length > 150) {
                    alert("Title must not be empty and must not exceed 150 characters.");
                    return false;
                }

                if (summary === "" || summary.length > 500) {
                    alert("Summary must not be empty and must not exceed 500 characters.");
                    return false;
                }

                if (!fileInput.files.length) {
                    alert("Please upload an image.");
                    return false;
                }

                if (content.length < 20) {
                    alert("Content must contain at least 20 characters.");
                    return false;
                }

                if (buildingID === "") {
                    alert("Please select a building.");
                    return false;
                }

                return true;
            }

            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            document.body.appendChild(tooltip);

            document.querySelectorAll('[data-tooltip]').forEach(el => {
                el.addEventListener('mouseenter', () => {
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

            function toggleImageUpload() {
                const method = document.querySelector('input[name="imageUploadMethod"]:checked').value;
                const fileGroup = document.getElementById("uploadFileGroup");
                const urlGroup = document.getElementById("uploadUrlGroup");

                if (method === "file") {
                    fileGroup.classList.remove("disabled-input");
                    urlGroup.classList.add("disabled-input");
                    document.getElementById("imageFile").disabled = false;
                    document.getElementById("imageURL").disabled = true;
                } else {
                    fileGroup.classList.add("disabled-input");
                    urlGroup.classList.remove("disabled-input");
                    document.getElementById("imageFile").disabled = true;
                    document.getElementById("imageURL").disabled = false;
                }
            }

            window.addEventListener("DOMContentLoaded", toggleImageUpload);
        </script>
    </body>
</html>