package com.example.webgallery.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    private static final String url = "jdbc:postgresql://localhost:5432/web_gallery";

    private static final String user = "postgres";
    private static final String password = "Sardor_0607";

    public static Connection getConnection() {
        try {

            DriverManager.registerDriver(new org.postgresql.Driver());

            return DriverManager.getConnection(
                    url,
                    user,
                    password
            );

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
