// DSAC-Library-war/src/java/com/dsac/library/controller/HomeServlet.java
package com.dsac.library.controller;

import com.dsac.library.ejb.dao.*;
import com.dsac.library.ejb.model.*;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    
    @EJB
    private LibraryService libraryService;
    
    @EJB
    private BookService bookService;
    
    @EJB
    private NewsService newsService;
    
    @EJB
    private EventService eventService;
    
    // Remove the EJB injection for ServiceService and use DAO directly
    private LibraryServiceDAO libraryServiceDAO = new LibraryServiceDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Fetch data from EJBs
            List<Library> libraries = libraryService.getAllLibraries();
            List<Book> featuredBooks = bookService.getFeaturedBooks();
            List<News> latestNews = newsService.getLatestNews(3);
            List<Event> upcomingEvents = eventService.getUpcomingEvents(3);
            
            // Get services using DAO directly
            List<Service> services = libraryServiceDAO.getAllActiveServices();
            
            // Get events happening in the next 3 days for alerts
            List<Event> upcomingEventswithin = eventService.getEventsWithinDays(3);
            request.setAttribute("upcomingEventswithin", upcomingEventswithin);
            
             // DEBUG: Print events to console
            System.out.println("=== DEBUG: Events Data ===");
            System.out.println("Number of events retrieved: " + (upcomingEvents != null ? upcomingEvents.size() : "null"));
            if (upcomingEvents != null) {
                for (Event event : upcomingEvents) {
                    System.out.println("Event: " + event.getTitle() + 
                                     " | Date: " + event.getEventDate() + 
                                     " | Time: " + event.getEventTime() +
                                     " | Location: " + event.getLocation());
                }
            }
            System.out.println("=== END DEBUG ===");
            
            // Set attributes for JSP
            request.setAttribute("libraries", libraries);
            request.setAttribute("featuredBooks", featuredBooks);
            request.setAttribute("latestNews", latestNews);
            request.setAttribute("upcomingEvents", upcomingEvents);
            request.setAttribute("services", services);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading home page");
        }
    }
}