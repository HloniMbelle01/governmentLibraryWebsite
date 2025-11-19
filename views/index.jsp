<%-- views/index.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>DSAC Libraries — Limpopo</title>

  <!-- Google Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/serviceCards.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css">
  
</head>
<body>
<!-- NAV -->
<header class="site-header" id="top">
    <div class="container header-inner">
        <a class="brand" href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
        </a>

        <nav class="nav" id="mainNav">
            <ul class="nav-list">
                <li><a href="#home">Home</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">Districts <i class="fas fa-chevron-down"></i></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Capricorn">Capricorn District</a></li>
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Sekhukhune">Sekhukhune District</a></li>
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Waterburg">Waterburg District</a></li>
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Mopani">Mopani District</a></li>
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Vhembe">Vhembe District</a></li>
                        <li><a href="${pageContext.request.contextPath}/libraries?district=Tzaneen">Tzaneen District</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/libraries">Our Libraries</a></li>
                <li><a href="${pageContext.request.contextPath}/catalog">Catalog</a></li>
                <li><a href="${pageContext.request.contextPath}/Events">Events</a></li>
                <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
            </ul>
        </nav>

        <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation">
            <i class="fas fa-bars"></i>
        </button>
        <div>
            <img src="${pageContext.request.contextPath}/images/download.png" alt="SA flag" class="brand-logo">
        </div>
    </div>
