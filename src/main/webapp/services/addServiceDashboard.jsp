<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <title>Add New Service</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            .form-container {
                max-width: 700px;
                margin: auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 6px;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
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

            .btn {
                display: block;
                margin: auto;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                background-color: #3498db;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #2980b9;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
            }

            .back-link a {
                color: #2980b9;
                text-decoration: none;
            }

            .back-link a:hover {
                text-decoration: underline;
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

            .floating-tooltip {
                position: absolute;
                background-color: #333;
                color: #fff;
                font-size: 13px;
                padding: 6px 10px;
                border-radius: 5px;
                pointer-events: none;
                z-index: 999;
                white-space: nowrap;
                display: none;
                opacity: 0.9;
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
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <div class="form-container">
            <h2>Add New Service</h2>
            <form action="AddServiceDashboard" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="serviceName">Service Name:</label>
                    <input type="text" id="serviceName" name="name" maxlength="100" pattern="^[A-Za-z0-9\s]+$" required title="Maximum 100 characters. Letters, numbers and spaces only.">
                </div>

                <div class="form-group">
                    <label for="unitType">Unit Type:</label>
                    <select id="unitSelect" onchange="toggleUnitInput(this.value)">
                        <option value="1 item">1 item</option>
                        <option value="1 time">1 time</option>
                        <option value="1 turn">1 turn</option>
                        <option value="other">Other...</option>
                    </select>
                    <div id="customUnitWrapper" style="margin-top: 10px;
                         display: none;">
                        <input type="text" id="customUnitInput" placeholder="Type your own..." maxlength="50" pattern="^[\w\d\s]+$" oninput="updateUnitType()" title="Only letters, digits and spaces allowed.">
                    </div>
                    <input type="hidden" id="unitType" name="unitType" required />
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" minlength="10" maxlength="1000" required title="Between 10 and 1000 characters."></textarea>
                </div>

                <div class="form-group">
                    <label for="price">Price (VND):</label>
                    <input type="text" id="price" name="price" required inputmode="numeric" title="Only digits. From 10,000 to 10,000,000. Will auto-format with dot separator">
                </div>

                <div class="form-group">
                    <label>Choose Image File:</label>
                    <div class="custom-file-upload">
                        <label for="imageFile" class="file-label">📂 Choose File</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*">
                        <span id="file-name">No file chosen</span>
                    </div>
                </div>

                <button type="submit" class="btn">📂 Add Service</button>
            </form>
            <div class="back-link">
                <a href="ViewServicesDashboard">⬅ Back to List of Services</a>
            </div>
        </div>

        <div id="tooltip" class="floating-tooltip"></div>

        <script>
            function toggleUnitInput(value) {
                const customWrapper = document.getElementById("customUnitWrapper");
                const customInput = document.getElementById("customUnitInput");
                const unitHidden = document.getElementById("unitType");
                if (value === "other") {
                    customWrapper.style.display = "block";
                    customInput.value = "";
                    unitHidden.value = "";
                } else {
                    customWrapper.style.display = "none";
                    unitHidden.value = value;
                }
            }

            function updateUnitType() {
                const customInput = document.getElementById("customUnitInput");
                const unitHidden = document.getElementById("unitType");
                unitHidden.value = customInput.value.trim();
            }

            function validateForm() {
                const priceInput = document.getElementById("price");
                const rawPrice = priceInput.value.replaceAll(".", "");
                const price = parseInt(rawPrice);
                if (isNaN(price) || price < 10000 || price > 10000000) {
                    alert("Price must be between 10,000 and 10,000,000 VND.");
                    return false;
                }
                priceInput.value = rawPrice;
                return true;
            }

            document.addEventListener("DOMContentLoaded", () => {
                // Format giá tiền khi nhập
                const priceInput = document.getElementById("price");
                priceInput.addEventListener("input", function (e) {
                    let val = e.target.value.replace(/\D/g, "");
                    val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                    e.target.value = val;
                });

                // Set mặc định cho đơn vị tính
                toggleUnitInput(document.getElementById("unitSelect").value);

                // Gán tên file khi chọn ảnh
                const imageInput = document.getElementById("imageFile");
                const fileNameSpan = document.getElementById("file-name");
                imageInput.addEventListener("change", function () {
                    const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                    fileNameSpan.textContent = fileName;
                });

                // Tooltip hướng dẫn sử dụng
                const tooltip = document.getElementById("tooltip");
                const fields = [
                    {id: "serviceName", text: "❗ Only letters, numbers, and spaces. Max 100 characters."},
                    {id: "unitSelect", text: "📦 Select a predefined unit or type your own."},
                    {id: "customUnitInput", text: "✏️ Only letters, numbers, and spaces. Max 50 characters."},
                    {id: "description", text: "📝 Description should be between 10 and 1000 characters."},
                    {id: "price", text: "💰 Price must be between 10,000 and 10,000,000 VND."}
                ];

                fields.forEach(field => {
                    const el = document.getElementById(field.id);
                    if (!el)
                        return;

                    el.addEventListener("mouseenter", () => {
                        tooltip.textContent = field.text;
                        tooltip.style.display = "block";
                    });

                    el.addEventListener("mousemove", (e) => {
                        tooltip.style.left = (e.pageX + 15) + "px";
                        tooltip.style.top = (e.pageY + 15) + "px";
                    });

                    el.addEventListener("mouseleave", () => {
                        tooltip.style.display = "none";
                    });
                });
            });
        </script>
    </body>
</html>
