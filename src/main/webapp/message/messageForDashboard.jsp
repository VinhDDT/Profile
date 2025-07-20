<%-- 
    Document   : messageForDashboard
    Created on : Jul 10, 2025, 9:41:48 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Nhân viên trực – Chat</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, sans-serif;
                height: 100vh;
                display: flex;
                flex-direction: column;
                background-color: #f0f2f5;
            }

            .navbar {
                background-color: #0068FF; /* Zalo Blue */
                color: white;
                padding: 16px;
                font-size: 18px;
                font-weight: bold;
                text-align: center;
                border-bottom: 1px solid #ccc;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .main-content {
                display: flex;
                flex: 1;
                height: calc(100vh - 60px);
            }

            .sidebar {
                width: 280px;
                background-color: #ffffff;
                border-right: 1px solid #e0e0e0;
                padding: 20px;
                overflow-y: auto;
            }

            .sidebar h2 {
                margin-top: 0;
                font-size: 18px;
                color: #333;
                margin-bottom: 16px;
                border-bottom: 1px solid #e0e0e0;
                padding-bottom: 8px;
            }

            .user {
                padding: 10px 12px;
                margin-bottom: 10px;
                background-color: #f5f5f5;
                border-radius: 8px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 10px;
                transition: background 0.3s;
            }

            .user:hover {
                background-color: #e0e7ff;
            }

            .user.active {
                background-color: #dbeafe;
            }

            .status-dot {
                width: 10px;
                height: 10px;
                background-color: #34d399;
                border-radius: 50%;
            }

            .user span {
                font-weight: 500;
                color: #333;
            }

            .chat-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                background-color: #f9fafb;
            }

            .chat-header {
                background-color: #f3f4f6;
                padding: 16px;
                font-size: 16px;
                font-weight: bold;
                color: #0068FF;
                border-bottom: 1px solid #e5e7eb;
            }

            main {
                flex: 1;
                padding: 16px;
                overflow-y: auto;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .message {
                max-width: 70%;
                padding: 10px 14px;
                border-radius: 18px;
                line-height: 1.5;
                word-break: break-word;
                font-size: 14px;
            }

            .customer {
                align-self: flex-start;
                background-color: #e5e7eb;
                color: #1f2937;
            }

            .reception {
                align-self: flex-end;
                background-color: #0068FF;
                color: white;
            }

            footer {
                background-color: white;
                padding: 12px;
                border-top: 1px solid #e5e7eb;
                display: flex;
                gap: 10px;
            }

            input[type="text"] {
                flex: 1;
                padding: 10px;
                font-size: 14px;
                border-radius: 20px;
                border: 1px solid #cbd5e1;
            }

            button {
                padding: 10px 16px;
                background-color: #0068FF;
                color: white;
                border: none;
                border-radius: 20px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0053cc;
            }
        </style>
    </head>
    <body>

        <div class="navbar">
            🧑‍💼 Hệ thống trực tin nhắn khách hàng
        </div>



        <div class="main-content">
            <div class="sidebar">
                <h2>👥 Người dùng đang nhắn</h2>
               
            </div>
            <div id="firstUserName"></div> <!-- Thẻ sẽ hiển thị tên người đầu tiên -->
            <div class="chat-area">
                <div class="chat-header">💬 Hộp thoại với Nguyễn Văn A</div>

                <main id="chatBox">
                    <!-- Tin nhắn sẽ được thêm vào bằng JS -->
                </main>


                <footer>
                    <input type="text" id="msgInput" placeholder="Nhập tin nhắn..." />
                    <button onclick="sendMessage()">Gửi</button>
                </footer>
            </div> <!-- 🔴 Thẻ này bị thiếu trong bản cũ -->
        </div>


        <script>
            let messageCount = 0;
            const userType = "staff"; // Lễ tân
            const ws = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/notification");
            ws.onopen = () => {
                console.log("Lễ tân đã kết nối WebSocket");
                    const request = {
        type: "getRecentSenders"
    };
                  console.log("📤 Gửi yêu cầu lấy recentSenders:", request);

                  ws.send(JSON.stringify({ type: "getRecentSenders" }));
            };

           ws.onmessage = (event) => {
    const data = JSON.parse(event.data);

      console.log("📥 Nhận dữ liệu từ server:", event.data);
    if (data.type === "recentSenders") {
        const users = data.data;
        const sidebar = document.querySelector(".sidebar");
        sidebar.innerHTML = "<h2>👥 Người dùng đang nhắn</h2>"; // reset giao diện

        users.forEach(u => {
               console.log("🧑‍💼 Danh sách recentSenders nhận được từ server:", users);
            const div = document.createElement("div");
            div.className = "user";
            const span = document.createElement("span");
            span.textContent = u.userName || "Không có tên";
            const dot = document.createElement("div");
            dot.className = "status-dot";
            div.appendChild(dot);
            div.appendChild(span);

            // Bắt sự kiện click để mở đoạn chat
            div.addEventListener("click", () => {
                loadChatByCustomerId(u.customerId);
            });

            sidebar.appendChild(div);
        });

        return; 
    }

    if(data.senderType && data.messsage){
    const msgDiv = document.createElement("div");
    if (data.senderType === "customer") {
        msgDiv.classList.add("message", "customer");
    } else {
        msgDiv.classList.add("message", "reception");
    }
    msgDiv.textContent = data.message;
    document.getElementById("chatBox").appendChild(msgDiv);
    document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
    }
};


            document.getElementById("msgInput").addEventListener("keydown", function (event) {
                if (event.key === "Enter" && !event.shiftKey) {
                    event.preventDefault(); // Ngăn xuống dòng
                    sendMessage(); // Gọi hàm gửi tin nhắn
                }
            });
            function sendMessage() {
               
                const input = document.getElementById("msgInput");
                const msg = input.value.trim();
                if (msg === "")
                    return;
                const data = {
                    customerId: "1",
                    senderType: "reception",
                    message: msg
                };
                if (ws.readyState === WebSocket.OPEN) {
                    ws.send(JSON.stringify(data));
                } else {
                    console.warn("⚠️ WebSocket chưa mở, không thể gửi dữ liệu!");
                }

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
