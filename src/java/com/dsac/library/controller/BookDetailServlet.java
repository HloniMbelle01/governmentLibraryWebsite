package com.dsac.library.controller;

import com.dsac.library.ejb.dao.BookService;
import com.dsac.library.ejb.dao.LibraryService;
import com.dsac.library.ejb.model.Book;
import com.dsac.library.ejb.model.Library;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book/detail")
public class BookDetailServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @EJB
    private LibraryService libraryService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam != null) {
            try {
                Integer bookId = Integer.parseInt(bookIdParam);
                Book book = bookService.getBookById(bookId);
                
                if (book != null) {
                    // Get libraries where this book is available
                    List<Library> availableLibraries = bookService.getLibrariesForBook(bookId);
                    
                    request.setAttribute("book", book);
                    request.setAttribute("availableLibraries", availableLibraries);
                    request.getRequestDispatcher("/views/book-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid book ID format
            }
        }
        
        // If book not found or invalid ID
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
    }
}