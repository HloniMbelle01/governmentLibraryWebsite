package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.News;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NewsDAO {
    private static final Logger logger = Logger.getLogger(NewsDAO.class.getName());
    
    public List<News> getAllActiveNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE is_active = TRUE ORDER BY publish_date DESC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                newsList.add(extractNewsFromResultSet(resultSet));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving active news", e);
        }
        
        return newsList;
    }
    
    public List<News> getLatestNews(int maxResults) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE is_active = TRUE ORDER BY publish_date DESC LIMIT ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, maxResults);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    newsList.add(extractNewsFromResultSet(resultSet));
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving latest news", e);
        }
        
        return newsList;
    }
    
    public News getNewsById(Integer newsId) {
        News news = null;
        String sql = "SELECT * FROM news WHERE news_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, newsId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                news = extractNewsFromResultSet(resultSet);
                
                // Update view count
                updateViewCount(newsId);
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving news by ID: " + newsId, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return news;
    }
    
    public boolean createNews(News news) {
        String sql = "INSERT INTO news (title, content, publish_date, expiry_date, is_active) VALUES (?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setString(1, news.getTitle());
            statement.setString(2, news.getContent());
            
            if (news.getPublishDate() != null) {
                statement.setDate(3, new java.sql.Date(news.getPublishDate().getTime()));
            } else {
                statement.setNull(3, java.sql.Types.DATE);
            }
            
            if (news.getExpiryDate() != null) {
                statement.setDate(4, new java.sql.Date(news.getExpiryDate().getTime()));
            } else {
                statement.setNull(4, java.sql.Types.DATE);
            }
            
            statement.setBoolean(5, news.getIsActive());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        news.setNewsId(generatedKeys.getInt(1));
                    }
                }
                logger.info("Created new news article: " + news.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating news: " + news.getTitle(), e);
        } finally {
            closeResources(connection, statement, null);
        }
        
        return false;
    }
    
    public boolean updateNews(News news) {
        String sql = "UPDATE news SET title = ?, content = ?, publish_date = ?, expiry_date = ?, is_active = ? WHERE news_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, news.getTitle());
            statement.setString(2, news.getContent());
            
            if (news.getPublishDate() != null) {
                statement.setDate(3, new java.sql.Date(news.getPublishDate().getTime()));
            } else {
                statement.setNull(3, java.sql.Types.DATE);
            }
            
            if (news.getExpiryDate() != null) {
                statement.setDate(4, new java.sql.Date(news.getExpiryDate().getTime()));
            } else {
                statement.setNull(4, java.sql.Types.DATE);
            }
            
            statement.setBoolean(5, news.getIsActive());
            statement.setInt(6, news.getNewsId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                logger.info("Updated news article: " + news.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating news: " + news.getTitle(), e);
        }
        
        return false;
    }
    
    public boolean deleteNews(Integer newsId) {
        String sql = "DELETE FROM news WHERE news_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, newsId);
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                logger.info("Deleted news with ID: " + newsId);
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting news with ID: " + newsId, e);
        }
        
        return false;
    }
    
    private News extractNewsFromResultSet(ResultSet resultSet) throws SQLException {
        News news = new News();
        news.setNewsId(resultSet.getInt("news_id"));
        news.setTitle(resultSet.getString("title"));
        news.setContent(resultSet.getString("content"));
        news.setPublishDate(resultSet.getDate("publish_date"));
        news.setViewCount(resultSet.getInt("view_count"));
        news.setTags(resultSet.getString("tags"));
        news.setExpiryDate(resultSet.getDate("expiry_date"));
        news.setIsActive(resultSet.getBoolean("is_active"));
        news.setCreatedAt(resultSet.getTimestamp("created_at"));
        return news;
    }
    
    private void updateViewCount(Integer newsId) {
        String sql = "UPDATE news SET view_count = view_count + 1 WHERE news_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, newsId);
            statement.executeUpdate();
            
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error updating view count for news ID: " + newsId, e);
        }
    }
    
     // Method to get related news (by tags or recent)
    public List<News> getRelatedNews(Integer currentNewsId, int limit) {
        List<News> relatedNews = new ArrayList<>();
        
        // First try to get news with similar tags
        String sql = "SELECT n1.* FROM news n1 " +
                    "WHERE n1.news_id != ? AND n1.tags IS NOT NULL " +
                    "AND EXISTS (SELECT 1 FROM news n2 WHERE n2.news_id = ? " +
                    "AND (n1.tags LIKE CONCAT('%', n2.tags, '%') OR n2.tags LIKE CONCAT('%', n1.tags, '%'))) " +
                    "ORDER BY n1.publish_date DESC LIMIT ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, currentNewsId);
            statement.setInt(2, currentNewsId);
            statement.setInt(3, limit);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    relatedNews.add(extractNewsFromResultSet(resultSet));
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error retrieving related news", e);
        }
        
        // If not enough related news by tags, get recent news
        if (relatedNews.size() < limit) {
            String fallbackSql = "SELECT * FROM news WHERE news_id != ? ORDER BY publish_date DESC LIMIT ?";
            
            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement statement = connection.prepareStatement(fallbackSql)) {
                
                statement.setInt(1, currentNewsId);
                statement.setInt(2, limit - relatedNews.size());
                
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        relatedNews.add(extractNewsFromResultSet(resultSet));
                    }
                }
                
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Error retrieving fallback related news", e);
            }
        }
        
        return relatedNews;
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