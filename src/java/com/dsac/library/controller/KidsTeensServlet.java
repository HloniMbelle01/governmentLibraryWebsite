package com.dsac.library.controller;

import com.dsac.library.ejb.dao.BookService;
import com.dsac.library.ejb.model.Book;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "KidsTeensServlet", urlPatterns = {"/kids-teens"})
public class KidsTeensServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String ageGroup = request.getParameter("ageGroup");
        String category = request.getParameter("category");
        String searchQuery = request.getParameter("q");
        
        // Define age groups and their corresponding categories
        Map<String, List<String>> ageGroupCategories = new HashMap<>();
        ageGroupCategories.put("kids", Arrays.asList("Picture Books", "Early Readers", "Children's Fiction", "Educational"));
        ageGroupCategories.put("teens", Arrays.asList("Young Adult", "Teen Fiction", "Graphic Novels", "Study Guides"));
        
        List<Book> featuredBooks = new ArrayList<>();
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Search within kids/teens books
            featuredBooks = bookService.searchBooks(searchQuery + " " + (ageGroup != null ? ageGroup : ""));
        } else if (ageGroup != null && !ageGroup.trim().isEmpty()) {
            // Get books for specific age group
            featuredBooks = getBooksByAgeGroup(ageGroup);
        } else if (category != null && !category.trim().isEmpty()) {
            // Get books by category
            featuredBooks = bookService.getBooksByCategory(category);
        } else {
            // Get featured kids & teens books
            featuredBooks = getFeaturedKidsTeensBooks();
        }
        
        request.setAttribute("featuredBooks", featuredBooks);
        request.setAttribute("ageGroupCategories", ageGroupCategories);
        request.setAttribute("selectedAgeGroup", ageGroup);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("searchQuery", searchQuery);
        
        request.getRequestDispatcher("/views/kids-teens.jsp").forward(request, response);
    }
    
    private List<Book> getBooksByAgeGroup(String ageGroup) {
        // This would typically query your database for age-appropriate books
        // For now, we'll use category-based filtering
        List<String> categories = new ArrayList<>();
        if ("kids".equals(ageGroup)) {
            categories = Arrays.asList("Children", "Picture Books", "Early Readers", "Educational");
        } else if ("teens".equals(ageGroup)) {
            categories = Arrays.asList("Young Adult", "Teen Fiction", "Graphic Novels");
        }
        
        List<Book> allBooks = bookService.getAllBooks();
        List<Book> filteredBooks = new ArrayList<>();
        
        for (Book book : allBooks) {
            if (book.getCategory() != null) {
                for (String category : categories) {
                    if (book.getCategory().toLowerCase().contains(category.toLowerCase())) {
                        filteredBooks.add(book);
                        break;
                    }
                }
            }
        }
        
        return filteredBooks;
    }
    
    private List<Book> getFeaturedKidsTeensBooks() {
        // Get a mix of kids and teens books
        List<Book> allBooks = bookService.getAllBooks();
        List<Book> featured = new ArrayList<>();
        
        for (Book book : allBooks) {
            if (book.getCategory() != null && (
                book.getCategory().toLowerCase().contains("children") ||
                book.getCategory().toLowerCase().contains("young adult") ||
                book.getCategory().toLowerCase().contains("teen") ||
                book.getCategory().toLowerCase().contains("picture") ||
                book.getCategory().toLowerCase().contains("educational"))) {
                featured.add(book);
            }
            if (featured.size() >= 12) break; // Limit to 12 featured books
        }
        
        return featured;
    }
}