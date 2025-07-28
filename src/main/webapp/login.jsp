<%--
  Created by IntelliJ IDEA.
  User: sohib
  Date: 7/22/2025
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Simple ToDo App</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #00ca4e;
        }

        .container {
            display: grid;
            place-items: center;
            height: 100vh;
        }

        .login {
            color: #00ca4e;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;
            font-size: x-large;
        }

        .card {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 420px;
            width: 350px;
            flex-direction: column;
            gap: 35px;
            background: #1e1e1e;
            box-shadow: 12px 12px 25px rgba(0, 0, 0, 0.7),
            -12px -12px 25px rgba(255, 255, 255, 0.05);
            border-radius: 12px;
        }

        .inputBox {
            position: relative;
            width: 250px;
        }

        .inputBox input {
            width: 100%;
            padding: 10px;
            outline: none;
            border: none;
            background: transparent;
            border-left: 2px solid #00ca4e;
            border-bottom: 2px solid #00ca4e;
            color: #00ca4e;
            font-size: 1em;
            border-bottom-left-radius: 8px;
            transition: 0.3s ease;
        }

        .inputBox span {
            margin-top: 5px;
            position: absolute;
            left: 0;
            transform: translateY(-4px);
            margin-left: 10px;
            padding: 10px;
            pointer-events: none;
            font-size: 12px;
            color: #00ca4e;
            text-transform: uppercase;
            transition: 0.5s;
            letter-spacing: 3px;
            border-radius: 8px;
        }

        .inputBox input:focus ~ span,
        .inputBox input:valid ~ span {
            transform: translateX(113px) translateY(-15px);
            font-size: 0.8em;
            padding: 5px 10px;
            background: #00ca4e;
            color: #121212;
            letter-spacing: 0.2em;
        }

        .inputBox input:focus,
        .inputBox input:valid {
            border: 2px solid #00ca4e;
            border-radius: 8px;
        }

        .enter {
            height: 45px;
            width: 100px;
            border-radius: 5px;
            border: 2px solid #00ca4e;
            cursor: pointer;
            background-color: transparent;
            transition: 0.3s;
            color: #00ca4e;
            text-transform: uppercase;
            font-size: 10px;
            letter-spacing: 2px;
        }

        .enter:hover {
            background-color: #00ca4e;
            color: #121212;
        }

        .signup {
            position: relative;
            --primary-color: #e0f7fa;
            --hovered-color: #00ca4e;
            border: none;
            background: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            font-weight: 600;
            font-size: 20px;
            margin-top: 2rem;
            text-decoration: none;
        }

        .signup p {
            margin: 0;
            position: relative;
            color: var(--primary-color);
            text-decoration: none; /* 🟢 chiziqni olib tashlaydi */
        }

        .signup::after {
            content: "";
            position: absolute;
            width: 0;
            left: 0;
            bottom: -3px;
            background: var(--hovered-color);
            height: 1px;
            transition: 0.3s ease-out;
        }

        .signup p::before {
            position: absolute;
            content: "SignUp";
            width: 0%;
            inset: 0;
            color: var(--hovered-color);
            overflow: hidden;
            transition: 0.3s ease-out;
        }

        .signup:hover::after {
            width: 100%;
        }

        .signup:hover p::before {
            width: 100%;
        }

    </style>
</head>
<body>

<div class="container">
    <%if (request.getAttribute("error") != null) {%>
    <div id="error-message" class="alert alert-danger" role="alert">
        Username or password is incorrect!
    </div>
    <%}%>
    <form action="/login" method="post">
        <div class="card">
            <a class="login">Log in</a>
            <div class="inputBox">
                <input type="text" required name="username">
                <span class="user">Username</span>
            </div>

            <div class="inputBox">
                <input type="password" required name="password">
                <span>Password</span>
            </div>
            <button type="submit" class="enter">Enter</button>
            <a href="register.jsp" class="signup">
                <p>SignUp</p>
            </a>
        </div>
    </form>
</div>

</body>
</html>