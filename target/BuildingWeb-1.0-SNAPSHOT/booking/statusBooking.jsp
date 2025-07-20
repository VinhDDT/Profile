<%-- 
    Document   : statusBooking
    Created on : Jul 17, 2025, 5:26:57 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%
    String responseCode = request.getParameter("vnp_ResponseCode"); // "00" là thành công
    String txnRef = request.getParameter("vnp_TxnRef");
    String orderInfo = request.getParameter("vnp_OrderInfo");
  String amountStr = request.getParameter("vnp_Amount");
long amount = (long) Double.parseDouble(amountStr); 

    String time = request.getParameter("vnp_PayDate");

    request.setAttribute("responseCode", responseCode);
    request.setAttribute("txnRef", txnRef);
    request.setAttribute("orderInfo", orderInfo);
    request.setAttribute("amount", amount);
    request.setAttribute("time", time);
%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background: #f4f6f9;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .result-container {
                background: #fff;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 500px;
                text-align: center;
            }

            .result-container.success {
                border-top: 8px solid #28a745;
            }

            .result-container.fail {
                border-top: 8px solid #dc3545;
            }

            .result-icon {
                font-size: 64px;
                margin-bottom: 20px;
            }

            .success .result-icon {
                color: #28a745;
            }

            .fail .result-icon {
                color: #dc3545;
            }

            h2 {
                margin-bottom: 10px;
            }

            .detail {
                margin-top: 20px;
                text-align: left;
                font-size: 16px;
            }

            .detail p {
                margin: 8px 0;
            }

            .btn {
                display: inline-block;
                margin-top: 30px;
                padding: 12px 24px;
                background: #007bff;
                color: #fff;
                border-radius: 6px;
                text-decoration: none;
                transition: background 0.3s;
            }

            .btn:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>

        <div class="result-container ${responseCode == '00' ? 'success' : 'fail'}">
            <div class="result-icon">
                ${responseCode == '00' ? '✅' : '❌'}
            </div>
            <h2>
                ${responseCode == '00' ? 'Payment Successful!' : 'Payment Failed!'}
            </h2>

            <p>
                ${responseCode == '00' 
                  ? 'Thank you! Your payment has been processed successfully.' 
                  : 'Sorry, there was a problem processing your payment. Please try again.'}
            </p>

            <div class="detail">
                <p><strong>Transaction ID:</strong> ${txnRef}</p>
                <p><strong>Order Info:</strong> ${orderInfo}</p>
                <!--<p><strong>Amount:</strong> ${amount != null ? (amount / 100) : 0} VND</p>-->
                <p><strong>Payment Time:</strong> ${time}</p>
                <!--<p><strong>Status Code:</strong> ${responseCode}</p>-->
            </div>

            <a href="ViewRooms?status=${responseCode}" class="btn">Back</a>
        </div>

    </body>
</html>
