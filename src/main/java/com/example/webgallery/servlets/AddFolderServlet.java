package com.example.webgallery.servlets;

import com.example.webgallery.dao.FolderDao;
import com.example.webgallery.model.Folder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addfolder")
public class AddFolderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folderName = request.getParameter("folderName");
        String folderOwner = request.getSession().getAttribute("userId").toString();
        Folder folder = new Folder(folderName, folderOwner);
        FolderDao.addFolder(folder);
        response.sendRedirect("/allfolders.jsp");
    }
}
