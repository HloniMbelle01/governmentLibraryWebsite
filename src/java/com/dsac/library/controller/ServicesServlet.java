/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.dsac.library.controller;

import com.dsac.library.ejb.dao.ServiceService;
import com.dsac.library.ejb.model.Service;
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

@WebServlet(name = "ServicesServlet", urlPatterns = {"/services"})
public class ServicesServlet extends HttpServlet {
    @EJB 
    private ServiceService serviceService;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Service> services = serviceService.getAllActiveServices();
        request.setAttribute("services", services);
        request.getRequestDispatcher("/views/services-list.jsp").forward(request, response);
    }
}
