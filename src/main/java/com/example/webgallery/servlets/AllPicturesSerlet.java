package com.example.webgallery.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/allpictures")
public class AllPicturesSerlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String folderName = request.getParameter("folderName");
        String folderId = request.getParameter("folderId");
        request.getSession().setAttribute("folderName", folderName);
        request.getSession().setAttribute("folderId", folderId);
        response.sendRedirect("/pictures.jsp");
    }
}
