package com.dsac.library.ejb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseConnection {
    private static final Logger logger = Logger.getLogger(DatabaseConnection.class.getName());
    
    // Update these with your actual MySQL credentials
    private static final String URL = "jdbc:mysql://localhost:3306/dsac_library?" +
        "useSSL=false&" +
        "allowPublicKeyRetrieval=true&" +
        "serverTimezone=UTC&" +
        "useUnicode=true&" +
        "characterEncoding=UTF-8";
    
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    static {
        try {
            Class.forName(DRIVER);
            logger.info("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Failed to load MySQL JDBC Driver", e);
            throw new RuntimeException("Failed to load MySQL JDBC Driver", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            return connection;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to establish database connection", e);
            throw e;
        }
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Failed to close database connection", e);
            }
        }
    }
}