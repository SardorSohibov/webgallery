package com.example.webgallery.dao;

import com.example.webgallery.model.Folder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FolderDao {
    private static FolderDao instance;

    public static FolderDao getInstance() {
        if (instance == null) {
            instance = new FolderDao();
        }
        return instance;
    }

    public void addFolder(Folder folder) {
        PreparedStatement pstmt = null;
        PreparedStatement preparedStatement = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "insert into folders (id, name, owner_id) values (?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, folder.getId());
            pstmt.setString(2, folder.getFolderName());
            pstmt.setString(3, folder.getOwnerId());
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteFolder(String folderId) {
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "update folders set deleted = true where id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, folderId);
            pstmt.execute();
            ImageDao imageDao = ImageDao.getInstance();
            imageDao.deleteImageByFolderId(folderId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Folder> getAllFoldersByUserId(String userId) {
        ArrayList<Folder> folders = new ArrayList<>();
        PreparedStatement pstmt = null;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String sql = "select * from folders where owner_id = ? and deleted = false";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Folder folder = new Folder();
                folder.setId(rs.getString("id"));
                folder.setFolderName(rs.getString("name"));
                folder.setOwnerId(rs.getString("owner_id"));
                folders.add(folder);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return folders;
    }

}
