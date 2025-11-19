/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.dsac.library.controller;

import com.dsac.library.ejb.dao.LibraryService;
import com.dsac.library.ejb.model.Library;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LehlohonoloM
 */
@WebServlet(name = "LibrariesServlet", urlPatterns = {"/libraries"})
public class LibrariesServlet extends HttpServlet {
    @EJB 
    private LibraryService libraryService;
    
    private static final Logger logger = Logger.getLogger(LibrariesServlet.class.getName());
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String district = request.getParameter("district");
        List<Library> libraries;
        
        if (district != null && !district.trim().isEmpty() && !"all".equalsIgnoreCase(district)) {
            // Filter by district
            libraries = libraryService.getLibrariesByDistrict(district);
            request.setAttribute("selectedDistrict", district);
            logger.info("Filtering libraries for district: " + district);
        } else {
            // Show all libraries
            libraries = libraryService.getAllLibraries();
            logger.info("Showing all libraries");
        }
        
        // Get all districts for the filter dropdown
        List<String> districts = libraryService.getAllDistricts();
        
        request.setAttribute("libraries", libraries);
        request.setAttribute("districts", districts);
        request.setAttribute("pageTitle", "Our Libraries");
        
        request.getRequestDispatcher("/views/libraries-list.jsp").forward(request, response);
    }
}

