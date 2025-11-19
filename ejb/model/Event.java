package com.dsac.library.ejb.model;

import java.io.Serializable;
import java.util.Date;

public class Event implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer eventId;
    private String title;
    private String description;
    private Date eventDate;
    private Date eventTime;
    private String location;
    private Library library;
    private Date createdAt;
    
    // Constructors
    public Event() {
        this.createdAt = new Date();
    }
    
    public Event(String title, String description, Date eventDate, Date eventTime, String location) {
        this();
        this.title = title;
        this.description = description;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.location = location;
    }
    
    public Event(String title, String description, Date eventDate, Date eventTime, String location, Library library) {
        this(title, description, eventDate, eventTime, location);
        this.library = library;
    }
    
    // Getters and Setters
    public Integer getEventId() { return eventId; }
    public void setEventId(Integer eventId) { this.eventId = eventId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }
    
    public Date getEventTime() { return eventTime; }
    public void setEventTime(Date eventTime) { this.eventTime = eventTime; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public Library getLibrary() { return library; }
    public void setLibrary(Library library) { this.library = library; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    // Utility method to get formatted date string
    public String getFormattedDate() {
        if (eventDate == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
        return sdf.format(eventDate);
    }
    
    // Utility method to get formatted time string
    public String getFormattedTime() {
        if (eventTime == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("h:mm a");
        return sdf.format(eventTime);
    }
    
    @Override
    public String toString() {
        return "Event{" +
                "eventId=" + eventId +
                ", title='" + title + '\'' +
                ", eventDate=" + eventDate +
                ", location='" + location + '\'' +
                '}';
    }
}