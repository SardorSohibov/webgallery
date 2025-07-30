package com.example.webgallery.utils;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

public class FileManager {
    private static final String ROOT = "C:\\Users\\sohib\\IdeaProjects\\webgallery\\src\\main\\resources\\images";

    public static String uploadFile(Part part) {
        String genName = UUID.randomUUID().toString().replace("-", "") + "_" + part.getSubmittedFileName();
        Path path = Paths.get(ROOT, genName);

        try {
            Files.copy(part.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        return "http://localhost:8080/images/" + genName;
    }

    public static byte[] getFileBytes(String fileName) {
        Path path = Paths.get(ROOT, fileName);
        try {
            return Files.readAllBytes(path);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
