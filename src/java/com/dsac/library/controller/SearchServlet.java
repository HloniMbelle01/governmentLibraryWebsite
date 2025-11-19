package com.dsac.library.controller;

import com.dsac.library.ejb.dao.BookService;
import com.dsac.library.ejb.model.Book;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String query = request.getParameter("q");
        String scope = request.getParameter("scope");
        
        if (query != null && !query.trim().isEmpty()) {
            List<Book> searchResults = bookService.searchBooks(query.trim());
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchQuery", query);
            request.setAttribute("searchScope", scope);
        }
        
        request.getRequestDispatcher("/views/search-results.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}