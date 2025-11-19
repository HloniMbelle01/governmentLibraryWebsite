package com.dsac.library.controller;

import com.dsac.library.ejb.dao.BookService;
import com.dsac.library.ejb.dao.EventService;
import com.dsac.library.ejb.dao.LibraryService;
import com.dsac.library.ejb.model.Book;
import com.dsac.library.ejb.model.Event;
import com.dsac.library.ejb.model.Library;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {
    
    @EJB
    private BookService bookService;
    
    @EJB
    private LibraryService libraryService;
    
    @EJB
    private EventService eventService;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String userMessage = request.getParameter("message");
        JSONObject jsonResponse = new JSONObject();
        
        try {
            ChatResponse chatResponse = processMessage(userMessage);
            
            jsonResponse.put("response", chatResponse.getMessage());
            jsonResponse.put("quickReplies", new JSONArray(chatResponse.getQuickReplies()));
            
        } catch (Exception e) {
            jsonResponse.put("response", "I'm sorry, I encountered an error. Please try again.");
            jsonResponse.put("quickReplies", new JSONArray());
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private ChatResponse processMessage(String message) {
        String lowerMessage = message.toLowerCase();
        
        // Intent recognition
        if (containsAny(lowerMessage, "book", "find book", "search book", "available book")) {
            return handleBookSearch(lowerMessage);
        } else if (containsAny(lowerMessage, "library", "location", "address", "where is")) {
            return handleLibraryQuery(lowerMessage);
        } else if (containsAny(lowerMessage, "service", "offer", "provide", "facility")) {
            return handleServicesQuery();
        } else if (containsAny(lowerMessage, "event", "program", "activity", "happening")) {
            return handleEventsQuery();
        } else if (containsAny(lowerMessage, "hour", "time", "open", "close")) {
            return handleHoursQuery(lowerMessage);
        } else if (containsAny(lowerMessage, "hi", "hello", "hey", "greetings")) {
            return new ChatResponse(
                "Hello! I'm your DSAC Library assistant. I can help you with:\n" +
                "• Finding books and checking availability\n" +
                "• Library locations and hours\n" +
                "• Library services and facilities\n" +
                "• Upcoming events and programs\n\n" +
                "What would you like to know?",
                Arrays.asList("Find a book", "Library locations", "Library services", "Upcoming events")
            );
        } else if (containsAny(lowerMessage, "thank", "thanks", "appreciate")) {
            return new ChatResponse(
                "You're welcome! Is there anything else I can help you with?",
                Arrays.asList("Find another book", "Library hours", "Contact information")
            );
        } else {
            return new ChatResponse(
                "I'm not sure I understand. I can help you with:\n" +
                "• Book searches and availability\n" +
                "• Library locations and information\n" +
                "• Services and facilities\n" +
                "• Events and programs\n\n" +
                "What would you like to know?",
                Arrays.asList("How to find a book?", "Where is the main library?", "What services do you offer?")
            );
        }
    }
    
    private ChatResponse handleBookSearch(String message) {
        // Extract book title/author from message
        String searchQuery = extractSearchQuery(message, 
            Arrays.asList("book", "find", "search", "look for", "available"));
        
        if (searchQuery.isEmpty()) {
            return new ChatResponse(
                "I'd be happy to help you find a book! What book are you looking for? " +
                "You can tell me the title, author, or subject.",
                Arrays.asList("The Great Gatsby", "Science books", "Children's books")
            );
        }
        
        List<Book> books = bookService.searchBooks(searchQuery);
        
        if (books.isEmpty()) {
            return new ChatResponse(
                "I couldn't find any books matching \"" + searchQuery + "\". " +
                "You might want to:\n" +
                "• Check the spelling\n" +
                "• Try a different keyword\n" +
                "• Browse our catalog online\n\n" +
                "Would you like to search for something else?",
                Arrays.asList("Search another book", "Browse fiction", "Browse non-fiction")
            );
        }
        
        Book book = books.get(0); // Get the first matching book
        StringBuilder response = new StringBuilder();
        
        response.append("I found \"").append(book.getTitle()).append("\" by ").append(book.getAuthor()).append(".\n\n");
        response.append("📚 **Book Details:**\n");
        response.append("• **Title:** ").append(book.getTitle()).append("\n");
        response.append("• **Author:** ").append(book.getAuthor()).append("\n");
        response.append("• **Publisher:** ").append(book.getPublisher()).append("\n");
        
        if (book.getPublishedDate() != null) {
            response.append("• **Published:** ").append(
                new java.text.SimpleDateFormat("yyyy").format(book.getPublishedDate())).append("\n");
        }
        
        response.append("• **Available Copies:** ").append(book.getAvailableCopies()).append(" of ").append(book.getTotalCopies()).append("\n\n");
        
        if (book.getAvailableCopies() > 0) {
            response.append("✅ **This book is available!** You can:\n");
            response.append("• Reserve it online\n");
            response.append("• Visit your nearest library to borrow it\n");
            
            // Get libraries that have this book
            List<Library> libraries = bookService.getLibrariesForBook(book.getBookId());
            if (!libraries.isEmpty()) {
                response.append("• Available at: ");
                for (int i = 0; i < Math.min(libraries.size(), 3); i++) {
                    if (i > 0) response.append(", ");
                    response.append(libraries.get(i).getName());
                }
                if (libraries.size() > 3) {
                    response.append(" and ").append(libraries.size() - 3).append(" more");
                }
            }
        } else {
            response.append("❌ **Currently checked out.** You can:\n");
            response.append("• Place a hold for when it's returned\n");
            response.append("• Check back in a few days\n");
            response.append("• Ask about similar books\n");
        }
        
        return new ChatResponse(
            response.toString(),
            Arrays.asList("Reserve this book", "Find similar books", "Library locations", "Search another book")
        );
    }
    
    private ChatResponse handleLibraryQuery(String message) {
        // Extract library name from message
        String searchQuery = extractSearchQuery(message, 
            Arrays.asList("library", "where is", "location", "address"));
        
        List<Library> libraries = libraryService.getAllLibraries();
        
        if (libraries.isEmpty()) {
            return new ChatResponse(
                "I don't have information about our libraries at the moment. " +
                "Please check our website or contact us for library locations.",
                Arrays.asList("Contact information", "Main library", "Services")
            );
        }
        
        if (searchQuery.isEmpty()) {
            // General library information
            StringBuilder response = new StringBuilder();
            response.append("We have ").append(libraries.size()).append(" libraries across the region:\n\n");
            
            for (Library library : libraries) {
                response.append("🏛️ **").append(library.getName()).append("**\n");
                response.append("📍 ").append(library.getAddress()).append("\n");
                if (library.getHours() != null) {
                    response.append("🕒 ").append(library.getHours()).append("\n");
                }
                response.append("\n");
            }
            
            response.append("Which library would you like more information about?");
            
            List<String> quickReplies = new ArrayList<>();
            for (Library library : libraries) {
                quickReplies.add(library.getName());
            }
            quickReplies.add("Library services");
            quickReplies.add("Contact information");
            
            return new ChatResponse(response.toString(), quickReplies);
        } else {
            // Specific library search
            for (Library library : libraries) {
                if (library.getName().toLowerCase().contains(searchQuery.toLowerCase())) {
                    StringBuilder response = new StringBuilder();
                    response.append("🏛️ **").append(library.getName()).append("**\n\n");
                    response.append("📍 **Address:** ").append(library.getAddress()).append("\n");
                    
                    if (library.getPhone() != null) {
                        response.append("📞 **Phone:** ").append(library.getPhone()).append("\n");
                    }
                    
                    if (library.getEmail() != null) {
                        response.append("📧 **Email:** ").append(library.getEmail()).append("\n");
                    }
                    
                    if (library.getHours() != null) {
                        response.append("🕒 **Hours:** ").append(library.getHours()).append("\n");
                    }
                    
                    return new ChatResponse(
                        response.toString(),
                        Arrays.asList("Get directions", "Library services", "Events at this library", "Other libraries")
                    );
                }
            }
            
            return new ChatResponse(
                "I couldn't find a library matching \"" + searchQuery + "\". " +
                "Here are our libraries:\n\n" +
                getLibraryList(libraries),
                getLibraryQuickReplies(libraries)
            );
        }
    }
    
    private ChatResponse handleServicesQuery() {
        return new ChatResponse(
            "📚 **Our Library Services:**\n\n" +
            "• **Book Borrowing** - Borrow books, audiobooks, and more\n" +
            "• **Digital Resources** - E-books, online databases, digital magazines\n" +
            "• **Research Assistance** - Help with research and information finding\n" +
            "• **Computer & Internet Access** - Free computer and WiFi access\n" +
            "• **Printing & Copying** - Affordable printing and copying services\n" +
            "• **Study Spaces** - Quiet areas for studying and research\n" +
            "• **Children's Programs** - Story times, reading programs, activities\n" +
            "• **Adult Education** - Literacy programs, computer classes\n" +
            "• **Community Events** - Workshops, author talks, cultural events\n\n" +
            "Which service are you interested in?",
            Arrays.asList("Book borrowing", "Digital resources", "Computer access", "Children's programs", "Study spaces")
        );
    }
    
    private ChatResponse handleEventsQuery() {
        List<Event> events = eventService.getUpcomingEvents(5);
        
        if (events.isEmpty()) {
            return new ChatResponse(
                "There are no upcoming events at the moment. " +
                "Check back later or visit our events page for updates!",
                Arrays.asList("Library services", "Find a book", "Library locations")
            );
        }
        
        StringBuilder response = new StringBuilder();
        response.append("📅 **Upcoming Events:**\n\n");
        
        for (Event event : events) {
            response.append("• **").append(event.getTitle()).append("**\n");
            response.append("  📍 ").append(event.getLocation()).append("\n");
            response.append("  🕒 ").append(event.getFormattedDate());
            if (event.getFormattedTime() != null && !event.getFormattedTime().isEmpty()) {
                response.append(" at ").append(event.getFormattedTime());
            }
            response.append("\n\n");
        }
        
        response.append("Would you like more information about any of these events?");
        
        List<String> quickReplies = new ArrayList<>();
        for (Event event : events) {
            quickReplies.add(event.getTitle());
        }
        quickReplies.add("More events");
        quickReplies.add("Library services");
        
        return new ChatResponse(response.toString(), quickReplies);
    }
    
    private ChatResponse handleHoursQuery(String message) {
        List<Library> libraries = libraryService.getAllLibraries();
        
        StringBuilder response = new StringBuilder();
        response.append("🕒 **Library Hours:**\n\n");
        
        for (Library library : libraries) {
            response.append("🏛️ **").append(library.getName()).append("**\n");
            if (library.getHours() != null) {
                response.append(library.getHours()).append("\n");
            } else {
                response.append("Hours not specified\n");
            }
            response.append("\n");
        }
        
        response.append("Hours may vary on holidays. Contact the library for specific holiday hours.");
        
        return new ChatResponse(
            response.toString(),
            Arrays.asList("Contact information", "Library locations", "Services")
        );
    }
    
    // Utility methods
    private boolean containsAny(String text, String... terms) {
        for (String term : terms) {
            if (text.contains(term)) {
                return true;
            }
        }
        return false;
    }
    
    private String extractSearchQuery(String message, List<String> excludeTerms) {
        String query = message;
        for (String term : excludeTerms) {
            query = query.replace(term, "");
        }
        return query.trim();
    }
    
    private String getLibraryList(List<Library> libraries) {
        StringBuilder list = new StringBuilder();
        for (Library library : libraries) {
            list.append("• ").append(library.getName()).append("\n");
        }
        return list.toString();
    }
    
    private List<String> getLibraryQuickReplies(List<Library> libraries) {
        List<String> replies = new ArrayList<>();
        for (int i = 0; i < Math.min(libraries.size(), 5); i++) {
            replies.add(libraries.get(i).getName());
        }
        replies.add("Library services");
        return replies;
    }
    
    // Inner class for chat responses
    private static class ChatResponse {
        private final String message;
        private final List<String> quickReplies;
        
        public ChatResponse(String message, List<String> quickReplies) {
            this.message = message;
            this.quickReplies = quickReplies;
        }
        
        public String getMessage() { return message; }
        public List<String> getQuickReplies() { return quickReplies; }
    }
}