<%@ page import="com.example.webgallery.dao.FolderDao" %>
<%@ page import="com.example.webgallery.dao.ImageDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.webgallery.model.Folder" %><%--
  Created by IntelliJ IDEA.
  User: sohib
  Date: 7/27/2025
  Time: 11:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! private static final FolderDao folderDao = FolderDao.getInstance();%>
<%! private static final ImageDao imageDao = ImageDao.getInstance(); %>
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


        .card {
            width: 230px;
            border-radius: 20px;
            background: #1b233d;
            padding: 5px;
            overflow: hidden;
            box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 20px 0px;
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card .top-section {
            height: 150px;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            background: linear-gradient(45deg, rgb(4, 159, 187) 0%, rgb(80, 246, 255) 100%);
            position: relative;
        }

        .card .top-section .border {
            border-bottom-right-radius: 10px;
            height: 30px;
            width: 130px;
            background: #1b233d;
            position: relative;
            transform: skew(-40deg);
            box-shadow: -10px -10px 0 0 #1b233d;
        }

        .card .top-section .border::before {
            content: "";
            position: absolute;
            width: 15px;
            height: 15px;
            top: 0;
            right: -15px;
            background: transparent;
            border-top-left-radius: 10px;
            box-shadow: -5px -5px 0 2px #1b233d;
        }

        .card .top-section::before {
            content: "";
            position: absolute;
            top: 30px;
            left: 0;
            background: transparent;
            height: 15px;
            width: 15px;
            border-top-left-radius: 15px;
            box-shadow: -5px -5px 0 2px #1b233d;
        }

        .card .top-section .icons {
            position: absolute;
            top: 0;
            width: 100%;
            height: 30px;
            display: flex;
            justify-content: space-between;
        }

        .card .top-section .icons .logo {
            height: 100%;
            aspect-ratio: 1;
            padding: 7px 0 7px 15px;
        }

        .card .top-section .icons .social-media {
            height: 100%;
            padding: 8px 15px;
            display: flex;
            gap: 7px;
        }

        .card .top-section .icons .social-media .svg {
            height: 100%;
            fill: #1b233d;
            transition: fill 0.3s;
        }

        .card .top-section .icons .social-media .svg:hover {
            fill: white;
        }

        .card .bottom-section {
            margin-top: 15px;
            padding: 10px 5px;
        }

        .card .bottom-section .title {
            display: block;
            font-size: 17px;
            font-weight: bolder;
            color: white;
            text-align: center;
            letter-spacing: 2px;
        }

        .card .bottom-section .row {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .card .bottom-section .row .item {
            flex: 30%;
            text-align: center;
            padding: 5px;
            color: rgba(170, 222, 243, 0.721);
        }

        .card .bottom-section .row .item .big-text {
            font-size: 12px;
            display: block;
        }

        .card .bottom-section .row .item .regular-text {
            font-size: 9px;
        }

        .card .bottom-section .row .item:nth-child(2) {
            border-left: 1px solid rgba(255, 255, 255, 0.126);
            border-right: 1px solid rgba(255, 255, 255, 0.126);
        }

        .card .bottom-section .delete-btn {
            margin-top: 10px;
            width: 100%;
            padding: 5px;
            background-color: #dc2626;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .card .bottom-section .delete-btn:hover {
            background-color: #b91c1c;
        }

        /* Qoramtir shaffof fon */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.7); /* Orqa fonni qoraytiradi */
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        /* Modal box dizayni */
        .modal-box {
            background-color: #1e293b; /* Modalning o‘zi */
            color: white;
            padding: 30px;
            border-radius: 12px;
            width: 400px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
        }
    </style>
</head>
<body>
<%
    if (session.getAttribute("userId") == null) {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
%>
<div class="navbar">
    <div class="left">Welcome, <%= session.getAttribute("username") %>
    </div>
    <div class="right">
        <form method="get" style="margin: 0;">
            <input type="hidden" name="action" value="showAddForm">
            <button type="submit">Add Folder</button>
        </form>
        <form action="/login.jsp" style="margin: 0;">
            <button type="submit">Logout</button>
        </form>
    </div>
</div>
<%
    String action = request.getParameter("action");
    if ("showAddForm".equals(action)) {
%>
<div class="modal-overlay">
    <div class="modal-box">
        <div style="background-color: #1e293b; color: white; padding: 20px; width: 300px; margin: 20px auto; border-radius: 10px;">
            <h3>Create New Folder</h3>
            <form method="post" action="/addfolder">
                <input name="userId" type="hidden" value="<%= session.getAttribute("userId")%>">
                <input type="text" name="folderName" placeholder="Folder name" required
                       style="width: 100%; padding: 8px; margin-bottom: 10px; border-radius: 5px; border: none;">
                <div style="display: flex; justify-content: space-between;">
                    <button type="submit"
                            style="background-color: #2563eb; color: white; border: none; padding: 8px 14px; border-radius: 5px;">
                        Create
                    </button>
                    <a href="allfolders.jsp"
                       style="background-color: #dc2626; color: white; padding: 8px 14px; border-radius: 5px; text-decoration: none;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
    if ("showDeleteForm".equals(action)) {
%>
<div class="modal-overlay">
    <div class="modal-box">
        <div style="background-color: #1e293b; color: white; padding: 20px; width: 300px; margin: 20px auto; border-radius: 10px;">
            <h3>Do you want to delete this folder?</h3>
            <form method="post" action="/deletefolder">
                <input name="folderId" type="hidden" value="<%= request.getParameter("folderId")%>">
                <div style="display: flex; justify-content: space-between;">
                    <button type="submit"
                            style="background-color: #dc2626; color: white; border: none; padding: 8px 14px; border-radius: 5px;">
                        Yes
                    </button>
                    <a href="allfolders.jsp"
                       style="background-color:#2563eb; color: white; padding: 8px 14px; border-radius: 5px; text-decoration: none;">No</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
%>
<div class="file-container">
    <% ArrayList<Folder> folders = folderDao.getAllFoldersByUserId(session.getAttribute("userId").toString());
        for (Folder folder : folders) {
    %>
    <div class="card">
        <form action="/allpictures" method="post">
            <input type="hidden" name="folderId" value="<%= folder.getId()%>">
            <input type="hidden" name="folderName" value="<%= folder.getFolderName()%>">
            <div class="top-section" onclick="this.closest('form').submit()" style="cursor: pointer;">
                <div class="border"></div>
                <div class="icons">
                    <div class="logo">
                        <span style="color: white; font-weight: bold;">🎞️</span>
                    </div>
                    <div class="social-media">
                        <svg class="svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30">
                            <path d="M22 7 C22.552 7 23 7.448 23 8 C23 8.552 22.552 9 22 9 C21.448 9 21 8.552 21 8 C21 7.448 21.448 7 22 7 z M15 9 C18.309 9 21 11.691 21 15 C21 18.309 18.309 21 15 21 C11.691 21 9 18.309 9 15 C9 11.691 11.691 9 15 9 z M15 11 A 4 4 0 0 0 11 15 A 4 4 0 0 0 15 19 A 4 4 0 0 0 19 15 A 4 4 0 0 0 15 11 z"/>
                        </svg>
                        <svg class="svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path d="M459.37 151.716... (icon path shorted for brevity)"/>
                        </svg>
                    </div>
                </div>
            </div>
        </form>
        <div class="bottom-section">
            <span class="title"><%= folder.getFolderName()%></span>
            <div class="row row1">
                <div class="item">
                    <span class="big-text"><%= imageDao.getImageCountByFolderId(folder.getId())%></span>
                    <span class="regular-text">images</span>
                </div>
                <div class="item">
                    <span class="big-text"><%= imageDao.GetAllImageSizeByFolderid(folder.getId())%></span>
                    <span class="regular-text">KB</span>
                </div>
                <form method="get" style="margin: 0;">
                    <input type="hidden" name="action" value="showDeleteForm">
                    <input type="hidden" name="folderId" value="<%= folder.getId()%>">
                    <div class="item" onclick="this.closest('form').submit()" style="cursor: pointer;">
                        🗑️
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%}%>
</div>

</body>
</html>

