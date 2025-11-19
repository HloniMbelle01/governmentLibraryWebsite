// DSAC-Library-ejb/src/java/com/dsac/library/ejb/dao/LibraryDAO.java
package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Library;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LibraryDAO {
    private static final Logger logger = Logger.getLogger(LibraryDAO.class.getName());
    
    
    
    public List<Library> getAllLibraries() {
        List<Library> libraries = new ArrayList<>();
        String sql = "SELECT * FROM libraries ORDER BY name";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Library library = new Library();
                library.setLibraryId(resultSet.getInt("library_id"));
                library.setName(resultSet.getString("name"));
                library.setAddress(resultSet.getString("address"));
                library.setPhone(resultSet.getString("phone"));
                library.setEmail(resultSet.getString("email"));
                library.setHours(resultSet.getString("hours"));
                library.setImageUrl(resultSet.getString("image_url"));
                library.setCreatedAt(resultSet.getTimestamp("created_at"));
                
                libraries.add(library);
            }
            
            logger.info("Retrieved " + libraries.size() + " libraries from database");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving libraries from database", e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return libraries;
    }
    
    public Library getLibraryById(Integer libraryId) {
        Library library = null;
        String sql = "SELECT * FROM libraries WHERE library_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, libraryId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                library = new Library();
                library.setLibraryId(resultSet.getInt("library_id"));
                library.setName(resultSet.getString("name"));
                library.setAddress(resultSet.getString("address"));
                library.setPhone(resultSet.getString("phone"));
                library.setEmail(resultSet.getString("email"));
                library.setHours(resultSet.getString("hours"));
                library.setImageUrl(resultSet.getString("image_url"));
                library.setCreatedAt(resultSet.getTimestamp("created_at"));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving library by ID: " + libraryId, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return library;
    }
    
    // NEW METHOD: Get library by exact name match
    public Library getLibraryByName(String name) {
        Library library = null;
        String sql = "SELECT * FROM libraries WHERE name = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                library = extractLibraryFromResultSet(resultSet);
            }
            
            logger.info(library != null ? 
                "Found library: " + name : 
                "Library not found: " + name);
                
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving library by name: " + name, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return library;
    }
    
    
    
    // OPTIONAL: Get libraries by partial name match
    public List<Library> searchLibrariesByName(String name) {
        List<Library> libraries = new ArrayList<Library>();
        String sql = "SELECT * FROM libraries WHERE LOWER(name) LIKE LOWER(?) ORDER BY name";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + name + "%");
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                libraries.add(extractLibraryFromResultSet(resultSet));
            }
            
            logger.info("Found " + libraries.size() + " libraries matching: " + name);
                
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching libraries by name: " + name, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return libraries;
    }
    public List<Library> getLibrariesByDistrict(String district) {
    List<Library> libraries = new ArrayList<>();
    String sql = "SELECT * FROM libraries WHERE district = ? ORDER BY name";
    
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        connection = DatabaseConnection.getConnection();
        statement = connection.prepareStatement(sql);
        statement.setString(1, district);
        resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            Library library = extractLibraryFromResultSet(resultSet);
            libraries.add(library);
        }
        
        logger.info("Retrieved " + libraries.size() + " libraries for district: " + district);
        
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error retrieving libraries for district: " + district, e);
    } finally {
        closeResources(connection, statement, resultSet);
    }
    
    return libraries;
}

public List<String> getAllDistricts() {
    List<String> districts = new ArrayList<>();
    String sql = "SELECT DISTINCT district FROM libraries WHERE district IS NOT NULL ORDER BY district";
    
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        connection = DatabaseConnection.getConnection();
        statement = connection.prepareStatement(sql);
        resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            districts.add(resultSet.getString("district"));
        }
        
        logger.info("Retrieved " + districts.size() + " distinct districts");
        
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error retrieving districts from database", e);
    } finally {
        closeResources(connection, statement, resultSet);
    }
    
    return districts;
}

// Update your existing extractLibraryFromResultSet method to include district
private Library extractLibraryFromResultSet(ResultSet resultSet) throws SQLException {
    Library library = new Library();
    library.setLibraryId(resultSet.getInt("library_id"));
    library.setName(resultSet.getString("name"));
    library.setAddress(resultSet.getString("address"));
    library.setPhone(resultSet.getString("phone"));
    library.setEmail(resultSet.getString("email"));
    library.setHours(resultSet.getString("hours"));
    library.setImageUrl(resultSet.getString("image_url"));
    library.setCreatedAt(resultSet.getTimestamp("created_at"));
    
    // Add district field - handle potential null values
    try {
        library.setDistrict(resultSet.getString("district"));
    } catch (SQLException e) {
        // If district column doesn't exist yet, set to null
        library.setDistrict(null);
    }
    
    return library;
}
    
    public boolean createLibrary(Library library) {
        String sql = "INSERT INTO libraries (name, address, phone, email, hours, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setString(1, library.getName());
            statement.setString(2, library.getAddress());
            statement.setString(3, library.getPhone());
            statement.setString(4, library.getEmail());
            statement.setString(5, library.getHours());
            statement.setString(6, library.getImageUrl());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        library.setLibraryId(generatedKeys.getInt(1));
                    }
                }
                logger.info("Created new library: " + library.getName());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating library: " + library.getName(), e);
        } finally {
            closeResources(connection, statement, null);
        }
        
        return false;
    }
    
    private void closeResources(Connection connection, PreparedStatement statement, ResultSet resultSet) {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) DatabaseConnection.closeConnection(connection);
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error closing database resources", e);
        }
    }
}