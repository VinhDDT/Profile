<%-- 
    Document   : editRoomForDashboard
    Created on : Jun 17, 2025, 8:18:40 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Room</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(to right, #f5f7fa, #c3cfe2);
                color: #333;
            }

            .form-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(6px);
                max-width: 800px;
                margin: 40px auto;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            }

            .form-container h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #007BFF;
            }

            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            label {
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 5px;
                display: block;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                width: 100%;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
                min-height: 60px;
            }

            .full-width {
                grid-column: 1 / -1;
            }

            button[type="submit"] {
                padding: 12px;
                background-color: #007BFF;
                color: white;
                font-weight: bold;
                font-size: 15px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s;
                grid-column: 1 / -1;
            }

            button[type="submit"]:hover {
                background-color: #0056b3;
            }

            .custom-file-upload {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .custom-file-upload input[type="file"] {
                display: none;
            }

            .custom-file-upload .file-label {
                background-color: #007BFF;
                color: white;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 500;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .custom-file-upload .file-label:hover {
                background-color: #0056b3;
            }

            .custom-file-upload #file-name {
                font-size: 13px;
                color: #555;
                font-style: italic;
            }


            @media screen and (max-width: 600px) {
                form {
                    grid-template-columns: 1fr;
                }
            }
            .bed-checkbox-group {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* mỗi hàng 3 item */
                gap: 10px 20px; /* khoảng cách hàng và cột */
                margin-top: 5px;
            }

            .bed-checkbox-group label {
                display: flex;
                align-items: center;
                gap: 6px; /* khoảng cách giữa checkbox và chữ */
                font-weight: 400;
                font-size: 14px;
            }
            @media screen and (max-width: 600px) {
                .bed-checkbox-group {
                    grid-template-columns: repeat(2, 1fr);
                }
            }


            /*popUp thông báo*/
            .popup-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0, 0, 0, 0.4);
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }



            .popup-box {
                background: #fff;
                padding: 25px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
                text-align: center;
                min-width: 300px;
                animation: fadeIn 0.3s ease;
            }

            .popup-box h3 {
                margin-top: 0;
                color: #d33;
            }

            .popup-box button {
                margin-top: 20px;
                padding: 10px 20px;
                border: none;
                background: #d33;
                color: white;
                border-radius: 6px;
                cursor: pointer;
            }

            .popup-box button:hover {
                background: #b22;
            }

            @keyframes fadeIn {
                from {
                    transform: scale(0.9);
                    opacity: 0;
                }
                to {
                    transform: scale(1);
                    opacity: 1;
                }
            }
        </style>

        <script>
            // Ẩn popup
            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }

            // Đóng khi click ra ngoài popup-box
            window.addEventListener("click", function (event) {
                const popup = document.getElementById("popup");
                const popupBox = document.querySelector(".popup-box");
                if (event.target === popup) {
                    hidePopup();
                }
            });
            // Dữ liệu từ server (JSP truyền giá trị check sang)
            document.addEventListener("DOMContentLoaded", function () {
                var check = ${check == null ? 0 : check}; // lấy biến từ JSP

                if (check === 1) {
                    document.getElementById("popup-message").innerText = "⚠️ RoomNumber đã tồn tại trong FloorNumber!";
                    document.getElementById("popup").style.display = "flex";
                } else if (check === 2) {
                    document.getElementById("popup-message").innerText = "✅ Tạo phòng thành công!";
                    document.getElementById("popup").style.display = "flex";
                } else if (check === 3) {
                    document.getElementById("popup-message").innerText = "❌ Lỗi kết nối cơ sở dữ liệu!";
                    document.getElementById("popup").style.display = "flex";
                }
            });
        </script>

    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <br>
        <br>
        <!-- Popup -->
        <div id="popup" class="popup-overlay">
            <div class="popup-box">
                <h3>Notification</h3>
                <p id="popup-message">Nội dung thông báo sẽ thay đổi bằng JavaScript</p>
                <button onclick="hidePopup()">Close</button>
            </div>
        </div>
        <div class="form-container">



            <h2>Edit Room</h2>


            <form action="EditRoomForDashboard" method="post" enctype="multipart/form-data"  >
                <input value="${roomDetail.roomId}" type="hidden" name="roomId"> 
                <div>
                    <label>Room Number:</label>
                    <input type="number" name="roomNumber" value="${roomDetail.roomNumber}"  min="0" max="9999" disabled="">
                </div>

                <div>
                    <label>Floor Number:</label>
                    <input type="number" name="floorNumber" value="${roomDetail.floorNumber}" min="0" max="100" required>
                </div>

                <div>
                    <label>Room Type:</label>
                    <select id="roomType" name="roomType" required>
                        <option <c:if test="${roomDetail.roomType eq 'Standard Room'}">selected</c:if> value="Standard Room">Standard Room</option>
                        <option <c:if test="${roomDetail.roomType eq 'Deluxe Room'}">selected</c:if> value="Deluxe Room">Deluxe Room</option>
                        <option  <c:if test="${roomDetail.roomType eq 'Twin Room'}">selected</c:if> value="Twin Room">Twin Room</option>
                        <option  <c:if test="${roomDetail.roomType eq 'Family Room'}">selected</c:if> value="Family Room">Family Room</option>
                        </select>
                    </div>

                    <div>
                        <label>Price (VNĐ):</label>
                        <input id="price" type="text" name="price" value="${roomDetail.price}" required>
                </div>

                <div class="full-width">
                    <p> ${roomDetail.bedType} </p>
                    <label>Bed Type:</label>
                    <div class="bed-checkbox-group">
                        <label id="single"><input <c:if test="${roomDetail.bedType eq 'Single Bed'}">checked</c:if> type="radio" name="bedType" value="Single Bed|1" > Single Bed</label>
                        <label id="double"><input <c:if test="${roomDetail.bedType eq 'Double Bed'}">checked</c:if> type="radio" name="bedType" value="Double Bed|2" > Double Bed</label>
                        <label id="queen"><input <c:if test="${roomDetail.bedType eq 'Queen Bed'}">checked</c:if> type="radio" name="bedType" value="Queen Bed|2" > Queen Bed</label>
                        <label id="king"><input <c:if test="${roomDetail.bedType eq 'King Bed'}">checked</c:if> type="radio" name="bedType" value="King Bed|2" > King Bed</label>
                        <label id="twin"><input <c:if test="${roomDetail.bedType eq 'Twin Beds'}">checked</c:if> type="radio" name="bedType" value="Twin Beds|2" > Twin Bed</label>
                            <div id="treePeople" style="display: none">
                                <label>Option 3 people</label>
                                <label ><input <c:if test="${roomDetail.bedType eq '1 Double Bed + 1 Single Bed'}">checked</c:if> type="radio" name="bedType" value="1 Double Bed + 1 Single Bed|3" > 1 Double Bed + 1 Single Bed</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '1 Queen Bed + 1 Single Bed'}">checked</c:if> type="radio" name="bedType" value="1 Queen Bed + 1 Single Bed|3" > 1 Queen Bed + 1 Single Bed</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '3 Single Beds'}">checked</c:if> type="radio" name="bedType" value="3 Single Beds|3" >3 Single Beds</label>
                            </div>
                            <div id="fourPeople" style="display: none">
                                <label>Option 4 people</label>
                                <label ><input <c:if test="${roomDetail.bedType eq '2 Double Beds'}">checked</c:if> type="radio" name="bedType" value="2 Double Beds|4" > 2 Double Beds</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '1 King Bed + 1 Double Bed'}">checked</c:if> type="radio" name="bedType" value="1 King Bed + 1 Double Bed|4" > 1 King Bed + 1 Double Bed</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '1 Queen Bed + 2 Single Beds'}">checked</c:if> type="radio" name="bedType" value="1 Queen Bed + 2 Single Beds|4" > 1 Queen Bed + 2 Single Beds</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '2 Twin Beds + 2 Single Beds'}">checked</c:if> type="radio" name="bedType" value="2 Twin Beds + 2 Single Beds|4" > 2 Twin Beds + 2 Single Beds</label>  
                            </div>
                            <div id="fivePeople" style="display: none">
                                <label>Option 5 people</label>
                                <label ><input <c:if test="${roomDetail.bedType eq '2 Double Beds + 1 Single Bed'}">checked</c:if> type="radio" name="bedType" value="2 Double Beds + 1 Single Bed|5" > 2 Double Beds + 1 Single Bed </label>
                            <label ><input <c:if test="${roomDetail.bedType eq '2 Queen Beds + 1 Single Bed'}">checked</c:if> type="radio" name="bedType" value="2 Queen Beds + 1 Single Bed|5" > 2 Queen Beds + 1 Single Bed</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '1 King Bed + 2 Single Beds'}">checked</c:if> type="radio" name="bedType" value="1 King Bed + 2 Single Beds|5" >1 King Bed + 2 Single Beds</label>
                            <label ><input <c:if test="${roomDetail.bedType eq '1 Double Bed + 3 Single Beds'}">checked</c:if> type="radio" name="bedType" value="1 Double Bed + 3 Single Beds|5" >1 Double Bed + 3 Single Beds</label>  
                            <label ><input <c:if test="${roomDetail.bedType eq '5 Single Beds'}">checked</c:if> type="radio" name="bedType" value="5 Single Beds|5" >5 Single Beds</label>  
                            </div>
                        </div>
                    </div>

                    <div class="full-width">
                        <label>Description:</label>
                        <textarea name="description" required>${roomDetail.description}</textarea>
                </div>
                <img src="${roomDetail.imageUrl}" alt="Current Room Image" style="max-width: 200px; display: block; margin-bottom: 10px;">
                <input type="hidden" name="imageFileHidden" value="${roomDetail.imageUrl}">

                <div class="full-width">
                    <label>Room Image:</label>
                    <div class="custom-file-upload">
                        <label for="imageFile" class="file-label">📁 Choose Image</label>
                        <input type="file" name="imageFile" id="imageFile"  accept="image/*" >
                        <span id="file-name">No file chosen</span> 
                    </div>
                    <p id="error-message" style="color:red; display:none;">Please choose an image file.</p>
                </div>



                <div class="full-width" style="display: flex; flex-wrap: wrap; gap: 16px;">
                    <div style="flex: 1 ;">
                        <label>Status:</label>
                        <select name="status" required>
                            <option <c:if test="${roomDetail.status eq 'Active'}" >selected</c:if> value="Active">Active</option>
                            <option<c:if test="${roomDetail.status eq 'InActive'}" >selected</c:if> value="InActive">InActive</option>
                            </select>
                        </div>

                        <div style="flex: 1 ;">
                            <label>Location:</label>
                            <select name="location" required>
                                <option value="1" selected="">Can Tho</option>
                            </select>
                        </div>


                        <div style="flex: 1;">
                            <label>Area (m²):</label>
                            <input id="area" type="number" value="${roomDetail.area}" name="area" placeholder="e.g. 35" min="0" max="100" step="0.1" required>
                    </div>

                </div>

                <button type="submit">Edit Room</button>
            </form>
        </div>

        <script>

      



            // Hiển thị tên file khi chọn ảnh
            document.getElementById("imageFile").addEventListener("change", function () {
                const fileName = this.files[0] ? this.files[0].name : "No file chosen";
                document.getElementById("file-name").textContent = fileName;
            });
            document.addEventListener("DOMContentLoaded", function () {
                let price = document.getElementById("price");
                // Không cho nhập chữ kể cả khi đang rỗng
                const MAX_DIGITS = 9;
                price.addEventListener("beforeinput", function (e) {
                    if (e.inputType === "insertText" && /\D/.test(e.data)) {
                        e.preventDefault();
                    }
                });
                // format khi nhập tiền
                price.addEventListener("input", function () {
                    let raw = price.value.replace(/\D/g, "");
                    // Cắt giới hạn tối đa chữ số
                    if (raw.length > MAX_DIGITS) {
                        raw = raw.substring(0, MAX_DIGITS);
                    }
                    let num = parseInt(raw);
                    if (!isNaN(num)) {
                        price.value = num.toLocaleString("vi-VN");
                    }
                });
                // Không cho dán chữ vào 
                price.addEventListener("paste", function (e) {
                    const pasted = e.clipboardData.getData('text');
                    if (!/^\d+$/.test(pasted.replace(/\D/g, ''))) {
                        e.preventDefault();
                    }
                });
            });
            // làm thay đổi bed khi chọn phòng 
            document.getElementById("roomType").addEventListener("change", function () {
                const roomType = document.getElementById("roomType");
                if (roomType.value === "Standard Room") {
                    document.getElementById("single").style.display = 'block';
                    document.getElementById("double").style.display = 'block';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("twin").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Deluxe Room") {
                    document.getElementById("queen").style.display = 'block';
                    document.getElementById("king").style.display = 'block';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("twin").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Twin Room") {
                    document.getElementById("twin").style.display = 'block';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                } else if (roomType.value === "Family Room") {
                    document.getElementById("twin").style.display = 'none';
                    document.getElementById("single").style.display = 'none';
                    document.getElementById("double").style.display = 'none';
                    document.getElementById("king").style.display = 'none';
                    document.getElementById("queen").style.display = 'none';
                    document.getElementById("treePeople").style.display = 'block';
                    document.getElementById("fourPeople").style.display = 'block';
                    document.getElementById("fivePeople").style.display = 'block';
                } else {
                    document.getElementById("single").style.display = 'block';
                    document.getElementById("double").style.display = 'block';
                    document.getElementById("queen").style.display = 'block';
                    document.getElementById("king").style.display = 'block';
                    document.getElementById("twin").style.display = 'block';
                    document.getElementById("treePeople").style.display = 'none';
                    document.getElementById("fourPeople").style.display = 'none';
                    document.getElementById("fivePeople").style.display = 'none';
                }
            });
            
            //khi load trang xong tự gọi hàm js thay đổi bed mà ko cần ấn nút 
  window.addEventListener("DOMContentLoaded", function () {
        document.getElementById("roomType").dispatchEvent(new Event("change"));
    });
        </script>   

    </body>
</html>
