// DSAC-Library-ejb/src/java/com/dsac/library/ejb/dao/BookService.java
package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Book;
import com.dsac.library.ejb.model.Library;
import javax.ejb.Stateless;
import java.util.List;
import java.util.Map;

@Stateless
public class BookService {
    
    private BookDAO bookDAO = new BookDAO();
    
    public boolean createBook(Book book) {
        return bookDAO.createBook(book);
    }
    
    public List<Book> getAllBooks() {
        return bookDAO.getAllBooks();
    }
    
    public List<Book> getFeaturedBooks() {
        return bookDAO.getFeaturedBooks();
    }
    
    public List<Book> searchBooks(String query) {
        return bookDAO.searchBooks(query);
    }
    
    public Book getBookById(Integer bookId) {
        return bookDAO.getBookById(bookId);
    }
    
    public List<Library> getLibrariesForBook(Integer bookId) {
        return bookDAO.getLibrariesForBook(bookId);
    }
    
    // NEW METHOD: Get books by category
    public List<Book> getBooksByCategory(String category) {
        return bookDAO.getBooksByCategory(category);
    }
    
    // NEW METHOD: Get all books grouped by category
    public Map<String, List<Book>> getBooksGroupedByCategory() {
        return bookDAO.getBooksGroupedByCategory();
    }
    
    // NEW METHOD: Get all available categories
    public List<String> getAllCategories() {
        return bookDAO.getAllCategories();
    }
}