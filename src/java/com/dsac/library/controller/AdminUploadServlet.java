package com.dsac.library.controller;

import com.dsac.library.ejb.dao.*;
import com.dsac.library.ejb.model.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/upload")
public class AdminUploadServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @EJB
    private LibraryService libraryService;
    
    @EJB
    private NewsService newsService;
    
    @EJB
    private EventService eventService;
    
    @EJB
    private ServiceService serviceService;
    
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin-upload.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String message = "";
        boolean success = false;
        
        try {
            switch (action) {
                case "add_book":
                    success = addBook(request);
                    message = success ? "Book added successfully!" : "Failed to add book.";
                    break;
                    
                case "add_library":
                    success = addLibrary(request);
                    message = success ? "Library added successfully!" : "Failed to add library.";
                    break;
                    
                case "add_news":
                    success = addNews(request);
                    message = success ? "News added successfully!" : "Failed to add news.";
                    break;
                    
                case "add_event":
                    success = addEvent(request);
                    message = success ? "Event added successfully!" : "Failed to add event.";
                    break;
                    
                case "add_service":
                    success = addService(request);
                    message = success ? "Service added successfully!" : "Failed to add service.";
                    break;
                    
                default:
                    message = "Invalid action specified.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        }
        
        request.setAttribute("message", message);
        request.setAttribute("success", success);
        request.getRequestDispatcher("/views/admin-upload.jsp").forward(request, response);
    }
    
    private boolean addBook(HttpServletRequest request) throws ParseException {
        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setAuthor(request.getParameter("author"));
        book.setIsbn(request.getParameter("isbn"));
        book.setPublisher(request.getParameter("publisher"));
        
        String publishedDateStr = request.getParameter("published_date");
        if (publishedDateStr != null && !publishedDateStr.isEmpty()) {
            book.setPublishedDate(dateFormat.parse(publishedDateStr));
        }
        
        book.setDescription(request.getParameter("description"));
        book.setCoverImage(request.getParameter("cover_image"));
        book.setCategory(request.getParameter("category"));
        
        String totalCopiesStr = request.getParameter("total_copies");
        if (totalCopiesStr != null && !totalCopiesStr.isEmpty()) {
            book.setTotalCopies(Integer.parseInt(totalCopiesStr));
            book.setAvailableCopies(Integer.parseInt(totalCopiesStr));
        } else {
            book.setTotalCopies(1);
            book.setAvailableCopies(1);
        }
        
        return bookService.createBook(book);
    }
    
    private boolean addLibrary(HttpServletRequest request) {
        Library library = new Library();
        library.setName(request.getParameter("name"));
        library.setAddress(request.getParameter("address"));
        library.setPhone(request.getParameter("phone"));
        library.setEmail(request.getParameter("email"));
        library.setHours(request.getParameter("hours"));
        library.setImageUrl(request.getParameter("image_url"));
        
        return libraryService.createLibrary(library);
    }
    
    private boolean addNews(HttpServletRequest request) throws ParseException {
        News news = new News();
        news.setTitle(request.getParameter("title"));
        news.setContent(request.getParameter("content"));
        
        String publishDateStr = request.getParameter("publish_date");
        if (publishDateStr != null && !publishDateStr.isEmpty()) {
            news.setPublishDate(dateFormat.parse(publishDateStr));
        } else {
            news.setPublishDate(new Date());
        }
        
        String expiryDateStr = request.getParameter("expiry_date");
        if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
            news.setExpiryDate(dateFormat.parse(expiryDateStr));
        }
        
        String isActive = request.getParameter("is_active");
        news.setIsActive(isActive != null && isActive.equals("true"));
        
        return newsService.createNews(news);
    }
    
    private boolean addEvent(HttpServletRequest request) throws ParseException {
        Event event = new Event();
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        
        String eventDateStr = request.getParameter("event_date");
        if (eventDateStr != null && !eventDateStr.isEmpty()) {
            event.setEventDate(dateFormat.parse(eventDateStr));
        } else {
            event.setEventDate(new Date());
        }
        
        String eventTimeStr = request.getParameter("event_time");
        if (eventTimeStr != null && !eventTimeStr.isEmpty()) {
            event.setEventTime(timeFormat.parse(eventTimeStr));
        } else {
            event.setEventTime(new Date());
        }
        
        event.setLocation(request.getParameter("location"));
        
        // If library ID is provided, set the library
        String libraryIdStr = request.getParameter("library_id");
        if (libraryIdStr != null && !libraryIdStr.isEmpty()) {
            Library library = libraryService.getLibraryById(Integer.parseInt(libraryIdStr));
            if (library != null) {
                event.setLibrary(library);
            }
        }
        
        return eventService.createEvent(event);
    }
    
    private boolean addService(HttpServletRequest request) {
        Service service = new Service();
        service.setName(request.getParameter("name"));
        service.setDescription(request.getParameter("description"));
        service.setIconClass(request.getParameter("icon_class"));
        service.setPageLink(request.getParameter("page_link"));
        
        String isActive = request.getParameter("is_active");
        service.setIsActive(isActive != null && isActive.equals("true"));
        
        return serviceService.createService(service);
    }
}