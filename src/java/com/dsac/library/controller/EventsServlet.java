/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.dsac.library.controller;

import com.dsac.library.ejb.dao.EventService;
import com.dsac.library.ejb.model.Event;
import java.io.IOException;
import java.util.List;
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
@WebServlet("/Events")
public class EventsServlet extends HttpServlet {
    @EJB 
    private EventService eventService;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Event> events = eventService.getAllUpcomingEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("/views/events-list.jsp").forward(request, response);
    }
}
