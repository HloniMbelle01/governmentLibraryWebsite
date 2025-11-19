// DSAC-Library-ejb/src/java/com/dsac/library/ejb/dao/LibraryServiceDAO.java
package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Service;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LibraryServiceDAO {
    private static final Logger logger = Logger.getLogger(LibraryServiceDAO.class.getName());
    
    // Get all services for a specific library
    public List<Service> getServicesByLibraryId(Integer libraryId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.* FROM services s " +
                    "INNER JOIN library_services ls ON s.service_id = ls.service_id " +
                    "WHERE ls.library_id = ? AND ls.is_available = TRUE " +
                    "ORDER BY s.name";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, libraryId);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Service service = new Service();
                service.setServiceId(resultSet.getInt("service_id"));
                service.setName(resultSet.getString("name"));
                service.setDescription(resultSet.getString("description"));
                service.setIconClass(resultSet.getString("icon_class"));
                service.setPageLink(resultSet.getString("page_link"));
                service.setIsActive(resultSet.getBoolean("is_active"));
                
                services.add(service);
            }
            
            logger.info("Retrieved " + services.size() + " services for library ID: " + libraryId);
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving services for library ID: " + libraryId, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return services;
    }
    
    // Get all active services (for home page)
    public List<Service> getAllActiveServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = TRUE ORDER BY name";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Service service = new Service();
                service.setServiceId(resultSet.getInt("service_id"));
                service.setName(resultSet.getString("name"));
                service.setDescription(resultSet.getString("description"));
                service.setIconClass(resultSet.getString("icon_class"));
                service.setPageLink(resultSet.getString("page_link"));
                service.setIsActive(resultSet.getBoolean("is_active"));
                
                services.add(service);
            }
            
            logger.info("Retrieved " + services.size() + " active services");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving all active services", e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return services;
    }
    
    // Check if a specific service is available at a library
    public boolean isServiceAvailable(Integer libraryId, Integer serviceId) {
        String sql = "SELECT COUNT(*) FROM library_services " +
                    "WHERE library_id = ? AND service_id = ? AND is_available = TRUE";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, libraryId);
            statement.setInt(2, serviceId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking service availability for library: " + libraryId + ", service: " + serviceId, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return false;
    }
    
    // Add a service to a library
    public boolean addServiceToLibrary(Integer libraryId, Integer serviceId, String additionalInfo) {
        String sql = "INSERT INTO library_services (library_id, service_id, additional_info) VALUES (?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE is_available = TRUE, additional_info = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, libraryId);
            statement.setInt(2, serviceId);
            statement.setString(3, additionalInfo);
            statement.setString(4, additionalInfo);
            
            int affectedRows = statement.executeUpdate();
            logger.info("Added service " + serviceId + " to library " + libraryId + ". Affected rows: " + affectedRows);
            return affectedRows > 0;
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding service to library", e);
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