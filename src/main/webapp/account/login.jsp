<%-- 
    Document   : login
    Created on : Apr 15, 2025, 9:53:01 AM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background: #fff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            width: 360px;
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-10px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .signup-link {
            text-align: center;
            margin-top: 18px;
            font-size: 14px;
        }

        .signup-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="Login" method="post">
            <div class="form-group">
                <label for="accountType">Select Account Type</label>
                <select id="accountType" name="accountType" required>
                    <option value="">-- Select Account Type --</option>
                    <option value="option1">Admin, Manager, Staff</option>
                    <option value="option2">User</option>
                </select>
            </div>

            <div class="form-group">
                <label for="tk">Username</label>
                <input id="tk" name="tk" type="text" required>
            </div>

            <div class="form-group">
                <label for="pas">Password</label>
                <input id="pas" name="pas" type="password" required>
            </div>

            <input name="sub" type="submit" value="Log In"/>
        </form>

        <div class="signup-link">
            <p>Don't have an account? <a href="SignUp">Sign Up</a></p>
        </div>
    </div>
</body>
</html>