</header>

  <!-- HERO with search -->
  <section id="home" class="hero">
    <div class="container hero-grid">
      <div class="hero-left">
        <h1>Welcome to Department of Sport, Arts and Culture Library.</h1>
        <p class="lead">Explore collections, events and digital learning across Limpopo municipal libraries.</p>

        <form id="searchForm" class="search-form" action="${pageContext.request.contextPath}/search" method="get" role="search" aria-label="Search library catalog">
          <div class="search-field">
            <i class="fas fa-search"></i>
            <input id="searchInput" name="q" type="search" placeholder="Search books, authors, subjects or libraries..." aria-label="Search" required>
            <select id="searchScope" name="scope" aria-label="Select scope">
              <option value="all">All Libraries</option>
              <c:forEach var="library" items="${libraries}">
                <option value="${library.libraryId}">${library.name}</option>
              </c:forEach>
            </select>
            <button type="submit" class="btn-primary">Search</button>
          </div>
          <div class="search-hint">Try: "African folktales", "Digital literacy", "Children's storytime"</div>
        </form>
        <div id="searchResults" class="search-results"></div>

        <div class="hero-cta">
          <a class="btn-ghost" href="${pageContext.request.contextPath}/libraries">Find a Branch</a>
          <a class="btn-ghost" href="${pageContext.request.contextPath}/Events">Upcoming Events</a>
        </div>
      </div>

      <div class="hero-right">
        <div class="hero-card">
          <div class="hc-header">
            <div>
              <span class="badge">New</span>
              <h3>Digital Library — Now Live</h3>
            </div>
            <img alt="ebooks" src="https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=300&q=60">
          </div>
          <p class="muted">Access eBooks, audiobooks and remote learning tools free for members. Sign up at any branch.</p>
          <div class="mini-stats">
            <div><strong>12k+</strong><small>e-resources</small></div>
            <div><strong>${fn:length(libraries)}</strong><small>Branches</small></div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- NEWS & ANNOUNCEMENTS -->
  <section class="section container" id="news">
    <div class="section-head">
      <h2>Latest News & Announcements</h2>
      <p class="section-sub">Important updates and highlights from across our network</p>
    </div>

    <div class="cards-grid" id="newsGrid">
      <c:forEach var="news" items="${latestNews}">
        <article class="card news-card">
          <time datetime="${news.publishDate}">
            <fmt:formatDate value="${news.publishDate}" pattern="MMM dd, yyyy" />
          </time>
          <h3>${news.title}</h3>
          <p>${fn:substring(news.content, 0, 150)}${fn:length(news.content) > 150 ? '...' : ''}</p>
          <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.newsId}" class="read-more">Read more</a>
        </article>
      </c:forEach>
    </div>
  </section>

  <!-- OUR LIBRARIES -->
  <section id="libraries" class="section alt-bg">
    <div class="container">
      <div class="section-head">
        <h2>Our Libraries</h2>
        <p class="section-sub">Find your nearest library branch with services tailored for your community</p>
      </div>

      <div class="cards-grid">
        <c:forEach var="library" items="${libraries}" end="2">
          <div class="card branch-card">
            <img src="${library.imageUrl}" alt="${library.name}">
            <div class="card-body">
              <h3>${library.name}</h3>
              <div class="meta">
                <span><i class="fas fa-map-marker-alt"></i> ${library.address}</span>
                <span><i class="fas fa-clock"></i> ${library.hours}</span>
                <span><i class="fas fa-phone"></i> ${library.phone}</span>
              </div>
              <div class="card-actions">
                
                <a href="${pageContext.request.contextPath}/library/services?id=${library.libraryId}" class="btn-sm">View Details</a>
                <a href="tel:${library.phone}" class="btn-sm outline">Call</a>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <div class="view-more-container" style="text-align: center; margin-top: 3rem;">
        <a href="${pageContext.request.contextPath}/libraries" class="view-more-btn">
          <span>View All Libraries</span>
          <i class="fas fa-arrow-right"></i>
        </a>
        <p class="small" style="margin-top: 1rem; color: var(--muted);">Discover all ${fn:length(libraries)} DSAC library branches across Limpopo</p>
      </div>
    </div>
  </section>

  <!-- BOOKS & CATALOG -->
  <section id="books" class="section container">
    <div class="section-head">
      <h2>Featured Books</h2>
      <p class="section-sub">Discover new arrivals and popular titles across our collections</p>
    </div>

    <div class="books-grid" id="booksGrid">
      <c:forEach var="book" items="${featuredBooks}">
        <div class="book-card" data-book-id="${book.bookId}">
          <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" alt="${book.title}">
          <div class="book-body">
            <h4>${book.title}</h4>
            <p class="muted">by ${book.author}</p>
            <c:if test="${book.availableCopies > 0}">
              <span class="badge">Available</span>
            </c:if>
            <c:if test="${book.availableCopies == 0}">
              <span class="badge" style="background: #f44336;">Checked Out</span>
            </c:if>
          </div>
          <div class="book-actions">
            <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">Details</a>
            <c:if test="${book.availableCopies > 0}">
              <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-sm outline">Reserve</a>
            </c:if>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- EVENTS -->
  <section id="events" class="section alt-bg">
    <div class="container">
      <div class="section-head">
        <h2>Upcoming Events</h2>
        <p class="section-sub">Join our community programs, workshops and cultural events</p>
      </div>

      <div class="events-grid">
        <c:forEach var="event" items="${upcomingEvents}">
          <div class="event-card">
            <div class="event-date">
              <span><fmt:formatDate value="${event.eventDate}" pattern="dd" /></span>
              <fmt:formatDate value="${event.eventDate}" pattern="MMM" />
            </div>
            <div>
              <h3>${event.title}</h3>
              <p class="muted small">${event.location} • <fmt:formatDate value="${event.eventTime}" pattern="h:mm a" /></p>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </section>

  <!-- SERVICES -->
  <section id="services" class="section container">
    <div class="section-head">
      <h2>Our Services</h2>
      <p class="section-sub">Comprehensive library services for all ages and needs</p>
    </div>

    <div class="services-grid">
      <c:forEach var="service" items="${services}">
        <div class="service" data-link="${service.pageLink}">
          <i class="${service.iconClass}"></i>
          <h4>${service.name}</h4>
          <p>${service.description}</p>
          <a href="${pageContext.request.contextPath}/${service.pageLink}" class="hover-btn">Learn More</a>
        </div>
      </c:forEach>
    </div>
  </section>
  <script>
            // =============== SERVICE CARD CLICK HANDLER ===============
      document.querySelectorAll('.service').forEach(service => {
        service.addEventListener('click', (e) => {
          const link = service.getAttribute('data-link');
          // Avoid duplicate redirect when button is clicked
          if (!e.target.classList.contains('hover-btn')) {
            window.location.href = link;
          }
        });
      });

  </script>
  
