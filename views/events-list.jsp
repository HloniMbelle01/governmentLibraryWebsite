<%-- views/events-list.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events - DSAC Libraries</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <a class="brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/images/Screenshot 2025-09-05 094525.png" alt="DSAC Logo" class="brand-logo">
            </a>
            <nav class="nav">
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/libraries">Our Libraries</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalog">Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/events" class="active">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">services</a></li>
                    <li><a href="${pageContext.request.contextPath}/kids-teens">Kids & Teens</a></li>
                </ul>
            </nav>
            <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation">
        <i class="fas fa-bars"></i>
      </button>
      <div>
        <img src="${pageContext.request.contextPath}/images/images (3).jpeg" alt="SA flag" class="brand-logo">
      </div>
        </div>
    </header>

    <main class="container" style="padding-top: 120px; padding-bottom: 60px;">
        <div class="section-head">
            <h1>Upcoming Events</h1>
            <p class="section-sub">Join our community programs, workshops and cultural events across Limpopo</p>
        </div>

        <div class="events-filter" style="margin-bottom: 2rem;">
            <select id="libraryFilter" onchange="filterEvents()" style="padding: 10px; border: 1px solid #ddd; border-radius: 8px;">
                <option value="all">All Libraries</option>
                <c:forEach var="library" items="${libraries}">
                    <option value="${library.libraryId}" ${filteredLibrary == library.libraryId ? 'selected' : ''}>${library.name}</option>
                </c:forEach>
            </select>
        </div>

        <c:choose>
            <c:when test="${not empty events}">
                <div class="events-list">
                    <c:forEach var="event" items="${events}">
                        <div class="event-card detailed" data-library="${event.library.libraryId}">
                            <div class="event-date">
                                <span><fmt:formatDate value="${event.eventDate}" pattern="dd" /></span>
                                <fmt:formatDate value="${event.eventDate}" pattern="MMM" />
                            </div>
                            <div class="event-details">
                                <h3>${event.title}</h3>
                                <p class="event-description">${event.description}</p>
                                <div class="event-meta">
                                    <span><i class="fas fa-clock"></i> <fmt:formatDate value="${event.eventTime}" pattern="h:mm a" /></span>
                                    <span><i class="fas fa-map-marker-alt"></i> ${event.location}</span>
                                    <span><i class="fas fa-building"></i> ${event.library.name}</span>
                                </div>
                            </div>
                            <div class="event-actions">
                                <a href="#" class="btn-sm">Register</a>
                                <a href="#" class="btn-sm outline">Add to Calendar</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="no-results" style="text-align: center; padding: 3rem;">
                    <i class="fas fa-calendar-times" style="font-size: 3rem; color: var(--muted); margin-bottom: 1rem;"></i>
                    <h3>No Upcoming Events</h3>
                    <p>There are currently no scheduled events. Please check back later for updates.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="events-calendar" style="margin-top: 4rem;">
            <h2>Events Calendar</h2>
            <div class="calendar-placeholder" style="background: #f8f9fa; padding: 2rem; text-align: center; border-radius: 12px;">
                <i class="fas fa-calendar-alt" style="font-size: 2rem; color: var(--muted); margin-bottom: 1rem;"></i>
                <p>Interactive calendar view coming soon</p>
            </div>
        </div>
    </main>

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
    <script>
        function filterEvents() {
            const libraryId = document.getElementById('libraryFilter').value;
            if (libraryId === 'all') {
                window.location.href = '${pageContext.request.contextPath}/events';
            } else {
                window.location.href = '${pageContext.request.contextPath}/events?libraryId=' + libraryId;
            }
        }
    </script>
</body>
</html>