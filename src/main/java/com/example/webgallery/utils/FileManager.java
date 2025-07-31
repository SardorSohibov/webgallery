package com.example.webgallery.utils;

import com.example.webgallery.dao.DatabaseConnector;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class FileManager {

    public static String uploadFile(Part part) {
        String genName = UUID.randomUUID().toString().replace("-", "") + "_" + part.getSubmittedFileName();
        return "http://localhost:8080/images/" + genName;
    }

    public static byte[] getFileBytes(String url) {
        PreparedStatement preparedStatement = null;
        byte[] bytes = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "select * from images where url = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, url);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                bytes = resultSet.getBytes("bytes");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return bytes;
    }
}
