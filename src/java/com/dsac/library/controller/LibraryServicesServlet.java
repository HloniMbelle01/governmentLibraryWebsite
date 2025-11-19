package com.dsac.library.controller;

import com.dsac.library.ejb.dao.LibraryServiceDAO;
import com.dsac.library.ejb.dao.LibraryService;
import com.dsac.library.ejb.model.Service;
import com.dsac.library.ejb.model.Library;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/library/services")
public class LibraryServicesServlet extends HttpServlet {
    
    
    private LibraryServiceDAO libraryServiceDAO = new LibraryServiceDAO();
    private LibraryService libraryService = new LibraryService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String libraryIdParam = request.getParameter("id");
        
        if (libraryIdParam != null && !libraryIdParam.isEmpty()) {
            try {
                Integer libraryId = Integer.parseInt(libraryIdParam);
                
                // Get library details
                Library library = libraryService.getLibraryById(libraryId);
                // Get services for this specific library
                List<Service> services = libraryServiceDAO.getServicesByLibraryId(libraryId);
                
                if (library != null) {
                    request.setAttribute("library", library);
                    request.setAttribute("services", services);
                    request.getRequestDispatcher("/views/library-services.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Library not found");
                }
                
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid library ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Library ID is required");
        }
    }
}