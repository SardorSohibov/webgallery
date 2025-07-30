<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Webgallery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0f172a;
            color: white;
        }

        .container {
            display: grid;
            place-items: center;
            height: 100vh;
        }

        .register {
            color: white;
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
            gap: 25px;
            background: #1e293b;
            box-shadow: 12px 12px 25px rgba(0, 0, 0, 0.4),
            -12px -12px 25px rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 20px 0;
        }

        .inputBox {
            position: relative;
            width: 250px;
            margin-bottom: 15px;
        }

        .inputBox input {
            width: 100%;
            padding: 10px;
            outline: none;
            border: none;
            background: transparent;
            border-left: 2px solid #334155;
            border-bottom: 2px solid #334155;
            color: white;
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
            color: #94a3b8;
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
            background: rgb(4, 159, 187);
            color: #121212;
            letter-spacing: 0.2em;
        }

        .inputBox input:focus,
        .inputBox input:valid {
            border: 2px solid #60a5fa;
            border-radius: 8px;
        }

        .enter {
            height: 40px;
            width: 120px;
            border-radius: 5px;
            border: 2px solid #60a5fa;
            cursor: pointer;
            background-color: transparent;
            transition: 0.3s;
            color: #94a3b8;
            text-transform: uppercase;
            font-size: 10px;
            letter-spacing: 2px;
        }

        .enter:hover {
            background-color: rgb(4, 159, 187);
            color: #121212;
        }

        .login {
            position: relative;
            --primary-color: #e0f7fa;
            --hovered-color: #60a5fa;
            border: none;
            background: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            font-weight: 600;
            font-size: 20px;
            margin-top: 2rem;
            text-decoration: none; /* 🟢 BU MUHIM */
        }

        .login p {
            margin: 0;
            position: relative;
            color: var(--primary-color);
            text-decoration: none; /* 🟢 IKKALASI HAM KERAK */
        }

        .login::after {
            content: "";
            position: absolute;
            width: 0;
            left: 0;
            bottom: -3px;
            background: var(--hovered-color);
            height: 1px;
            transition: 0.3s ease-out;
        }

        .login p::before {
            position: absolute;
            content: "Login";
            width: 0%;
            inset: 0;
            color: var(--hovered-color);
            overflow: hidden;
            transition: 0.3s ease-out;
        }

        .login:hover::after {
            width: 100%;
        }

        .login:hover p::before {
            width: 100%;
        }

    </style>
</head>
<body>
<%-- ❗ Alert xabari container dan oldin --%>
<%if (request.getAttribute("error") != null) {%>
<%if (request.getAttribute("error").equals("username already exists")) {%>
<div id="error-message" class="alert alert-danger text-center" role="alert"
     style="position: absolute; top: 20px; left: 50%; transform: translateX(-50%); width: 300px; z-index: 1000;">
    Username already exists!
</div>
<% } %>
<%if (request.getAttribute("error").equals("passwords do not match")) {%>
<div id="error-message" class="alert alert-danger text-center" role="alert"
     style="position: absolute; top: 20px; left: 50%; transform: translateX(-50%); width: 300px; z-index: 1000;">
    Passwords do not match!
</div>
<%
        }
    }
%>
<div class="container">
    <form action="/register" method="post">
        <div class="card">
            <h1 class="register">Sign up</h1>
            <div class="inputBox">
                <input type="text" name="username" required>
                <span>Username</span>
            </div>
            <div class="inputBox">
                <input type="password" name="password" required>
                <span>Password</span>
            </div>
            <div class="inputBox">
                <input type="password" name="confirmPassword" required>
                <span>Confirm Password</span>
            </div>
            <button type="submit" class="enter">Sign Up</button>
            <a href="login.jsp" class="login">
                <p>Login</p>
            </a>
        </div>
    </form>
</div>

</body>
</html>
