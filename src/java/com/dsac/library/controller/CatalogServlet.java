package com.dsac.library.controller;

import com.dsac.library.ejb.dao.BookService;
import com.dsac.library.ejb.model.Book;
import java.io.IOException;
import java.util.*;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CatalogServlet", urlPatterns = {"/catalog"})
public class CatalogServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        String searchQuery = request.getParameter("q");
        
        // Handle search if query parameter exists
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            List<Book> searchResults = bookService.searchBooks(searchQuery.trim());
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchQuery", searchQuery);
        }
        
        if (category != null && !category.trim().isEmpty()) {
            // Show books for specific category
            List<Book> categoryBooks = bookService.getBooksByCategory(category.trim());
            request.setAttribute("categoryBooks", categoryBooks);
            request.setAttribute("selectedCategory", category);
        } else {
            // Show all books grouped by categories
            Map<String, List<Book>> booksByCategory = bookService.getBooksGroupedByCategory();
            request.setAttribute("booksByCategory", booksByCategory);
        }
        
        // Get all categories for navigation
        List<String> allCategories = bookService.getAllCategories();
        request.setAttribute("allCategories", allCategories);
        
        request.getRequestDispatcher("/views/catalog.jsp").forward(request, response);
    }
}