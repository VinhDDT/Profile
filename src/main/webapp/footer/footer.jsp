<%-- 
    Document   : footer
    Created on : Jun 19, 2025, 2:19:47 PM
    Author     : KHANH
--%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    .footer {
        background-color: #2c3e50;
        color: white;
        padding: 60px 40px 30px;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.6;
    }

    .footer-column {
        flex: 1 1 250px;
        margin: 20px;
        min-width: 220px;
    }

    .footer h3 {
        font-size: 20px;
        color: #f39c12;
        margin-bottom: 20px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .footer a {
        color: #bdc3c7;
        text-decoration: none;
        display: block;
        margin-bottom: 10px;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .footer a:hover {
        color: #ffffff;
        transform: translateX(5px);
    }

    .footer i {
        margin-right: 10px;
        color: #f39c12;
        transition: color 0.3s ease;
    }

    .footer p {
        font-size: 15px;
        margin: 10px 0;
        color: #bdc3c7;
    }

    .footer-bottom {
        background-color: #1a252f;
        color: #ccc;
        text-align: center;
        padding: 20px 10px;
        font-size: 14px;
        margin-top: 30px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .footer .social-icons a {
        color: #bdc3c7;
        margin-right: 15px;
        transition: color 0.3s ease;
    }

    .footer .social-icons a:hover {
        color: #f39c12;
    }

    @media (max-width: 768px) {
        .footer {
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .footer-column {
            margin: 20px 0;
        }
    }
</style>

<footer>
    <div class="footer">
        <!-- Column 1 -->
        <div class="footer-column">
            <h3>About Big Resort</h3>
            <a href="#"><i class="fas fa-info-circle"></i>About Us</a>
            <a href="#"><i class="fas fa-envelope"></i>Contact</a>
            <a href="#"><i class="fas fa-briefcase"></i>Careers</a>
        </div>

        <!-- Column 2 -->
        <div class="footer-column">
            <h3>Services</h3>
            <a href="#"><i class="fas fa-phone-alt"></i>Booking Consultation</a>
            <a href="#"><i class="fas fa-headset"></i>Customer Support</a>
            <a href="#"><i class="fas fa-undo-alt"></i>Refund Policy</a>
        </div>

        <!-- Column 3 -->
        <div class="footer-column">
            <h3>Contact Info</h3>
            <p><i class="fas fa-map-marker-alt"></i>123, 30/4 Street, Ninh Kieu District, Can Tho City</p>
            <p><i class="fas fa-phone"></i>(+84) 292 123 4567</p>
            <p><i class="fas fa-envelope"></i>contact@bigresort.vn</p>
            <div class="social-icons" style="margin-top: 15px;">
                <a href="#"><i class="fab fa-facebook fa-lg"></i></a>
                <a href="#"><i class="fab fa-instagram fa-lg"></i></a>
                <a href="#"><i class="fab fa-youtube fa-lg"></i></a>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        &copy; 2025 Big Resort - Can Tho. All rights reserved.
    </div>
</footer>