<%-- Add to your main template or include in pages --%>
<div id="chatbotWidget" class="chatbot-widget">
    <div class="chatbot-header">
        <h4>DSAC Library Assistant</h4>
        <button id="chatbotToggle" class="chatbot-toggle">
            <i class="fas fa-robot"></i>
        </button>
    </div>
    
    <div id="chatbotBody" class="chatbot-body hidden">
        <div id="chatMessages" class="chat-messages">
            <div class="message bot-message">
                <div class="message-content">
                    Hi! I'm your DSAC Library assistant. How can I help you today? 
                    You can ask me about books, libraries, services, or events!
                </div>
            </div>
        </div>
        
        <div class="chat-input-container">
            <input type="text" id="chatInput" placeholder="Ask about books, libraries, services..." 
                   class="chat-input">
            <button id="sendMessage" class="send-button">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>
  
<%-- Server-side alert in your JSP --%>
<c:if test="${not empty upcomingEvents}">
    <div id="eventAlert" class="alert-banner show">
        <div class="alert-content">
            <span class="alert-icon">📅</span>
            <span id="eventAlertText">
                <a href="${pageContext.request.contextPath}/events" style="color: inherit; text-decoration: none;">
                    ${upcomingEvents[0].title} on 
                    <fmt:formatDate value="${upcomingEvents[0].eventDate}" pattern="MMM dd"/>
                    <c:if test="${not empty upcomingEvents[0].location}">
                        at ${upcomingEvents[0].location}
                    </c:if>
                    — Click to see all upcoming events
                </a>
            </span>
            <button id="closeAlert" class="alert-close">&times;</button>
        </div>
    </div>

    <script>
        // Event Alert Close Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const eventAlert = document.getElementById('eventAlert');
            const closeAlert = document.getElementById('closeAlert');
            
            if (closeAlert && eventAlert) {
                closeAlert.addEventListener('click', function() {
                    eventAlert.classList.remove('show');
                    setTimeout(() => {
                        eventAlert.classList.add('hidden');
                    }, 400);
                });
                
                // Auto-hide after 10 seconds
                setTimeout(() => {
                    if (eventAlert.classList.contains('show')) {
                        eventAlert.classList.remove('show');
                        setTimeout(() => {
                            eventAlert.classList.add('hidden');
                        }, 400);
                    }
                }, 10000);
            }
        });
    </script>
