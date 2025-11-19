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
@WebServlet(name = "NewsDetailServlet", urlPatterns = {"/news/detail"})
public class NewsDetailServlet extends HttpServlet {
    
    @EJB
    private NewsService newsService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String newsIdParam = request.getParameter("id");
        
        if (newsIdParam != null && !newsIdParam.trim().isEmpty()) {
            try {
                Integer newsId = Integer.parseInt(newsIdParam);
                News news = newsService.getNewsById(newsId);
                
                if (news != null) {
                    request.setAttribute("news", news);
                    
                    // Get related news
                    List<News> relatedNews = newsService.getRelatedNews(newsId, 3);
                    request.setAttribute("relatedNews", relatedNews);
                    
                    request.getRequestDispatcher("/views/news-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid news ID format
            }
        }
        
        // If news not found or invalid ID
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "News article not found");
    }
}