package com.example.webgallery.servlets;

import com.example.webgallery.dao.FolderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deletefolder")

public class DeleteFolderSerlet extends HttpServlet {
    private static final FolderDao folderDao = FolderDao.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String folderId = req.getParameter("folderId");
        folderDao.deleteFolder(folderId);
        resp.sendRedirect("allfolders.jsp");
    }
}
