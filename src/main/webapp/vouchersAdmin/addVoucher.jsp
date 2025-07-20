<%-- 
    Document   : addVoucher
    Created on : May 14, 2025, 3:48:15 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Voucher Mới</title>
        <style>
            * {
                box-sizing: border-box;
            }

            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: "Segoe UI", sans-serif;
                background-color: #f1f3f5;
            }

            body {
                padding-top: 100px; /* Tùy vào chiều cao thật của navbar */
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            form {
                width: 100%;
                max-width: 700px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                display: flex;
                flex-direction: column;
                margin-bottom: 40px; /* Cho đẹp phần cuối */
            }

            h1 {
                text-align: center;
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: 500;
                margin-bottom: 0.25rem;
            }

            input, select, textarea {
                padding: 0.6rem;
                font-size: 1rem;
                border: 1px solid #ccc;
                border-radius: 8px;
                width: 100%;
            }

            textarea {
                resize: none;
                height: 60px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 1rem;
                margin-top: 0.5rem;
            }

            button, .cancel-btn {
                flex: 1;
                padding: 0.75rem;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                cursor: pointer;
                text-align: center;
            }

            button {
                background-color: #007bff;
                color: white;
            }

            .cancel-btn {
                background-color: #e0e0e0;
                color: #333;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            button:hover {
                background-color: #0056b3;
            }

            .cancel-btn:hover {
                background-color: #ccc;
            }


            .tooltip-warning {
                position: absolute;
                top: -35px;
                left: 0;
                background-color: #f44336;
                color: white;
                padding: 6px 10px;
                border-radius: 5px;
                font-size: 13px;
                white-space: nowrap;
                display: none;
                z-index: 10;
            }

            .tooltip-warning::after {
                content: '';
                position: absolute;
                bottom: -6px;
                left: 10px;
                border-width: 6px;
                border-style: solid;
                border-color: #f44336 transparent transparent transparent;
            }


        </style>



    </head>
    <body>

        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>


        <form action="AddVoucher" method="post">
            <h1>Add New Voucher</h1>

            <div class="form-fields">
                <div class="form-group">
                    <label for="code">Voucher code</label>
                    <input type="text" id="code" name="code" maxlength="50" placeholder="Maximum 50 characters" required>

                    <% if (request.getAttribute("error") != null) { %>
                    <div style="color:red;"><%= request.getAttribute("error") %></div>
                    <% } %>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" id="quantity" name="quantity" min="1" max="1000" required placeholder="Quantity max = 1000"
                           oninput="validateMax(this)" />
                </div>


                <div class="form-group">
                    <label for="discountPercent">Reduce %</label>
                    <input type="number" step="0.1" min="1" max="100" name="discountPercent" required placeholder="e.g. 10.5%, max 100%">
                </div>

                <div class="form-group">
                    <label for="minOrderAmount">Minimum application</label>
                    <input type="number" id="minOrderAmount" name="minOrderAmount" 
                           min="1000" max="10000000" step="1000" required placeholder="Maximun 10.000.000"
                           oninput="validateMaxOrder(this)">
                </div>


                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="datetime-local" id="startDate" name="startDate" required>
                </div>


                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="datetime-local" id="endDate" name="endDate" required>
                </div>


                <div class="form-group">
                    <label for="description">Describe</label>
                    <textarea id="description" name="description" maxlength="200" placeholder="Maximum 200 characters"></textarea>
                </div>


                <div class="form-group">
                    <label for="isActive">Status</label>
                    <select id="isActive" name="isActive">
                        <option value="false" selected>Inactive</option>
                        <option value="true">Active</option>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit">Add voucher</button>
                    <a href="VouchersDashBoard" class="cancel-btn">Cancel</a>
                </div>

            </div>
        </form>
    </body>
    <script>
        function pad(n) {
            return n.toString().padStart(2, '0');
        }

        function getFormattedDateTimeLocal(date) {
            return date.getFullYear() + '-' +
                    pad(date.getMonth() + 1) + '-' +
                    pad(date.getDate()) + 'T' +
                    pad(date.getHours()) + ':' +
                    pad(date.getMinutes());
        }

        document.addEventListener('DOMContentLoaded', function () {
            const startInput = document.getElementById('startDate');
            const endInput = document.getElementById('endDate');

            const now = new Date();
            const nowFormatted = getFormattedDateTimeLocal(now);

            startInput.min = nowFormatted;
            startInput.value = nowFormatted;

            endInput.min = nowFormatted;
            endInput.value = nowFormatted;

            startInput.addEventListener('change', function () {
                const startValue = startInput.value;
                endInput.min = startValue;

                if (endInput.value < startValue) {
                    endInput.value = startValue;
                }
            });
        });


        //giới hạn chữ
        const codeInput = document.getElementById('code');
        const codeTooltip = document.getElementById('code-tooltip');

        const descInput = document.getElementById('description');
        const descTooltip = document.getElementById('desc-tooltip');

        codeInput.addEventListener('input', () => {
            codeTooltip.style.display = codeInput.value.length >= 50 ? 'block' : 'none';
        });

        descInput.addEventListener('input', () => {
            descTooltip.style.display = descInput.value.length >= 200 ? 'block' : 'none';
        });


        window.addEventListener('DOMContentLoaded', () => {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            const currentDate = `${yyyy}-${mm}-${dd}`;
                    document.getElementById('startDate').value = currentDate;
                });
                function validateMax(input) {
                    if (parseInt(input.value) > 1000) {
                        input.value = 1000;
                    }
                }

                function validateMaxOrder(input) {
                    const max = 10000000;
                    if (parseInt(input.value) > max) {
                        input.value = max;
                    }
                }

                function updateCurrentTime() {
                    const now = new Date();
                    now.setMinutes(now.getMinutes() - now.getTimezoneOffset()); // Điều chỉnh theo múi giờ
                    const localDatetime = now.toISOString().slice(0, 16); // yyyy-MM-ddTHH:mm
                    document.getElementById('startDate').value = localDatetime;
                }

                window.addEventListener('DOMContentLoaded', () => {
                    updateCurrentTime(); // Gọi ngay khi trang load
                    setInterval(updateCurrentTime, 60000); // Cập nhật mỗi phút
                });

    </script>

</html>