</c:if>

  <!-- FOOTER -->
  <footer class="site-footer enhanced-footer">
    <div class="floating-shapes">
      <div class="shape"></div>
      <div class="shape"></div>
      <div class="shape"></div>
    </div>

    <div class="container">
      <div class="footer-grid footer-section">
        <div class="footer-brand">
          <div class="footer-logo mb-3">
            <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
          </div>
          <p class="small text-light">Promoting literacy, learning and cultural development across Limpopo through accessible library services.</p>
          
          <div class="social-links">
            <a href="#" class="social-link facebook" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-link twitter" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-link instagram" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-link youtube" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
          </div>
        </div>

        <div>
          <h4 class="footer-title">Quick Links</h4>
          <ul class="footer-links list-unstyled">
            <li><a href="#home" class="footer-link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/libraries" class="footer-link">Find a Library</a></li>
            <li><a href="${pageContext.request.contextPath}/catalog" class="footer-link">Catalog</a></li>
            <li><a href="#events" class="footer-link">Events</a></li>
            <li><a href="#services" class="footer-link">Services</a></li>
          </ul>
        </div>

        <div>
          <h4 class="footer-title">Contact Info</h4>
          <div class="footer-links">
            <div class="contact-item">
              <i class="fas fa-phone contact-icon"></i>
              <a href="tel:+27151234567" class="footer-link">(015) 123 4567</a>
            </div>
            <div class="contact-item">
              <i class="fas fa-envelope contact-icon"></i>
              <a href="mailto:info@dsaclibraries.gov.za" class="footer-link">info@dsaclibraries.gov.za</a>
            </div>
            <div class="contact-item">
              <i class="fas fa-clock contact-icon"></i>
              <span class="footer-link">Mon-Fri: 8:00 AM - 5:00 PM</span>
            </div>
          </div>
        </div>

        <div class="footer-map">
          <h4 class="footer-title">Visit Us</h4>
          <div class="map-container mb-3">
            <iframe 
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3586.234567890123!2d29.12345678901234!3d-23.90123456789012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1ec6d987654321ab%3A0xabcdef1234567890!2s21%20Biccard%20St%2C%20Polokwane%20Central%2C%20Polokwane%2C%200700!5e0!3m2!1sen!2sza!4v1234567890123!5m2!1sen!2sza" 
              width="100%" 
              height="200" 
              style="border:0; border-radius: 12px;" 
              allowfullscreen="" 
              loading="lazy" 
              referrerpolicy="no-referrer-when-downgrade">
            </iframe>
          </div>
          <div class="contact-item">
            <i class="fas fa-map-marker-alt contact-icon"></i>
            <span class="footer-link">21 Biccard St, Polokwane Central, Polokwane, 0700</span>
          </div>
        </div>
      </div>

      <hr class="footer-divider">

      <div class="footer-bottom footer-section">
        <div class="footer-bottom-content">
          <p class="small mb-2">&copy; 2025 DSAC Libraries — Limpopo. All rights reserved.</p>
          <div class="footer-bottom-links">
            <a href="#" class="muted">Privacy Policy</a>
            <a href="#" class="muted">Terms of Use</a>
            <a href="#" class="muted">Accessibility</a>
            <a href="#" class="muted">Sitemap</a>
          </div>
        </div>
      </div>
    </div>
  </footer>

   <!-- Scroll to Top Button -->
<a href="#top" class="scroll-top" id="scrollTop">
  <i class="fas fa-chevron-up"></i>
</a>

<!-- WhatsApp FAQ Button -->
<a href="https://wa.me/27151234567?text=Hi,%20I%20have%20a%20question%20about%20DSAC%20Libraries" 
   class="whatsapp-faq" 
   target="_blank" 
   rel="noopener noreferrer"
   aria-label="Chat with us on WhatsApp">
  <i class="fab fa-whatsapp"></i>
  <span class="whatsapp-tooltip">FAQ Chat</span>
</a>

  <!-- Back to top -->
  <a href="#top" class="back-to-top" id="backToTop" aria-label="Back to top">
    <i class="fas fa-chevron-up"></i>
  </a>
            
  <!-- JavaScript files -->
      <%-- In your index.jsp file 
