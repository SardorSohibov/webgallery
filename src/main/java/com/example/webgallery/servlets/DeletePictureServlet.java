package com.example.webgallery.servlets;

import com.example.webgallery.dao.ImageDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deletepicture")
public class DeletePictureServlet extends HttpServlet {
    private static final ImageDao imageDao = ImageDao.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("imageId");
        imageDao.deleteImageById(id);
        response.sendRedirect("/pictures.jsp");
    }
}
