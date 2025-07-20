<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update News</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --navy: #4a6fa5;
                --navy-dark: #3a5c88;
                --white: #ffffff;
                --light-bg: #f4f6f9;
                --hover-bg: #3a5c88;
                --transition: 0.3s ease;
                --sidebar-width-collapsed: 60px;
                --sidebar-width-expanded: 220px;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--light-bg);
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 700px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
                margin-top: 80px;
                margin-bottom: 40px;
                padding: 40px 30px;
                border-radius: 12px;
                background-color: #ffffff;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                transition: left 0.3s ease;
            }

            .sidebar.open ~ .container {
                left: calc(50% + var(--sidebar-width-expanded) / 2 - var(--sidebar-width-collapsed) / 2);
            }

            .back-button {
                position: absolute;
                top: -40px;
                left: 20px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
                z-index: 10;
            }

            .back-button:hover {
                background-color: #0c53b0;
            }

            h1 {
                text-align: center;
                color: var(--navy-dark);
                margin-bottom: 30px;
                font-size: 26px;
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
                border-color: var(--navy);
                outline: none;
            }

            textarea {
                resize: vertical;
            }

            .file-label {
                background-color: var(--navy-dark);
                color: white;
                padding: 10px 14px;
                border-radius: 5px;
                cursor: pointer;
                display: inline-block;
                margin-bottom: 10px;
            }

            .checkbox-group {
                margin-bottom: 20px;
            }

            button {
                background-color: #28a745;
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
                background-color: #218838;
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

            @media screen and (max-width: 768px) {
                .container {
                    margin: 100px 20px;
                    padding: 25px;
                }

                .sidebar.open ~ .container {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="container">
            <a href="javascript:history.back()" class="back-button">← Back</a>
            <h1>📝 Update News</h1>
            <form action="${pageContext.request.contextPath}/EditNewsDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                <input type="hidden" name="newsID" value="${news.newsID}" />

                <label>Title:</label>
                <input type="text" name="title" value="${news.title}" maxlength="150" required data-tooltip="Required. Max 150 characters." />

                <label>Summary:</label>
                <input type="text" name="summary" value="${news.summary}" maxlength="500" required data-tooltip="Required. Max 500 characters." />

                <label>Current Image:</label>
                <c:if test="${not empty news.imageURL}">
                    <div style="margin-bottom: 10px;">
                        <img src="${pageContext.request.contextPath}/${news.imageURL}" alt="Current Image" style="max-width: 100%; border: 1px solid #ccc; border-radius: 6px;" />
                    </div>
                </c:if>

                <label for="imageFile" class="file-label">
                    📂 Upload New Image (Optional)
                    <input type="file" name="image" id="imageFile" accept="image/*" style="display: none;" />
                </label>

                <input type="hidden" name="existingImageURL" value="${news.imageURL}" />

                <label>Content:</label>
                <textarea name="content" rows="5" required data-tooltip="Minimum 20 characters.">${news.content}</textarea>

                <label>Publish:</label>
                <div class="checkbox-group">
                    <input type="checkbox" name="isPublished" value="true" ${news.isPublished ? 'checked' : ''} /> Yes
                </div>

                <label>Building:</label>
                <select name="buildingID" required data-tooltip="Select the building this news belongs to.">
                    <option value="">-- Select Building --</option>
                    <c:forEach var="b" items="${listBuilding}">
                        <option value="${b.buildingId}" <c:if test="${b.buildingId == news.buildingID}">selected</c:if>>${b.buildingName}</option>
                    </c:forEach>
                </select>

                <input type="hidden" name="viewcount" value="${news.viewcount}" readonly />

                <button type="submit">✅ Update News</button>
            </form>
        </div>

        <script>
            function validateForm() {
                const title = document.getElementsByName("title")[0].value.trim();
                const summary = document.getElementsByName("summary")[0].value.trim();
                const content = document.getElementsByName("content")[0].value.trim();
                const buildingID = document.getElementsByName("buildingID")[0].value;

                if (title === "" || title.length > 150) {
                    alert("Title must not be empty and must be at most 150 characters.");
                    return false;
                }

                if (summary === "" || summary.length > 500) {
                    alert("Summary must not be empty and must be at most 500 characters.");
                    return false;
                }

                if (content.length < 20) {
                    alert("Content must be at least 20 characters long.");
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
        </script>
    </body>
</html>