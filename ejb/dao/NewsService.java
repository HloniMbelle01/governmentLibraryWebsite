package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.News;
import java.util.List;
import javax.ejb.Stateless;

@Stateless
public class NewsService {
    
    private NewsDAO newsDAO = new NewsDAO();
    
    public List<News> getAllActiveNews() {
        return newsDAO.getAllActiveNews();
    }
    
    public List<News> getLatestNews(int maxResults) {
        return newsDAO.getLatestNews(maxResults);
    }
    
    public News getNewsById(Integer newsId) {
        return newsDAO.getNewsById(newsId);
    }
    
    public boolean createNews(News news) {
        return newsDAO.createNews(news);
    }
    
    public boolean updateNews(News news) {
        return newsDAO.updateNews(news);
    }
    
    public boolean deleteNews(Integer newsId) {
        return newsDAO.deleteNews(newsId);
    }
       
    public List<News> getRelatedNews(Integer currentNewsId, int limit) {
        return newsDAO.getRelatedNews(currentNewsId, limit);
    }
}