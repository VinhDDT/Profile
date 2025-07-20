/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
var locationValue = 0;
var checkInValue = 0;
var checkOutValue = 0;
var adultsValue = 0;
var childrenValue = 0;
var checkSearch = false;
var countCard = 0;
var firstSearch = false;

function loadMore() {
    countCard = document.getElementsByClassName("card").length;
    firstSearch = false;
    var dataToSend = {
        checkSearchValues: checkSearch
    };
    if (checkSearch) {
        dataToSend.locationSearch = locationValue;
        dataToSend.checkInSearch = checkInValue;
        dataToSend.checkOutSearch = checkOutValue;
        dataToSend.adultsSearch = adultsValue;
        dataToSend.childrenSearch = childrenValue;
    }
    $.ajax({
        url: "/ViewRooms",
        type: "GET",
        data: {totalCard: countCard,
            loadMore: "true",
            firstSearchValues: firstSearch,
            ...dataToSend
        },
        success: function (data) {
            var row = document.getElementById("product");
            row.innerHTML += data;
            formatAfterAjax();
            // Lấy số phòng còn lại từ div ẩn
            var remaining = document.getElementById("remaining-rooms");
            if (remaining) {
                var finalRooms = remaining.innerText;
                document.getElementById("loadmore-btn").innerText = "Xem Thêm " + finalRooms + " Rooms nữa";
                remaining.remove(); // Xóa div ẩn sau khi lấy xong
            }
        },
        error: function (xhr, status, error) {
            console.log("Lỗi:", error);
        }
    });
}
function search() {
    checkSearch = true;
    firstSearch = true;
    countCard = document.getElementsByClassName("card").length;
    locationValue = document.getElementById("location").value;
    checkInValue = document.getElementById("checkIn").value;
    checkOutValue = document.getElementById("checkOut").value;
    adultsValue = document.getElementById("adults").value;
    childrenValue = document.getElementById("children").value;
    if (
            locationValue !== "" &&
            checkInValue !== "" &&
            checkOutValue !== "" &&
            adultsValue !== "" &&
            childrenValue !== ""
            ) {
        $.ajax({
            url: "/ViewRooms",
            type: "GET",
            data: {
                totalCard: countCard
                , locationSearch: locationValue
                , checkInSearch: checkInValue
                , checkOutSearch: checkOutValue
                , adultsSearch: adultsValue
                , childrenSearch: childrenValue
                , checkSearchValues: checkSearch
                , firstSearchValues: firstSearch


            },
            success: function (data) {
                var row = document.getElementById("product");

                row.innerHTML = data;
                formatAfterAjax();
                // Lấy số phòng còn lại từ div ẩn
                var remaining = document.getElementById("remaining-rooms");
                if (remaining) {
                    var finalRooms = remaining.innerText;
                    document.getElementById("loadmore-btn").innerText = "Xem Thêm " + finalRooms + " Rooms nữa";
                    remaining.remove(); // Xóa div ẩn sau khi lấy xong
                }
            },
            error: function (xhr, status, error) {
                console.log("Lỗi:", error);
            }
        });
    }

}
$(document).ready(function () {
    $.ajax({
        url: "/ViewRooms",
        type: "GET",
        success: function (data) {
            var remaining = document.getElementById("remaining-rooms");
            if (remaining) {
                var finalRooms = remaining.innerText;
                document.getElementById("loadmore-btn").innerText = "Xem Thêm " + finalRooms + " Rooms nữa";
                remaining.remove(); // Xóa div ẩn sau khi lấy xong
            }
        },
        error: function (xhr, status, error) {
            console.log("Lỗi:", error);
        }
    });
});

$(document).ready(function () {
    // Lấy ngày hiện tại theo định dạng yyyy-mm-dd
    const today = new Date().toISOString().split('T')[0];

    // Lấy thẻ input ngày check-in và check-out theo id
    const checkIn = document.getElementById("checkIn");
    const checkOut = document.getElementById("checkOut");

    // Không cho phép chọn ngày check-in nhỏ hơn ngày hôm nay
    checkIn.min = today;

    // Khi người dùng thay đổi ngày check-in
    checkIn.addEventListener("change", function () {
        // Gán ngày check-in làm giá trị min cho check-out
        // → nghĩa là người dùng không thể chọn ngày trả phòng nhỏ hơn ngày nhận phòng
        checkOut.min = this.value;
    });
});

