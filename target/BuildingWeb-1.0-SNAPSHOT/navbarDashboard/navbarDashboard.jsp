<%-- 
    Document   : navbarDashboard
    Created on : Jun 22, 2025, 9:23:35 PM
    Author     : KHANH
--%>
    

<div class="navbar">
    <a href="Dashboard" class="dashboard-link">
        <h1 class="dashboard-title">Admin Dashboard</h1>
    </a>
    <a href="ViewAllCustomersDashboard" class="customer-link">
    </a>
          <a href="Notification">Notification</a>
<!--                        <a href="TakeNotification">Nh?n Notification</a>
                         <a href="MessageForDashboard">MessageForDashboard</a>-->
</div>

<div class="main-content">

</div>

<style>
:root {
    --navy: #4a6fa5;
    --white: #ffffff;
    --transition: 0.3s ease;
    --hover-color: #4a6fa5;
    --navbar-height: 60px;
}

/* Navbar layout */
.navbar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: var(--navbar-height);
    background-color: var(--white);
    color: var(--navy);
    padding: 0 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    z-index: 1000;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
    font-family: 'Segoe UI', sans-serif;
    animation: fadeInDown 0.5s ease forwards;
    opacity: 0;
    transform: translateY(-10px);
    transition: background-color var(--transition);
}

/* Dashboard title */
.dashboard-link {
    text-decoration: none;
}

.navbar h1 {
    font-size: 22px;
    margin: 0;
    color: var(--navy);
    transition: transform var(--transition);
}

.navbar h1:hover {
    transform: scale(1.05);
}

/* Customer link */
.customer-link {
    color: var(--navy);
    text-decoration: none;
    font-size: 16px;
    display: flex;
    align-items: center;
    gap: 6px;
    transition: color var(--transition), transform var(--transition);
}

.customer-link:hover {
    color: var(--hover-color);
    transform: translateX(4px);
    font-weight: 500;
}

/* Main content padding */
.main-content {
    padding-top: var(--navbar-height);
}

/* Responsive */
@media screen and (max-width: 768px) {
    .navbar h1 {
        font-size: 18px;
    }
    .customer-link {
        font-size: 14px;
    }
}

/* Animation */
@keyframes fadeInDown {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>