package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Event;
import com.dsac.library.ejb.model.Library;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO {
    private static final Logger logger = Logger.getLogger(EventDAO.class.getName());
    
    public List<Event> getAllUpcomingEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE e.event_date >= CURDATE() " +
                    "ORDER BY e.event_date ASC, e.event_time ASC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                events.add(extractEventFromResultSet(resultSet));
            }
            
            logger.info("Retrieved " + events.size() + " upcoming events from database");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving upcoming events", e);
        }
        
        return events;
    }
    
    public List<Event> getUpcomingEvents(int maxResults) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE e.event_date >= CURDATE() " +
                    "ORDER BY e.event_date ASC, e.event_time ASC " +
                    "LIMIT ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, maxResults);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    events.add(extractEventFromResultSet(resultSet));
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving " + maxResults + " upcoming events", e);
        }
        
        return events;
    }
    
    public List<Event> getEventsByLibrary(Integer libraryId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE e.library_id = ? AND e.event_date >= CURDATE() " +
                    "ORDER BY e.event_date ASC, e.event_time ASC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, libraryId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    events.add(extractEventFromResultSet(resultSet));
                }
            }
            
            logger.info("Retrieved " + events.size() + " events for library ID: " + libraryId);
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving events for library ID: " + libraryId, e);
        }
        
        return events;
    }
    
    public List<Event> getEventsThisMonth() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE YEAR(e.event_date) = YEAR(CURDATE()) AND MONTH(e.event_date) = MONTH(CURDATE()) " +
                    "ORDER BY e.event_date ASC, e.event_time ASC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                events.add(extractEventFromResultSet(resultSet));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving events for this month", e);
        }
        
        return events;
    }
    
    public Event getEventById(Integer eventId) {
        Event event = null;
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE e.event_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, eventId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    event = extractEventFromResultSet(resultSet);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving event by ID: " + eventId, e);
        }
        
        return event;
    }
    
    public boolean createEvent(Event event) {
        String sql = "INSERT INTO events (title, description, event_date, event_time, location, library_id) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            statement.setString(1, event.getTitle());
            statement.setString(2, event.getDescription());
            statement.setDate(3, new java.sql.Date(event.getEventDate().getTime()));
            statement.setTime(4, new java.sql.Time(event.getEventTime().getTime()));
            statement.setString(5, event.getLocation());
            
            if (event.getLibrary() != null && event.getLibrary().getLibraryId() != null) {
                statement.setInt(6, event.getLibrary().getLibraryId());
            } else {
                statement.setNull(6, java.sql.Types.INTEGER);
            }
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        event.setEventId(generatedKeys.getInt(1));
                    }
                }
                logger.info("Created new event: " + event.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating event: " + event.getTitle(), e);
        }
        
        return false;
    }
    
    public boolean updateEvent(Event event) {
        String sql = "UPDATE events SET title = ?, description = ?, event_date = ?, event_time = ?, location = ?, library_id = ? WHERE event_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, event.getTitle());
            statement.setString(2, event.getDescription());
            statement.setDate(3, new java.sql.Date(event.getEventDate().getTime()));
            statement.setTime(4, new java.sql.Time(event.getEventTime().getTime()));
            statement.setString(5, event.getLocation());
            
            if (event.getLibrary() != null && event.getLibrary().getLibraryId() != null) {
                statement.setInt(6, event.getLibrary().getLibraryId());
            } else {
                statement.setNull(6, java.sql.Types.INTEGER);
            }
            
            statement.setInt(7, event.getEventId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                logger.info("Updated event: " + event.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating event: " + event.getTitle(), e);
        }
        
        return false;
    }
    
    public boolean deleteEvent(Integer eventId) {
        String sql = "DELETE FROM events WHERE event_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, eventId);
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                logger.info("Deleted event with ID: " + eventId);
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting event with ID: " + eventId, e);
        }
        
        return false;
    }
    
    private Event extractEventFromResultSet(ResultSet resultSet) throws SQLException {
        Event event = new Event();
        event.setEventId(resultSet.getInt("event_id"));
        event.setTitle(resultSet.getString("title"));
        event.setDescription(resultSet.getString("description"));
        event.setEventDate(resultSet.getDate("event_date"));
        event.setEventTime(resultSet.getTime("event_time"));
        event.setLocation(resultSet.getString("location"));
        event.setCreatedAt(resultSet.getTimestamp("created_at"));
        
        // Extract Library information if available
        try {
            Integer libraryId = resultSet.getInt("library_id");
            if (!resultSet.wasNull()) {
                Library library = new Library();
                library.setLibraryId(libraryId);
                library.setName(resultSet.getString("library_name"));
                library.setAddress(resultSet.getString("address"));
                library.setPhone(resultSet.getString("phone"));
                library.setEmail(resultSet.getString("email"));
                library.setHours(resultSet.getString("hours"));
                library.setImageUrl(resultSet.getString("image_url"));
                event.setLibrary(library);
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error extracting library information for event", e);
        }
        
        return event;
    }
    
   
    public List<Event> getEventsWithinDays(int daysFromNow) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, l.library_id, l.name as library_name, l.address, l.phone, l.email, l.hours, l.image_url " +
                    "FROM events e " +
                    "LEFT JOIN libraries l ON e.library_id = l.library_id " +
                    "WHERE e.event_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL ? DAY) " +
                    "ORDER BY e.event_date ASC, e.event_time ASC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, daysFromNow);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    events.add(extractEventFromResultSet(resultSet));
                }
            }

            logger.info("Retrieved " + events.size() + " events within " + daysFromNow + " days");

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving events within " + daysFromNow + " days", e);
        }

        return events;
    }
    
}