<%-- 
    Document   : sidebarDashboard
    Created on : Jun 22, 2025, 9:52:42 PM
    Author     : KHANH
--%>

<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    :root {
        --navy: #46b791;
        --navy-dark: #3a9c7b;
        --white: #ffffff;
        --hover-bg: #2e8266;
        --transition: 0.3s ease;
        --shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    .sidebar {
        position: fixed;
        top: 60px;
        left: 0;
        height: calc(100% - 60px);
        width: 60px;
        background-color: var(--navy);
        overflow-x: hidden;
        box-shadow: var(--shadow);
        transition: width var(--transition), transform var(--transition);
        transform: translateX(0);
        z-index: 998;
        font-family: 'Segoe UI', sans-serif;
    }

    .sidebar.open {
        width: 220px;
    }

    .toggle-btn {
        background-color: var(--navy-dark);
        color: var(--white);
        font-size: 20px;
        cursor: pointer;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        transition: background-color 0.2s ease;
        animation: fadeIn 0.4s ease forwards;
    }

    .toggle-btn:hover {
        background-color: var(--hover-bg);
    }

    .menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu li {
        opacity: 0;
        transform: translateY(10px);
        animation: fadeSlideIn 0.3s ease forwards;
        animation-delay: calc(var(--i) * 0.05s);
        position: relative;
    }

    .menu li a {
        display: flex;
        align-items: center;
        padding: 14px 20px;
        text-decoration: none;
        color: var(--white);
        font-size: 16px;
        white-space: nowrap;
        transition: background-color var(--transition), padding-left 0.3s;
    }

    .menu li a i {
        margin-right: 14px;
        font-size: 18px;
        width: 20px;
        min-width: 20px;
        text-align: center;
        transition: transform 0.3s ease;
    }

    .menu li a span {
        display: inline-block;
        opacity: 0;
        transform: translateX(-10px);
        transition: opacity 0.3s ease, transform 0.3s ease;
    }

    .sidebar.open .menu li a span {
        opacity: 1;
        transform: translateX(0);
    }

    .menu li a:hover {
        background-color: var(--hover-bg);
        padding-left: 28px;
    }

    .menu li a:hover i {
        transform: scale(1.2);
    }

    @media screen and (max-width: 768px) {
        .sidebar {
            width: 0;
            transform: translateX(-100%);
        }

        .sidebar.open {
            width: 180px;
            transform: translateX(0);
        }
    }

    .content, .main-content {
        margin-left: 60px;
        transition: margin-left var(--transition);
    }

    .sidebar.open ~ .content,
    .sidebar.open ~ .main-content {
        margin-left: 220px;
    }

    @keyframes fadeSlideIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: scale(0.95);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }

    /* Dropdown gi?ng hình */
    .khang-item {
        position: relative;
    }

    .khang-dropdown {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: var(--white);
        min-width: 180px;
        padding: 10px 0;
        margin: 0;
        list-style: none;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        border-radius: 6px;
        z-index: 1000;
    }

    .khang-dropdown li a {
        display: block;
        padding: 10px 16px;
        color: #333;
        text-decoration: none;
        font-size: 14px;
        white-space: nowrap;
        transition: background-color 0.2s;
    }

    .khang-dropdown li a:hover {
        background-color: #f2f2f2;
    }

    .khang-item:hover .khang-dropdown {
        display: block;
    }


    
    .menu li a.active {
    background-color: var(--hover-bg);
    font-weight: bold;
    padding-left: 28px;
}

</style>

<!-- Sidebar HTML -->
<div class="sidebar" id="sidebar">
    <div class="toggle-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </div>
    <ul class="menu">

        <li style="--i:0"><a href="Index"><i class="fa-solid fa-house"></i><span>Home</span></a></li>
        <li style="--i:1"><a href="DashboardUser"><i class="fa-solid fa-user"></i><span>Users</span></a></li>
        <li style="--i:2"><a href="VouchersDashBoard"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a></li>
        <li style="--i:3"><a href="ViewNewsDashboard"><i class="fa-solid fa-newspaper"></i><span>News</span></a></li>
        
        <li style="--i:3"><a href="CreateBooking"><i class="fa-solid fa-calendar-check"></i><span>Desk Booking</span></a></li>
        
        <li style="--i:4"><a href="BookingConfirmation"><i class="fa-solid fa-calendar-check"></i><span>Bookings</span></a></li>
        <li style="--i:5"><a href="ViewAllRoomsForDashboard"><i class="fa-solid fa-bed"></i><span>List Rooms</span></a></li>
        <li style="--i:6"><a href="ViewServicesDashboard"><i class="fa-solid fa-concierge-bell"></i><span>Services</span></a></li>
        <li style="--i:7"><a href="ViewAmenitiesDashboard"><i class="fa-solid fa-bath"></i><span>Amenities</span></a></li>
        <li style="--i:8"><a href="ViewAllCustomersDashboard"><i class="fa-solid fa-users"></i><span>Customers</span></a></li>
        <li style="--i:9"><a href="ViewAllCheckInOutDashboard"><i class="fa-solid fa-door-open"></i><span>Check-InOut</span></a></li>
        <li style="--i:10"><a href="ViewAllReportsForDashboard"><i class="fa-solid fa-flag"></i><span>Report</span></a></li>
        <li style="--i:11"><a href="Logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>

        <!-- Khang item -->
        <li style="--i:12" class="khang-item">
            <a href="#"><i class="fa-solid fa-user-gear"></i><span>Khang</span></a>
            <ul class="khang-dropdown">
                <li><a href="Profile"><span>?</span> My Account</a></li>
                <li><a href="OrderServices"><span>?</span> Order Services</a></li>
            </ul>
        </li>
    </ul>
</div>

<script>

    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("open");
    }
    
    
     document.addEventListener("DOMContentLoaded", function () {
        const links = document.querySelectorAll(".menu li a");
        const currentUrl = window.location.href;

        links.forEach(link => {
            if (currentUrl.includes(link.getAttribute("href"))) {
                link.classList.add("active");
            }
        });
    });
</script>
