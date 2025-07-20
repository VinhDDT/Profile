<%-- 
    Document   : menuSearch
    Created on : May 7, 2025, 1:28:21 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/menuSearch.css"/>
<div class="search-box">
    <form action="ListRooms" method="get">
        <div class="form-row">
            <!-- Vị trí -->
            <div class="form-group">
                <label for="location">Vị trí</label>
                <select onchange="search(this)" id="location" name="location">
                      <option >Vị Trí</option>
                    <option value="Cần Thơ">Cần Thơ</option>
                    <option value="Vũng Tàu">Vũng Tàu</option>
                </select>
            </div>

            <!-- Check-in -->
            <div class="form-group">
                <label for="checkin">Check-in</label>
                <input oninput="search(this)" type="date" id="checkin" name="checkin" >
            </div>

            <!-- Check-out -->
            <div class="form-group">
                <label for="checkout">Check-out</label>
                <input oninput="search(this)" type="date" id="checkout" name="checkout" >
            </div>

            <!-- Người lớn -->
            <div class="form-group">
                <label for="adults">Người lớn</label>
                <input oninput="search(this)" type="number" id="adults" name="adults" min="1" value="1">
            </div>

            <!-- Trẻ em -->
            <div class="form-group">
                <label for="children">Trẻ em</label>
                <input oninput="search(this)" type="number" id="children" name="children" min="0" value="0">
            </div>

<!--             Nút tìm kiếm 
-->            <div class="form-group">
                <button  type="submit" name="search">Tìm</button>
            </div>
        </div>
    </form>
</div>