<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --navy: #4a6fa5;
                --navy-dark: #3a5c88;
                --white: #ffffff;
                --light-bg: #f4f6f9;
                --hover-bg: #3a5c88;
                --transition: 0.3s ease;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: var(--light-bg);
                color: var(--navy);
            }

            .navbar {
                background-color: var(--navy);
                color: var(--white);
                padding: 0 30px;
                display: flex;
                align-items: center;
                height: 60px;
                justify-content: space-between;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .navbar h1 {
                font-size: 22px;
                margin: 0;
            }

            .customer-link {
                color: var(--white);
                text-decoration: none;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: var(--transition);
            }

            .customer-link:hover {
                opacity: 0.85;
            }

            .sidebar {
                position: fixed;
                top: 60px;
                left: 0;
                height: calc(100% - 60px);
                width: 60px;
                background-color: var(--navy);
                transition: width var(--transition);
                overflow-x: hidden;
                box-shadow: 2px 0 8px rgba(0,0,0,0.05);
                z-index: 999;
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
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .menu li a {
                display: flex;
                align-items: center;
                padding: 14px 20px;
                text-decoration: none;
                color: var(--white);
                font-size: 16px;
                white-space: nowrap;
                transition: background-color var(--transition);
            }

            .menu li a i {
                margin-right: 14px;
                font-size: 18px;
                width: 20px;
                min-width: 20px;
                text-align: center;
            }

            .menu li a span {
                display: none;
                transition: opacity var(--transition);
            }

            .sidebar.open .menu li a span {
                display: inline;
            }

            .menu li a:hover {
                background-color: var(--hover-bg);
            }

            .content {
                margin-left: 60px;
                padding: 40px;
                transition: margin-left var(--transition);
            }

            .sidebar.open ~ .content {
                margin-left: 220px;
            }

            .content h2 {
                font-size: 28px;
                margin-bottom: 10px;
            }

            .content p {
                font-size: 16px;
                color: #333;
            }

            @media screen and (max-width: 768px) {
                .navbar h1 {
                    font-size: 18px;
                }

                .customer-link {
                    font-size: 14px;
                }

                .content {
                    padding: 20px;
                }
            }
            
        
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <%@include file="../navbarDashboard/navbarDashboard.jsp" %>

        <!-- Sidebar -->
        <%@include file="../sidebarDashboard/sidebarDashboard.jsp" %>
        <!-- Main Content -->
        <div class="content">
            <h2>Welcome to the Admin Dashboard</h2>
            <p>Use the sidebar to manage users, bookings, amenities, and more.</p>
        </div>

        <script>
            function toggleSidebar() {
                document.getElementById('sidebar').classList.toggle('open');
            }
        </script>

    </body>
</html>
