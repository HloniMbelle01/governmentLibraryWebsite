package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Service;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ServiceDAO {
    private static final Logger logger = Logger.getLogger(ServiceDAO.class.getName());
    
    
    
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services ORDER BY name";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                services.add(extractServiceFromResultSet(resultSet));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving all services", e);
        }
        
        return services;
    }
    
    public List<Service> getAllActiveServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = TRUE ORDER BY name";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                services.add(extractServiceFromResultSet(resultSet));
            }
            
            logger.info("Retrieved " + services.size() + " active services from database");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving active services", e);
        }
        
        return services;
    }
    
    public Service getServiceById(Integer serviceId) {
        Service service = null;
        String sql = "SELECT * FROM services WHERE service_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, serviceId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    service = extractServiceFromResultSet(resultSet);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving service by ID: " + serviceId, e);
        }
        
        return service;
    }
    
    public boolean createService(Service service) {
        String sql = "INSERT INTO services (name, description, icon_class, page_link, is_active) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            statement.setString(1, service.getName());
            statement.setString(2, service.getDescription());
            statement.setString(3, service.getIconClass());
            statement.setString(4, service.getPageLink());
            statement.setBoolean(5, service.getIsActive());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        service.setServiceId(generatedKeys.getInt(1));
                    }
                }
                logger.info("Created new service: " + service.getName());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating service: " + service.getName(), e);
        }
        
        return false;
    }
    
    private Service extractServiceFromResultSet(ResultSet resultSet) throws SQLException {
        Service service = new Service();
        service.setServiceId(resultSet.getInt("service_id"));
        service.setName(resultSet.getString("name"));
        service.setDescription(resultSet.getString("description"));
        service.setIconClass(resultSet.getString("icon_class"));
        service.setPageLink(resultSet.getString("page_link"));
        service.setIsActive(resultSet.getBoolean("is_active"));
        return service;
    }
}