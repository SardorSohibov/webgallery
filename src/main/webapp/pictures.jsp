<%--
  Created by IntelliJ IDEA.
  User: sohib
  Date: 7/27/2025
  Time: 11:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File Gallery</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #0f172a;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #1e293b;
            color: white;
            padding: 15px 30px;
        }

        .navbar .left {
            font-size: 20px;
            font-weight: bold;
        }

        .navbar .right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar .right button {
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 8px 14px;
            margin-left: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .navbar .right button:hover {
            background-color: #1d4ed8;
        }

        .file-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        /* From Uiverse.io by D3OXY */
        .card {
            position: relative;
            width: 350px;
            aspect-ratio: 16/9;
            background-color: #f2f2f2;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            perspective: 1000px;
            box-shadow: 0 0 0 5px #ffffff80;
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card svg {
            width: 48px;
            fill: #333;
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card__image {
            width: 100%;
            height: 100%;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(255, 255, 255, 0.2);
        }

        .card__content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 20px;
            box-sizing: border-box;
            background-color: #f2f2f2;
            transform: rotateX(-90deg);
            transform-origin: bottom;
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card:hover .card__content {
            transform: rotateX(0deg);
        }

        .card__title {
            margin: 0;
            font-size: 20px;
            color: #333;
            font-weight: 700;
        }

        .card:hover svg {
            scale: 0;
        }

        .card__description {
            margin: 10px 0 10px;
            font-size: 12px;
            color: #777;
            line-height: 1.4;
        }

        .card__button {
            padding: 15px;
            border-radius: 8px;
            background: #777;
            border: none;
            color: white;
        }

        .secondary {
            background: rgba(185, 28, 28, 0.92);
            color: #ffffff;
            border: 1px solid #777;
        }

        .profile-img {
            width: 100%;
            height: auto;
            border-radius: 10px;
            object-fit: cover;
        }

    </style>
</head>
<body>

<div class="navbar">
    <div class="left">Welcome, User</div>
    <div class="right">
        <form method="get" style="margin: 0;">
            <input type="hidden" name="action" value="showAddForm">
            <button type="submit">Add picture</button>
        </form>
        <form action="/allfolders.jsp" method="get" style="margin: 0;">
            <button type="submit">Back</button>
        </form>
    </div>
</div>
<% String action = request.getParameter("action");
    if ("showDeleteForm".equals(action)) {
%>
<div style="background-color: #1e293b; color: white; padding: 20px; width: 300px; margin: 20px auto; border-radius: 10px;">
    <h3>Do you want to delete this folder?</h3>
    <form method="post" action="/deletepicture">
        <div style="display: flex; justify-content: space-between;">
            <button type="submit"
                    style="background-color: #dc2626; color: white; border: none; padding: 8px 14px; border-radius: 5px;">
                Yes
            </button>
            <a href="pictures.jsp"
               style="background-color:#2563eb; color: white; padding: 8px 14px; border-radius: 5px; text-decoration: none;">No</a>
        </div>
    </form>
</div>
<%
    }
    if ("showAddForm".equals(action)) {
%>
<div style="background-color: #1e293b; color: white; padding: 20px; width: 300px; margin: 20px auto; border-radius: 10px;">
    <h3>Create New Folder</h3>
    <form method="post" action="/addpicture">
        <input type="text" name="pictureName" placeholder="Picture name" required
               style="width: 100%; padding: 8px; margin-bottom: 10px; border-radius: 5px; border: none;">
        <textarea rows="4" name="pictureDescription" placeholder="Picture description" required
                  style="width: 100%; padding: 8px; margin-bottom: 10px; border-radius: 5px; border: none;"></textarea>
        <label for="image-upload"
               style="display: inline-block; background-color: #2563eb; color: white;
              padding: 10px 16px; border-radius: 8px; cursor: pointer; font-size: 14px;
              font-family: sans-serif; margin-bottom: 10px;">
            🖼️ Upload Image
        </label>

        <input type="file" id="image-upload" name="image" accept="image/*" required
               style="display: none;">
        <div style="display: flex; justify-content: space-between;">
            <button type="submit"
                    style="background-color: #2563eb; color: white; border: none; padding: 8px 14px; border-radius: 5px;">
                Add
            </button>
            <a href="pictures.jsp"
               style="background-color: #dc2626; color: white; padding: 8px 14px; border-radius: 5px; text-decoration: none;">Cancel</a>
        </div>
    </form>
</div>
<%}%>

<div class="file-container">
    <!-- From Uiverse.io by D3OXY -->
    <div class="card">
        <img src="images/photo_2025-02-13_23-37-46.jpg" alt="xatolik" class="profile-img">
        <div class="card__content">
            <p class="card__title">Project Name</p>
            <p class="card__description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                ullamco.</p>
            <button class="card__button">Download</button>
            <form method="get" style="margin: 0; display: inline-block">
                <input type="hidden" name="action" value="showDeleteForm">
                <input type="hidden" name="folderId" value="unknown">
                <button class="card__button secondary">Delete</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
