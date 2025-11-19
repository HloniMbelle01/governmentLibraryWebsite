// DSAC-Library-ejb/src/java/com/dsac/library/ejb/dao/BookDAO.java
package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Book;
import com.dsac.library.ejb.model.Library;
import com.dsac.library.ejb.util.DatabaseConnection;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookDAO {
    private static final Logger logger = Logger.getLogger(BookDAO.class.getName());
    
    public boolean createBook(Book book) {
        String sql = "INSERT INTO books (title, author, isbn, publisher, published_date, description, cover_image, category, total_copies, available_copies) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setString(3, book.getIsbn());
            statement.setString(4, book.getPublisher());
            
            if (book.getPublishedDate() != null) {
                statement.setDate(5, new java.sql.Date(book.getPublishedDate().getTime()));
            } else {
                statement.setNull(5, java.sql.Types.DATE);
            }
            
            statement.setString(6, book.getDescription());
            statement.setString(7, book.getCoverImage());
            statement.setString(8, book.getCategory());
            statement.setInt(9, book.getTotalCopies());
            statement.setInt(10, book.getAvailableCopies());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        book.setBookId(generatedKeys.getInt(1));
                    }
                }
                logger.info("Created new book: " + book.getTitle());
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating book: " + book.getTitle(), e);
        } finally {
            closeResources(connection, statement, null);
        }
        
        return false;
    }
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY title";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                books.add(extractBookFromResultSet(resultSet));
            }
            
            logger.info("Retrieved " + books.size() + " books from database");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving books from database", e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return books;
    }
    
    public List<Book> getFeaturedBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY created_at DESC LIMIT 8";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                books.add(extractBookFromResultSet(resultSet));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving featured books", e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return books;
    }
    
    public List<Book> searchBooks(String query) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR category LIKE ? ORDER BY title";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            String searchPattern = "%" + query + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                books.add(extractBookFromResultSet(resultSet));
            }
            
            logger.info("Found " + books.size() + " books matching: " + query);
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching books with query: " + query, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return books;
    }
    
    public Book getBookById(Integer bookId) {
        Book book = null;
        String sql = "SELECT * FROM books WHERE book_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, bookId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                book = extractBookFromResultSet(resultSet);
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving book by ID: " + bookId, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return book;
    }
    
    // NEW METHOD: Get books by category
    public List<Book> getBooksByCategory(String category) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE category = ? ORDER BY title";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                books.add(extractBookFromResultSet(resultSet));
            }
            
            logger.info("Retrieved " + books.size() + " books for category: " + category);
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving books by category: " + category, e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return books;
    }
    
    // NEW METHOD: Get all books grouped by category
public Map<String, List<Book>> getBooksGroupedByCategory() {
    Map<String, List<Book>> booksByCategory = new LinkedHashMap<>();
    String sql = "SELECT * FROM books ORDER BY category, title";
    
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        connection = DatabaseConnection.getConnection();
        statement = connection.prepareStatement(sql);
        resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            Book book = extractBookFromResultSet(resultSet);
            String category = book.getCategory() != null ? book.getCategory() : "Uncategorized";
            
            addBookToCategory(booksByCategory, category, book);
        }
        
        logger.info("Grouped books into " + booksByCategory.size() + " categories");
        
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error grouping books by category", e);
    } finally {
        closeResources(connection, statement, resultSet);
    }
    
    return booksByCategory;
}

// Helper method for adding books to categories
private void addBookToCategory(Map<String, List<Book>> booksByCategory, String category, Book book) {
    List<Book> categoryBooks = booksByCategory.get(category);
    if (categoryBooks == null) {
        categoryBooks = new ArrayList<Book>();
        booksByCategory.put(category, categoryBooks);
    }
    categoryBooks.add(book);
}
    
    // NEW METHOD: Get all available categories
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM books WHERE category IS NOT NULL ORDER BY category";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                String category = resultSet.getString("category");
                if (category != null && !category.trim().isEmpty()) {
                    categories.add(category);
                }
            }
            
            logger.info("Retrieved " + categories.size() + " distinct categories");
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving categories", e);
        } finally {
            closeResources(connection, statement, resultSet);
        }
        
        return categories;
    }
    
    public List<Library> getLibrariesForBook(Integer bookId) {
        List<Library> libraries = new ArrayList<>();
        String sql = "SELECT l.* FROM libraries l " +
                     "JOIN library_books lb ON l.library_id = lb.library_id " +
                     "WHERE lb.book_id = ? AND lb.copies_available > 0 " +
                     "ORDER BY l.name";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, bookId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
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
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving libraries for book ID: " + bookId, e);
        }
        
        return libraries;
    }
    
    private Book extractBookFromResultSet(ResultSet resultSet) throws SQLException {
        Book book = new Book();
        book.setBookId(resultSet.getInt("book_id"));
        book.setTitle(resultSet.getString("title"));
        book.setAuthor(resultSet.getString("author"));
        book.setIsbn(resultSet.getString("isbn"));
        book.setPublisher(resultSet.getString("publisher"));
        book.setPublishedDate(resultSet.getDate("published_date"));
        book.setDescription(resultSet.getString("description"));
        book.setCoverImage(resultSet.getString("cover_image"));
        book.setCategory(resultSet.getString("category"));
        book.setTotalCopies(resultSet.getInt("total_copies"));
        book.setAvailableCopies(resultSet.getInt("available_copies"));
        book.setCreatedAt(resultSet.getTimestamp("created_at"));
        return book;
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