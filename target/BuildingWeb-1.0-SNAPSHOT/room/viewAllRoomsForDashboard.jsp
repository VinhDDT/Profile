<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Room Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9fafb;
            }

            .main-content {
                margin-left: 250px; /* width of sidebar */
                padding: 30px;
                transition: margin-left 0.3s ease;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 25px;
            }

            form {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 25px;
            }

            input[type="search"] {
                padding: 10px;
                width: 300px;
                max-width: 90%;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            button[type="submit"] {
                padding: 10px 16px;
                border: none;

                color: white;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }


            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }

            thead {
                background-color: #007bff;
                color: white;
            }

            th, td {
                padding: 14px;
                text-align: center;
                border-bottom: 1px solid #eaeaea;
            }

            td a {
                color: #007bff;
                margin: 0 6px;
                text-decoration: none;
            }

            td a:hover {
                color: #0056b3;
            }

            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
                margin-top: 30px;
                gap: 8px;
            }

            .pagination li a {
                display: block;
                padding: 8px 14px;
                background-color: #eaeaea;
                border-radius: 5px;
                color: #333;
                text-decoration: none;
            }

            .pagination li a:hover {
                background-color: #007bff;
                color: white;
            }

            @media screen and (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                form {
                    flex-direction: column;
                    align-items: center;
                }

                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead {
                    display: none;
                }

                tr {
                    margin-bottom: 15px;
                    background: #fff;
                    padding: 12px;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                }

                td {
                    padding-left: 50%;
                    position: relative;
                    border: none;
                    border-bottom: 1px solid #eee;
                    text-align: left;
                }

                td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 12px;
                    top: 12px;
                    font-weight: bold;
                    color: #555;
                }
            }
            .create-link {
                text-decoration: none;
                background-color: #007BFF;
                color: white;
                padding: 10px 30px;
                margin: 20px auto;
                border-radius: 6px;
                font-weight: bold;
                display: inline-block;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease, transform 0.2s ease;
                text-align: center;
            }

            .create-link:hover {
                background-color: #0056b3;
                transform: scale(1.05);
            }

            div .a1{
                display: flex;
                justify-content: space-around;
                margin-top: 26px;
            }






            /* Màu riêng cho từng nút */
            .delete-btn {
                background-color: #e53935;
            }
            .delete-btn:hover {
                background-color:  #c62828;
            }

            .restore-btn {
                background-color: #007BFF;
            }
            .restore-btn:hover {
                background-color: #388e3c;
            }

            .a1 {
                display: flex;


            }
        </style>
    </head>
    <body>
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>

        <div class="main-content">
            <h2>Room List</h2>

            <form method="get" action="ViewAllRoomsForDashboard">
                <input type="search" id="numberOnlyInput" name="search" placeholder="Enter keyword...">
                <button type="submit"><i class="fa-solid fa-search"></i> Search</button>
            </form>


            <a href="CreateRoomForDashboard" class="create-link">Create</a>

            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>RoomNumber</th>
                        <th>Floor</th>
                        <th>Room Type</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Operation</th>
                    </tr>   
                </thead>
                <tbody>
                    <c:forEach var="room" items="${list}" varStatus="i">


                        <tr>

                            <td data-label="STT">${(thisPage - 1) * 10 + i.index + 1}</td>
                            <td data-label="Mã Phòng">${room.roomNumber}</td>
                            <td data-label="Tầng">${room.floorNumber}</td>
                            <td data-label="Loại Phòng">${room.roomType}</td>
                            <td data-label="Giá">${room.price} / VND</td>
                            <td data-label="Trạng Thái">${room.status}</td>
                            <td data-label="Thao Tác">

<!--                            <a href="AdminView?id=${room.roomId}" title="Xem"><i class="fa-solid fa-eye"></i></a>-->

                                <div class="a1">
                                    <a href="EditRoomForDashboard?id=${room.roomId}" title="Sửa">
                                        <i class="fa-solid fa-pencil" style="font-size: 20px;"></i>
                                    </a>

                                    <c:choose>
                                        <c:when test="${room.status ne 'Hidden'}">
                                            <form action="DeleteRoomForDashboard" method="post" onsubmit="return confirmDelete()">
                                                <input type="hidden" name="roomId" value="${room.roomId}">
                                                <input type="hidden" name="status" value="notHidden">
                                                <button type="submit" class="delete-btn">Delete</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="DeleteRoomForDashboard" method="post">
                                                <input type="hidden" name="roomId" value="${room.roomId}">
                                                <input type="hidden" name="status" value="Hidden">
                                                <button type="submit" class="restore-btn">Restore</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <nav aria-label="Pagination">
                <ul class="pagination">
                    <c:forEach begin="1" end="${finalPage}" var="i">
                        <li><a href="ViewAllRoomsForDashboard?Page=${i}">${i}</a></li>
                        </c:forEach>
                </ul>
            </nav>

        </div>
    </body>


    <script>
        const input = document.getElementById('numberOnlyInput');


        input.addEventListener('input', function () {
            // Xoá mọi ký tự không phải số
            this.value = this.value.replace(/\D/g, '');

            // Giới hạn tối đa 4 chữ số
            if (this.value.length > 4) {
                this.value = this.value.slice(0, 4);
            }
        });
        // Lặp qua tất cả các ô có label "Giá"
        document.querySelectorAll('td[data-label="Giá"]').forEach(function (td)
        {
            let text = td.textContent.trim();
            let numberPart = text.split(' ')[0]; // Lấy phần số (bỏ " / VND")
            let formatted = Number(numberPart).toLocaleString('vi-VN'); // Format dạng 1.000.000
            td.textContent = formatted + " / VND"; // Gán lại vào ô
        });

        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa phòng này không?");
        }
    </script>
</body>
</html>
