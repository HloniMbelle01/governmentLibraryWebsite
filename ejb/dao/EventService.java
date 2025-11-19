package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Event;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;

@Stateless
public class EventService {
    
    private EventDAO eventDAO = new EventDAO();
    
    public List<Event> getAllUpcomingEvents() {
        return eventDAO.getAllUpcomingEvents();
    }
    
    public List<Event> getUpcomingEvents(int maxResults) {
        return eventDAO.getUpcomingEvents(maxResults);
    }
    
    public List<Event> getEventsByLibrary(Integer libraryId) {
        return eventDAO.getEventsByLibrary(libraryId);
    }
    
    public List<Event> getEventsThisMonth() {
        return eventDAO.getEventsThisMonth();
    }
    
    public Event getEventById(Integer eventId) {
        return eventDAO.getEventById(eventId);
    }
    
    public boolean createEvent(Event event) {
        return eventDAO.createEvent(event);
    }
    
    public boolean updateEvent(Event event) {
        return eventDAO.updateEvent(event);
    }
    
    public boolean deleteEvent(Integer eventId) {
        return eventDAO.deleteEvent(eventId);
    }
    
    public List<Event> getEventsWithinDays(int daysFromNow) {
        return eventDAO.getEventsWithinDays(daysFromNow);
    }
    
    public List<Event> searchEvents(String keyword) {
        List<Event> allEvents = eventDAO.getAllUpcomingEvents();
        List<Event> filteredEvents = new ArrayList<>();
        String searchTerm = keyword.toLowerCase();
        
        for (Event event : allEvents) {
            if (event.getTitle().toLowerCase().contains(searchTerm) ||
                event.getDescription().toLowerCase().contains(searchTerm) ||
                event.getLocation().toLowerCase().contains(searchTerm) ||
                (event.getLibrary() != null && 
                 event.getLibrary().getName().toLowerCase().contains(searchTerm))) {
                filteredEvents.add(event);
            }
        }
        
        return filteredEvents;
    }
}