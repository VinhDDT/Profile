<%-- 
    Document   : editVoucher
    Created on : May 18, 2025, 2:00:54 PM
    Author     : CE180441_Dương Đinh Thế Vinh
--%>

<%@page import="models.Vouchers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Sửa Voucher</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            :root {
                --primary: #002b5c;
                --background: #f4f6f9;
                --white: #ffffff;
                --gray: #e0e0e0;
                --text: #333;
                --shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: "Segoe UI", sans-serif;
                background-color: var(--background);
                color: var(--text);
                animation: fadeInBody 0.5s ease-in-out;
            }

            @keyframes fadeInBody {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .main-content {
                margin-left: 60px;
                padding: 80px 30px 40px;
                transition: margin-left 0.3s ease;
                animation: slideInMain 0.6s ease forwards;
                opacity: 0;
            }

            .sidebar.open ~ .main-content {
                margin-left: 220px;
            }

            @keyframes slideInMain {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            form {
                width: 100%;
                max-width: 700px;
                background: var(--white);
                border-radius: 16px;
                box-shadow: var(--shadow);
                padding: 2rem;
                display: flex;
                flex-direction: column;
                margin: auto;
            }

            h2 {
                margin: 0 0 1rem;
                text-align: center;
                font-size: 1.8rem;
                color: var(--primary);
            }

            .form-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 1rem;
            }

            label {
                font-weight: 600;
                margin-bottom: 0.3rem;
                color: #555;
            }

            input, select, textarea {
                padding: 0.6rem;
                font-size: 1rem;
                border: 1px solid #ccc;
                border-radius: 8px;
                width: 100%;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 1rem;
                margin-top: 1rem;
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
                background-color: #28a745;
                color: white;
            }

            button:hover {
                background-color: #218838;
            }

            .cancel-btn {
                background-color: var(--gray);
                color: #333;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .cancel-btn:hover {
                background-color: #ccc;
            }

            input[readonly], textarea[readonly] {
                background-color: #e0e0e0;
                cursor: not-allowed;
            }
        </style>
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

            function validateForm() {
                const discount = parseFloat(document.getElementById("discountPercent").value);
                if (isNaN(discount) || discount < 0.01 || discount > 100) {
                    alert("Discount percent must be between 1.00 and 100.00.");
                    return false;
                }

                const decimalPlaces = (discount.toString().split('.')[1] || '').length;
                if (decimalPlaces > 2) {
                    alert("Discount percent must not have more than 2 decimal places.");
                    return false;
                }
                return true;
            }

            window.addEventListener("DOMContentLoaded", function () {
                const startInput = document.getElementById('startDate');
                const endInput = document.getElementById('endDate');

                if (!startInput || !endInput)
                    return;

                const now = new Date();
                const nowFormatted = getFormattedDateTimeLocal(now);

                if (!startInput.value) {
                    startInput.value = nowFormatted;
                    startInput.min = nowFormatted;
                }

                if (!endInput.value) {
                    endInput.value = nowFormatted;
                    endInput.min = nowFormatted;
                } else {
                    endInput.min = startInput.value;
                }

                startInput.addEventListener('change', function () {
                    endInput.min = startInput.value;
                    if (endInput.value < startInput.value) {
                        endInput.value = startInput.value;
                    }
                });
            });
        </script>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <div class="main-content">
            <form action="/EditVoucher" method="post" onsubmit="return validateForm()">
                <h2>Edit Voucher</h2>
                <input type="hidden" name="voucherId" value="${voucher.voucherId}" />

                <c:set var="isLocked" value="${voucher.isActive}" />

                <div class="form-group">
                    <label for="code">Voucher code</label>
                    <input type="text" id="code" name="code" maxlength="50" value="${voucher.code}" required placeholder="Maximum 50 characters"
                           ${isLocked ? 'readonly' : ''} />

                    <% if (request.getAttribute("error") != null) { %>
                    <div style="color: red;"><%= request.getAttribute("error") %></div>
                    <% } %>

                </div>
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" id="quantity" name="quantity"
                           min="1" max="1000" value="${voucher.quantity}" required ${isLocked ? 'readonly' : ''} placeholder="Quantity max = 1000"/>
                </div>

                <div class="form-group">
                    <label for="discountPercent">Reduce (%)</label>
                    <input type="number" step="0.1" min="1" max="100" id="discountPercent" name="discountPercent"
                           value="${voucher.discountPercent}" required ${isLocked ? 'readonly' : ''} placeholder="e.g. 10.5%, max 100%"/>
                </div>

                <div class="form-group">
                    <label for="minOrderAmount">Minimum order</label>
                    <input type="number" id="minOrderAmount" name="minOrderAmount"
                           min="1" max="10000000" value="${voucher.minOrderAmount}" required ${isLocked ? 'readonly' : ''} placeholder="Maximun 10.000.000"/>
                </div>

                <div class="form-group">
                    <label for="startDate">Start date</label>
                    <input type="datetime-local" id="startDate" name="startDate" value="${voucher.formattedStartDate}" required ${isLocked ? 'readonly' : ''} />
                </div>

                <div class="form-group">
                    <label for="endDate">End date</label>
                    <input type="datetime-local" id="endDate" name="endDate" value="${voucher.formattedEndDate}" required ${isLocked ? 'readonly' : ''} />
                </div>

                <div class="form-group">
                    <label for="description">Describe</label>
                    <textarea id="description" name="description" maxlength="200" placeholder="Maximum 200 characters" ${isLocked ? 'readonly' : ''}>${voucher.description}</textarea>
                </div>
                <div class="form-group">
                    <label for="isActive">Status</label>
                    <select id="isActive" name="isActive">
                        <option value="false" ${!voucher.isActive ? 'selected' : ''}>Inactive</option>
                        <option value="true" ${voucher.isActive ? 'selected' : ''}>Active</option>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit">Update</button>
                    <a href="VouchersDashBoard" class="cancel-btn">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>

