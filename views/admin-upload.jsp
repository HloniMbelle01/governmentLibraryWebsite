<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Upload - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 100px auto 50px;
            padding: 0 2rem;
        }
        
        .upload-section {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .upload-section h3 {
            color: var(--green-700);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--yellow);
            padding-bottom: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--green-800);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--green-500);
        }
        
        .btn-upload {
            background: var(--green-700);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .btn-upload:hover {
            background: var(--green-800);
        }
        
        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .tab-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .tab {
            padding: 1rem 2rem;
            background: #f8f9fa;
            border: none;
            border-radius: 8px 8px 0 0;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .tab.active {
            background: var(--green-700);
            color: white;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .tab-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header class="site-header" id="top">
        <div class="container header-inner">
            <a class="brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="DSAC Logo" class="brand-logo">
            </a>
            <nav class="nav">
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/upload" class="active">Admin Upload</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="admin-container">
        <h1>Admin Upload Tool</h1>
        <p class="muted">Add new content to the DSAC Library database</p>

        <c:if test="${not empty message}">
            <div class="message ${success ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>

        <div class="tab-container">
            <button class="tab active" onclick="openTab('books')">Add Book</button>
            <button class="tab" onclick="openTab('libraries')">Add Library</button>
            <button class="tab" onclick="openTab('news')">Add News</button>
            <button class="tab" onclick="openTab('events')">Add Event</button>
            <button class="tab" onclick="openTab('services')">Add Service</button>
        </div>

        <!-- Books Tab -->
        <div id="books" class="tab-content active">
            <div class="upload-section">
                <h3><i class="fas fa-book"></i> Add New Book</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/upload">
                    <input type="hidden" name="action" value="add_book">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="book_title">Book Title *</label>
                            <input type="text" id="book_title" name="title" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="book_author">Author *</label>
                            <input type="text" id="book_author" name="author" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="book_isbn">ISBN</label>
                            <input type="text" id="book_isbn" name="isbn" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label for="book_publisher">Publisher</label>
                            <input type="text" id="book_publisher" name="publisher" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="book_published_date">Published Date</label>
                            <input type="date" id="book_published_date" name="published_date" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label for="book_category">Category</label>
                            <input type="text" id="book_category" name="category" class="form-control" placeholder="e.g., African Literature, Fiction">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="book_total_copies">Total Copies</label>
                            <input type="number" id="book_total_copies" name="total_copies" class="form-control" value="1" min="1">
                        </div>
                        
                        <div class="form-group">
                            <label for="book_cover_image">Cover Image URL</label>
                            <input type="url" id="book_cover_image" name="cover_image" class="form-control" 
                                   placeholder="https://example.com/image.jpg">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="book_description">Description</label>
                        <textarea id="book_description" name="description" class="form-control" rows="4" 
                                  placeholder="Enter book description..."></textarea>
                    </div>
                    
                    <button type="submit" class="btn-upload">
                        <i class="fas fa-upload"></i> Add Book
                    </button>
                </form>
            </div>
        </div>

        <!-- Libraries Tab -->
        <div id="libraries" class="tab-content">
            <div class="upload-section">
                <h3><i class="fas fa-building"></i> Add New Library</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/upload">
                    <input type="hidden" name="action" value="add_library">
                    
                    <div class="form-group">
                        <label for="library_name">Library Name *</label>
                        <input type="text" id="library_name" name="name" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="library_address">Address *</label>
                        <textarea id="library_address" name="address" class="form-control" rows="3" required></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="library_phone">Phone</label>
                            <input type="tel" id="library_phone" name="phone" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label for="library_email">Email</label>
                            <input type="email" id="library_email" name="email" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="library_hours">Operating Hours</label>
                            <input type="text" id="library_hours" name="hours" class="form-control" 
                                   placeholder="e.g., Mon-Fri: 8am-6pm, Sat: 9am-1pm">
                        </div>
                        
                        <div class="form-group">
                            <label for="library_image_url">Library Image URL</label>
                            <input type="url" id="library_image_url" name="image_url" class="form-control">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-upload">
                        <i class="fas fa-upload"></i> Add Library
                    </button>
                </form>
            </div>
        </div>

        <!-- News Tab -->
        <div id="news" class="tab-content">
            <div class="upload-section">
                <h3><i class="fas fa-newspaper"></i> Add News Article</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/upload">
                    <input type="hidden" name="action" value="add_news">
                    
                    <div class="form-group">
                        <label for="news_title">News Title *</label>
                        <input type="text" id="news_title" name="title" class="form-control" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="news_publish_date">Publish Date</label>
                            <input type="date" id="news_publish_date" name="publish_date" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label for="news_expiry_date">Expiry Date</label>
                            <input type="date" id="news_expiry_date" name="expiry_date" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="news_content">Content *</label>
                        <textarea id="news_content" name="content" class="form-control" rows="6" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" name="is_active" value="true" checked> Active
                        </label>
                    </div>
                    
                    <button type="submit" class="btn-upload">
                        <i class="fas fa-upload"></i> Add News
                    </button>
                </form>
            </div>
        </div>

        <!-- Events Tab -->
        <div id="events" class="tab-content">
            <div class="upload-section">
                <h3><i class="fas fa-calendar-alt"></i> Add New Event</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/upload">
                    <input type="hidden" name="action" value="add_event">
                    
                    <div class="form-group">
                        <label for="event_title">Event Title *</label>
                        <input type="text" id="event_title" name="title" class="form-control" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="event_date">Event Date *</label>
                            <input type="date" id="event_date" name="event_date" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="event_time">Event Time</label>
                            <input type="time" id="event_time" name="event_time" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="event_location">Location *</label>
                        <input type="text" id="event_location" name="location" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="event_library_id">Associated Library (Optional)</label>
                        <select id="event_library_id" name="library_id" class="form-control">
                            <option value="">-- Select Library --</option>
                            <!-- Libraries would be populated dynamically in a real application -->
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="event_description">Description</label>
                        <textarea id="event_description" name="description" class="form-control" rows="4"></textarea>
                    </div>
                    
                    <button type="submit" class="btn-upload">
                        <i class="fas fa-upload"></i> Add Event
                    </button>
                </form>
            </div>
        </div>

        <!-- Services Tab -->
        <div id="services" class="tab-content">
            <div class="upload-section">
                <h3><i class="fas fa-concierge-bell"></i> Add New Service</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/upload">
                    <input type="hidden" name="action" value="add_service">
                    
                    <div class="form-group">
                        <label for="service_name">Service Name *</label>
                        <input type="text" id="service_name" name="name" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="service_description">Description *</label>
                        <textarea id="service_description" name="description" class="form-control" rows="4" required></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="service_icon_class">Icon Class</label>
                            <input type="text" id="service_icon_class" name="icon_class" class="form-control" 
                                   placeholder="e.g., fas fa-book-reader">
                            <small>Use Font Awesome icon classes</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="service_page_link">Page Link</label>
                            <input type="text" id="service_page_link" name="page_link" class="form-control" 
                                   placeholder="e.g., book-lending.html">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" name="is_active" value="true" checked> Active
                        </label>
                    </div>
                    
                    <button type="submit" class="btn-upload">
                        <i class="fas fa-upload"></i> Add Service
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openTab(tabName) {
            // Hide all tab contents
            var tabContents = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove('active');
            }
            
            // Remove active class from all tabs
            var tabs = document.getElementsByClassName('tab');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            
            // Show the selected tab content and mark tab as active
            document.getElementById(tabName).classList.add('active');
            event.currentTarget.classList.add('active');
        }
        
        // Set today's date as default for date fields
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('book_published_date').value = today;
            document.getElementById('news_publish_date').value = today;
            document.getElementById('event_date').value = today;
        });
    </script>
</body>
</html>