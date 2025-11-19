<%-- views/search-results.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - DSAC Libraries</title>
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
                    <li><a href="${pageContext.request.contextPath}/catalog" class="active">Catalog</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
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
        <div class="search-header">
            <h1>Library Catalog</h1>
            
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-form" style="max-width: 600px; margin: 2rem auto;">
                <div class="search-field">
                    <i class="fas fa-search"></i>
                    <input type="search" name="q" value="${searchQuery}" placeholder="Search books, authors, subjects..." required>
                    <select name="scope">
                        <option value="all" ${searchScope == 'all' ? 'selected' : ''}>All Libraries</option>
                        <c:forEach var="library" items="${libraries}">
                            <option value="${library.libraryId}" ${searchScope == library.libraryId ? 'selected' : ''}>${library.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn-primary">Search</button>
                </div>
            </form>

            <c:if test="${not empty searchQuery}">
                <div class="search-results-info">
                    <h2>Search Results for "${searchQuery}"</h2>
                    <p>Found ${fn:length(searchResults)} results</p>
                </div>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty searchResults}">
                <div class="books-grid">
                    <c:forEach var="book" items="${searchResults}">
                        <div class="book-card">
                            <img src="${not empty book.coverImage ? book.coverImage : 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=60'}" alt="${book.title}">
                            <div class="book-body">
                                <h4>${book.title}</h4>
                                <p class="author">by ${book.author}</p>
                                <p class="small muted">${book.publisher} • <fmt:formatDate value="${book.publishedDate}" pattern="yyyy" /></p>
                                <c:if test="${book.availableCopies > 0}">
                                    <span class="badge">Available (${book.availableCopies})</span>
                                </c:if>
                                <c:if test="${book.availableCopies == 0}">
                                    <span class="badge" style="background: #f44336;">Checked Out</span>
                                </c:if>
                            </div>
                            <div class="book-actions">
                                <a href="${pageContext.request.contextPath}/book/detail?id=${book.bookId}" class="btn-sm">View Details</a>
                                <c:if test="${book.availableCopies > 0}">
                                    <a href="${pageContext.request.contextPath}/reserve?bookId=${book.bookId}" class="btn-sm outline">Reserve</a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            
            <c:when test="${not empty searchQuery}">
                <div class="no-results" style="text-align: center; padding: 3rem;">
                    <i class="fas fa-search" style="font-size: 3rem; color: var(--muted); margin-bottom: 1rem;"></i>
                    <h3>No Books Found</h3>
                    <p>We couldn't find any books matching "${searchQuery}". Try different keywords or browse our categories.</p>
                    <a href="${pageContext.request.contextPath}/catalog" class="btn-primary" style="margin-top: 1rem;">Browse All Books</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="featured-categories">
                    <h2>Browse Categories</h2>
                    <div class="categories-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 2rem 0;">
                        <a href="${pageContext.request.contextPath}/search?q=fiction" class="category-card">
                            <i class="fas fa-book"></i>
                            <span>Fiction</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/search?q=non-fiction" class="category-card">
                            <i class="fas fa-globe"></i>
                            <span>Non-Fiction</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/search?q=science" class="category-card">
                            <i class="fas fa-flask"></i>
                            <span>Science</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/search?q=history" class="category-card">
                            <i class="fas fa-landmark"></i>
                            <span>History</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/search?q=children" class="category-card">
                            <i class="fas fa-child"></i>
                            <span>Children</span>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
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
</body>
</html>