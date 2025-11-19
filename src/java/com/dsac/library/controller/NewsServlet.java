/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.dsac.library.controller;

import com.dsac.library.ejb.dao.NewsService;
import com.dsac.library.ejb.model.News;
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
@WebServlet("/news")
public class NewsServlet extends HttpServlet {
    @EJB 
    private NewsService newsService;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
}