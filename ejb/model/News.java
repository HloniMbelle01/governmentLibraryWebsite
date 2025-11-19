package com.dsac.library.ejb.model;

import java.io.Serializable;
import java.util.Date;

public class News implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer newsId;
    private String title;
    private String content;
    private String summary; // NEW FIELD
    private Date publishDate;
    private Integer viewCount; // NEW FIELD
    private String tags; // NEW FIELD (comma-separated)
    private Date expiryDate;
    private Boolean isActive;

    private Date createdAt;
    
    public News() {
        this.isActive = true;
        this.createdAt = new Date();
        this.viewCount = 0;
    }
    
    public News(String title, String content, Date publishDate) {
        this();
        this.title = title;
        this.content = content;
        this.publishDate = publishDate;
    }
    
    // Getters and Setters
    public Integer getNewsId() { return newsId; }
    public void setNewsId(Integer newsId) { this.newsId = newsId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    
    public Date getPublishDate() { return publishDate; }
    public void setPublishDate(Date publishDate) { this.publishDate = publishDate; }
    
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
    
    
    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }
    
    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

     // Utility method to get formatted date
    public String getFormattedDate() {
        if (publishDate == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
        return sdf.format(publishDate);
    }
    
    // Utility method to calculate reading time
    public String getReadingTime() {
        if (content == null) return "1 min";
        
        // Average reading speed: 200-250 words per minute
        int wordCount = content.split("\\s+").length;
        int readingTimeMinutes = Math.max(1, wordCount / 200); // At least 1 minute
        
        return readingTimeMinutes + " min";
    }
    
    // Utility method to get tags as array
    public String[] getTagsArray() {
        if (tags == null || tags.trim().isEmpty()) {
            return new String[0];
        }
        return tags.split("\\s*,\\s*");
    }
    
    @Override
    public String toString() {
        return "News{" +
                "newsId=" + newsId +
                ", title='" + title + '\'' +
                ", publishDate=" + publishDate +
                ", viewCount=" + viewCount +
                '}';
    }

}