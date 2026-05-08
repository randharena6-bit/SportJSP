package com.sportconnect.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Utility class for database connections
 * SPORT CONNECT - Écosystème Numérique du Sport Malgache
 * 
 * @author RANDRIANIRINA Harena Eric Miaritsoa - SE20240079
 * @version 1.0
 */
public class DatabaseConnection {
    
    private static String url;
    private static String username;
    private static String password;
    private static String driver;
    
    private static volatile DatabaseConnection instance;
    private static final ThreadLocal<Connection> connectionHolder = new ThreadLocal<>();
    
    static {
        try {
            Properties props = new Properties();
            InputStream inputStream = DatabaseConnection.class.getClassLoader()
                    .getResourceAsStream("db.properties");
            
            if (inputStream != null) {
                props.load(inputStream);
                url = props.getProperty("db.url");
                username = props.getProperty("db.username");
                password = props.getProperty("db.password");
                driver = props.getProperty("db.driver");
                
                // Load JDBC driver
                Class.forName(driver);
                
                inputStream.close();
            } else {
                // Default configuration
                url = "jdbc:mysql://localhost:3306/sportconnect?useSSL=false&serverTimezone=Africa/Nairobi";
                username = "root";
                password = "root";
                driver = "com.mysql.cj.jdbc.Driver";
                Class.forName(driver);
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize database configuration", e);
        }
    }
    
    private DatabaseConnection() {}
    
    /**
     * Singleton instance getter
     */
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }
    
    /**
     * Get a database connection
     * Uses ThreadLocal to ensure thread safety
     */
    public Connection getConnection() throws SQLException {
        Connection conn = connectionHolder.get();
        
        if (conn == null || conn.isClosed()) {
            conn = DriverManager.getConnection(url, username, password);
            connectionHolder.set(conn);
        }
        
        return conn;
    }
    
    /**
     * Get a new database connection (not ThreadLocal)
     */
    public Connection getNewConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
    
    /**
     * Close the current ThreadLocal connection
     */
    public void closeConnection() {
        Connection conn = connectionHolder.get();
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                connectionHolder.remove();
            }
        }
    }
    
    /**
     * Test database connection
     */
    public boolean testConnection() {
        try (Connection conn = getNewConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Database connection test failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get database URL (for logging/debugging)
     */
    public static String getDatabaseUrl() {
        return url;
    }
}
