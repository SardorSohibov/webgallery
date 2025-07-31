package com.example.webgallery.servlets;

import com.example.webgallery.dao.ImageDao;
import com.example.webgallery.model.Image;
import com.example.webgallery.utils.FileManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet("/addpicture")
@MultipartConfig
public class AddPictureServlet extends HttpServlet {
    private static final ImageDao imageDao = ImageDao.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String folderID = request.getParameter("folderId");
        Part filePart = request.getPart("image");
        String url = FileManager.uploadFile(filePart);
        byte[] bytes = filePart.getInputStream().readAllBytes();
        Image image = new Image(url, title, description, folderID, (int) (filePart.getSize() / 1024), bytes);
        imageDao.addImage(image);
        response.sendRedirect("/pictures.jsp");

    }
}