<script>
    // Pass upcoming events data from server to client
    window.upcomingEvents = [
        <c:forEach var="event" items="${upcomingEventswithin}" varStatus="status">
        {
            eventId: ${event.eventId},
            title: "${fn:escapeXml(event.title)}",
            eventDate: "${event.eventDate}",
            location: "${fn:escapeXml(event.location)}",
            library: {
                <c:if test="${not empty event.library}">
                name: "${fn:escapeXml(event.library.name)}"
                </c:if>
            }
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>
  <script src="${pageContext.request.contextPath}/js/Alert.js"></script>--%>
  
<script>
    // Chatbot functionality
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM loaded - initializing chatbot');
        
        const chatbotToggle = document.getElementById('chatbotToggle');
        const chatbotBody = document.getElementById('chatbotBody');
        const chatInput = document.getElementById('chatInput');
        const sendButton = document.getElementById('sendMessage');
        const chatMessages = document.getElementById('chatMessages');

        console.log('Chatbot elements:', {
            toggle: chatbotToggle,
            body: chatbotBody,
            input: chatInput,
            sendButton: sendButton,
            messages: chatMessages
        });

        // Toggle chatbot visibility
        chatbotToggle.addEventListener('click', function() {
            console.log('Toggle button clicked');
            console.log('Before toggle - hidden class:', chatbotBody.classList.contains('hidden'));
            
            chatbotBody.classList.toggle('hidden');
            
            console.log('After toggle - hidden class:', chatbotBody.classList.contains('hidden'));
            
            // Focus on input when opening
            if (!chatbotBody.classList.contains('hidden')) {
                setTimeout(() => {
                    chatInput.focus();
                }, 300);
            }
        });

        // Also make the entire header clickable to toggle
        document.querySelector('.chatbot-header').addEventListener('click', function(e) {
            if (e.target === this || e.target.tagName === 'H4') {
                chatbotToggle.click();
            }
        });

        // Send message function
        function sendMessage() {
            const message = chatInput.value.trim();
            if (message) {
                console.log('Sending message:', message);
                
                // Add user message
                addMessage(message, 'user');
                chatInput.value = '';

                // Show typing indicator
                showTypingIndicator();

                // Send to backend
                fetch('${pageContext.request.contextPath}/chat', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'message=' + encodeURIComponent(message)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Received response:', data);
                    removeTypingIndicator();
                    addMessage(data.response, 'bot');
                    
                    // Add quick replies if available
                    if (data.quickReplies && data.quickReplies.length > 0) {
                        addQuickReplies(data.quickReplies);
                    }
                })
                .catch(error => {
                    console.error('Chat error:', error);
                    removeTypingIndicator();
                    addMessage('Sorry, I encountered an error. Please try again.', 'bot');
                });
            }
        }

        // Send message on button click
        sendButton.addEventListener('click', sendMessage);

        // Send message on Enter key
        chatInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        // Add message to chat
        function addMessage(content, sender) {
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}-message`;
            
            const contentDiv = document.createElement('div');
            contentDiv.className = 'message-content';
            contentDiv.textContent = content;
            
            messageDiv.appendChild(contentDiv);
            chatMessages.appendChild(messageDiv);
            
            // Scroll to bottom
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        // Show typing indicator
        function showTypingIndicator() {
            const typingDiv = document.createElement('div');
            typingDiv.className = 'message bot-message typing-indicator';
            typingDiv.id = 'typingIndicator';
            
            for (let i = 0; i < 3; i++) {
                const dot = document.createElement('div');
                dot.className = 'typing-dot';
                typingDiv.appendChild(dot);
            }
            
            chatMessages.appendChild(typingDiv);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        // Remove typing indicator
        function removeTypingIndicator() {
            const typingIndicator = document.getElementById('typingIndicator');
            if (typingIndicator) {
                typingIndicator.remove();
            }
        }

        // Add quick reply buttons
        function addQuickReplies(replies) {
            const quickRepliesDiv = document.createElement('div');
            quickRepliesDiv.className = 'quick-replies';
            
            replies.forEach(reply => {
                const button = document.createElement('button');
                button.className = 'quick-reply';
                button.textContent = reply;
                button.addEventListener('click', function() {
                    chatInput.value = reply;
                    sendMessage();
                });
                quickRepliesDiv.appendChild(button);
            });
            
            chatMessages.appendChild(quickRepliesDiv);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        console.log('Chatbot initialized successfully');
    });
</script>
<script>
// Mobile dropdown functionality
document.addEventListener('DOMContentLoaded', function() {
    const dropdowns = document.querySelectorAll('.dropdown');
    
    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector('.dropdown-toggle');
        
        if (toggle) {
            toggle.addEventListener('click', function(e) {
                if (window.innerWidth <= 768) {
                    e.preventDefault();
                    dropdown.classList.toggle('active');
                }
            });
        }
    });
    
    // Close dropdowns when clicking outside
    document.addEventListener('click', function(e) {
        if (window.innerWidth <= 768) {
            if (!e.target.closest('.dropdown')) {
                dropdowns.forEach(dropdown => {
                    dropdown.classList.remove('active');
                });
            }
        }
    });
});
</script>
  <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>