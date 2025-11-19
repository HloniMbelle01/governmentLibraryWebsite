package com.dsac.library.controller;

import com.dsac.library.ejb.dao.EventService;
import com.dsac.library.ejb.dao.LibraryService;
import com.dsac.library.ejb.dao.NewsService;
import com.dsac.library.ejb.dao.ServiceService;
import com.dsac.library.ejb.model.Event;
import com.dsac.library.ejb.model.Library;
import com.dsac.library.ejb.model.News;
import com.dsac.library.ejb.model.Service;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LibraryDataServlet", urlPatterns = {"/int"})
public class LibraryDataServlet extends HttpServlet {
    
    @EJB
    private LibraryService libraryService;
    
    @EJB
    private NewsService newsService;
    
    @EJB
    private EventService eventService;
    
    @EJB
    private ServiceService serviceService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/libraries":
                    handleLibrariesRequest(request, response);
                    break;
                case "/news":
                    handleNewsRequest(request, response);
                    break;
                case "/events":
                    handleEventsRequest(request, response);
                    break;
                case "/services":
                    handleServicesRequest(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }
    
    private void handleLibrariesRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Library> libraries = libraryService.getAllLibraries();
        request.setAttribute("libraries", libraries);
        request.getRequestDispatcher("/views/libraries-list.jsp").forward(request, response);
    }
    
    private void handleNewsRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            String newsIdParam = request.getParameter("id");
            if (newsIdParam != null) {
                try {
                    Integer newsId = Integer.parseInt(newsIdParam);
                    News news = newsService.getNewsById(newsId);
                    if (news != null) {
                        request.setAttribute("news", news);
                        request.getRequestDispatcher("/views/news-detail.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // Invalid ID format
                }
            }
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "News article not found");
        } else {
            List<News> allNews = newsService.getAllActiveNews();
            request.setAttribute("newsList", allNews);
            request.getRequestDispatcher("/views/news-list.jsp").forward(request, response);
        }
    }
    
    private void handleEventsRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Event> events = eventService.getAllUpcomingEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("/views/events-list.jsp").forward(request, response);
    }
    
    private void handleServicesRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Service> services = serviceService.getAllActiveServices();
        request.setAttribute("services", services);
        request.getRequestDispatcher("/views/services-list.jsp").forward(request, response);
    }
}