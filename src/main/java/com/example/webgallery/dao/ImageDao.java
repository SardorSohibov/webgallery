package com.example.webgallery.dao;

import com.example.webgallery.model.Image;

import java.awt.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ImageDao {
    private static ImageDao instance;

    public static ImageDao getInstance() {
        if (instance == null) {
            instance = new ImageDao();
        }
        return instance;
    }

    public static void addImage(Image image) {
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "INSERT INTO images (id, url, title, description, folderid, size) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, image.getId());
            pstmt.setString(2, image.getUrl());
            pstmt.setString(3, image.getTitle());
            pstmt.setString(4, image.getDescription());
            pstmt.setString(5, image.getFolderId());
            pstmt.setInt(6, image.getSize());
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void deleteImageByFolderId(String folderId) {
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()){
            String sql = "update images set deleted = true where folderid = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, folderId);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void deleteImageById(String imageId) {
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()){
            String sql = "update images set deleted = true where id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, imageId);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public  ArrayList<Image> getAllImages(String folderId) {
        ArrayList<Image> images = new ArrayList<>();
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "SELECT * FROM images WHERE folderid=? and deleted = false";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, folderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Image image = new Image();
                image.setId(rs.getString("id"));
                image.setUrl(rs.getString("url"));
                image.setTitle(rs.getString("title"));
                image.setDescription(rs.getString("description"));
                image.setFolderId(rs.getString("folderid"));
                image.setSize(rs.getInt("size"));
                images.add(image);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return images;
    }

    public  int getImageCountByFolderId(String folderId) {
        int count = 0;
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "SELECT COUNT(*) FROM images WHERE folderid=? and deleted = false";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, folderId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    public  int GetAllImageSizeByFolderid(String id) {
        int size = 0;
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "SELECT SIZE FROM images WHERE folderid=? and deleted = false";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                size += rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return size;
    }
}
