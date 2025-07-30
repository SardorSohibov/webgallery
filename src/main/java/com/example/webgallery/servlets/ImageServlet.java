package com.example.webgallery.servlets;

import com.example.webgallery.utils.FileManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getHttpServletMapping().getMatchValue();
        byte[] bytes = FileManager.getFileBytes(fileName);
        resp.setContentType("application/octet-stream");
        String originalName = fileName.substring(fileName.indexOf('_') + 1);
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalName + "\"");
        resp.setHeader("Content-Length", "" + bytes.length);
        resp.getOutputStream().write(bytes);
    }
}
