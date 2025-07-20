<%-- 
    Document   : messageForCustomer
    Created on : Jul 10, 2025, 9:37:20 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Chat với Lễ Tân</title>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f3f4f6;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }
            header {
                background-color: #2563eb;
                color: white;
                padding: 16px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
            }
            main {
                flex: 1;
                padding: 16px;
                overflow-y: auto;
                display: flex;
                flex-direction: column;
                gap: 12px;
                background-color: #f9fafb;
            }
            .message {
                max-width: 70%;
                padding: 10px 14px;
                border-radius: 16px;
                line-height: 1.4;
                word-wrap: break-word;
            }
            .reception {
                background-color: #2563eb;
                color: white;
                align-self: flex-end;
            }
            .customer {
                background-color: white;
                border: 1px solid #ddd;
                align-self: flex-start;
            }
            footer {
                background-color: white;
                display: flex;
                gap: 8px;
                padding: 12px;
                border-top: 1px solid #e5e7eb;
            }
            input[type="text"] {
                flex: 1;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 20px;
                font-size: 14px;
            }
            button {
                padding: 10px 16px;
                background-color: #2563eb;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
            }
            button:hover {
                background-color: #1d4ed8;
            }
        </style>
    </head>
    <body>

        <header>🧑‍💬 Trò chuyện với Lễ Tân</header>

        <main id="chatBox"></main>

        <footer>
            <input type="text" id="msgInput" placeholder="Nhập tin nhắn..." />
            <button onclick="sendMessage()">Gửi</button>
        </footer>
        <input id="customerId" type="hidden"  value="${sessionScope.customerId}" />
        <script>

            const ws = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/notification");// sửa lại đúng endpoint WebSocket
            let customerId = null;
            document.addEventListener("DOMContentLoaded", function () {

                customerId = document.getElementById("customerId").value;

                ws.onopen = () => {
                    console.log("Kết nối WebSocket thành công");
                };

                ws.onmessage = (event) => {
                    const data = JSON.parse(event.data);
//                if (data.status === "success") {
//                    appendMessage(data.user + ": " + data.text);
//                } else if (data.status === "error") {
//                    alert("❌ Gửi tin nhắn thất bại. Lỗi: " + data.message);
//                }
                    const msgDiv = document.createElement("div");
                    if (data.senderType === "customer") {
                        msgDiv.classList.add("message", "customer"); // Gửi từ mình (hiện bên phải)
                    } else {
                        msgDiv.classList.add("message", "reception"); // Gửi từ lễ tân (hiện bên trái)
                    }
                    msgDiv.textContent = data.message;
                    document.getElementById("chatBox").appendChild(msgDiv);
                    document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
                };
                document.getElementById("msgInput").addEventListener("keydown", function (event) {
                    if (event.key === "Enter" && !event.shiftKey) {
                        event.preventDefault(); // Ngăn xuống dòng
                        sendMessage(); // Gọi hàm gửi tin nhắn
                    }
                });


            });
            function sendMessage() {
                const input = document.getElementById("msgInput");
                const msg = input.value.trim();
                if (msg === "")
                    return;

                const data = {
                    customerId: customerId,
                    senderType: "customer",
                    message: msg
                };

                ws.send(JSON.stringify(data));
                const msgDiv = document.createElement("div");
                msgDiv.classList.add("message", "reception");
                msgDiv.textContent = msg;
                document.getElementById("chatBox").appendChild(msgDiv);
                document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;

                input.value = "";
            }

        </script>
    </body>
</html>

